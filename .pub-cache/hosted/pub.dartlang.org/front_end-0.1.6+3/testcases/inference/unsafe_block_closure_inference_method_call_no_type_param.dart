// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*@testedFeatures=inference*/
library test;

class C {
  double f(/*@topType=dynamic*/ x) => 1.0;
}

var /*@topType=double*/ v = new C(). /*@target=C::f*/ f(/*@returnType=int*/ () {
  return 1;
});

main() {
  v;
}
