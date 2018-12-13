// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:package_resolver/package_resolver.dart';
import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';
import 'package:shelf_packages_handler/shelf_packages_handler.dart';
import 'package:test/test.dart';

void main() {
  var dir;
  setUp(() {
    dir =
        Directory.systemTemp.createTempSync("shelf_packages_handler_test").path;
    new Directory(dir).createSync();
    new Directory("$dir/foo").createSync();
    new File("$dir/foo/foo.dart")
        .writeAsStringSync("void main() => print('in foo');");
  });

  tearDown(() {
    new Directory(dir).deleteSync(recursive: true);
  });

  group("packagesHandler", () {
    test("defaults to the current method of package resolution", () async {
      var handler = packagesHandler();
      var request = new Request(
          "GET",
          Uri.parse("http://example.com/shelf_packages_handler/"
              "shelf_packages_handler.dart"));
      var response = await handler(request);
      expect(response.statusCode, equals(200));
      expect(
          await response.readAsString(), contains("Handler packagesHandler"));
    });

    group("with a package root", () {
      var resolver;
      setUp(() => resolver = new PackageResolver.root(p.toUri(dir)));

      test("looks up a real file", () async {
        var handler = packagesHandler(resolver: resolver);
        var request =
            new Request("GET", Uri.parse("http://example.com/foo/foo.dart"));
        var response = await handler(request);
        expect(response.statusCode, equals(200));
        expect(await response.readAsString(), contains("in foo"));
      });

      test("404s for a nonexistent file", () async {
        var handler = packagesHandler(resolver: resolver);
        var request =
            new Request("GET", Uri.parse("http://example.com/foo/bar.dart"));
        var response = await handler(request);
        expect(response.statusCode, equals(404));
      });
    });

    group("with a package config", () {
      var resolver;
      setUp(() {
        resolver = new PackageResolver.config({"foo": p.toUri("$dir/foo")});
      });

      test("looks up a real file", () async {
        var handler = packagesHandler(resolver: resolver);
        var request =
            new Request("GET", Uri.parse("http://example.com/foo/foo.dart"));
        var response = await handler(request);
        expect(response.statusCode, equals(200));
        expect(await response.readAsString(), contains("in foo"));
      });

      test("404s for a nonexistent package", () async {
        var handler = packagesHandler(resolver: resolver);
        var request =
            new Request("GET", Uri.parse("http://example.com/bar/foo.dart"));
        var response = await handler(request);
        expect(response.statusCode, equals(404));
      });

      test("404s for a nonexistent file", () async {
        var handler = packagesHandler(resolver: resolver);
        var request =
            new Request("GET", Uri.parse("http://example.com/foo/bar.dart"));
        var response = await handler(request);
        expect(response.statusCode, equals(404));
      });
    });
  });

  group("packagesDirHandler", () {
    test("supports a directory at the root of the URL", () async {
      var handler = packagesDirHandler();
      var request = new Request(
          "GET",
          Uri.parse("http://example.com/packages/shelf_packages_handler/"
              "shelf_packages_handler.dart"));
      var response = await handler(request);
      expect(response.statusCode, equals(200));
      expect(
          await response.readAsString(), contains("Handler packagesHandler"));
    });

    test("supports a directory deep in the URL", () async {
      var handler = packagesDirHandler();
      var request = new Request(
          "GET",
          Uri.parse("http://example.com/foo/bar/very/deep/packages/"
              "shelf_packages_handler/shelf_packages_handler.dart"));
      var response = await handler(request);
      expect(response.statusCode, equals(200));
      expect(
          await response.readAsString(), contains("Handler packagesHandler"));
    });

    test("404s for a URL without a packages directory", () async {
      var handler = packagesDirHandler();
      var request = new Request(
          "GET",
          Uri.parse("http://example.com/shelf_packages_handler/"
              "shelf_packages_handler.dart"));
      var response = await handler(request);
      expect(response.statusCode, equals(404));
    });

    test("404s for a non-existent file within a packages directory", () async {
      var handler = packagesDirHandler();
      var request = new Request(
          "GET",
          Uri.parse("http://example.com/packages/shelf_packages_handler/"
              "non_existent.dart"));
      var response = await handler(request);
      expect(response.statusCode, equals(404));
    });
  });
}
