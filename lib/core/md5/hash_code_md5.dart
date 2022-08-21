import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class HashCodeMD5 {
  String generateMd5(String input) {
    return crypto.md5.convert(utf8.encode(input)).toString();
  }
}
