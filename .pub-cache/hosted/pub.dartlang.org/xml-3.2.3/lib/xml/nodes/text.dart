library xml.nodes.text;

import 'package:xml/xml/nodes/data.dart';
import 'package:xml/xml/utils/node_type.dart';
import 'package:xml/xml/visitors/visitor.dart';

/// XML text node.
class XmlText extends XmlData {
  /// Create a text node with `text`.
  XmlText(String text) : super(text);

  @override
  XmlNodeType get nodeType => XmlNodeType.TEXT;

  @override
  dynamic accept(XmlVisitor visitor) => visitor.visitText(this);
}
