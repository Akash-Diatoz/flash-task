import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../domain/loginModel.dart';

class Util {
  Future<LogoutData> parseJsonConfig(String rawJson) async {
    final Map<String, dynamic> parsed =
        await compute(decodeJsonWithCompute, rawJson);
    final userEntity = LogoutData.fromJson(parsed);
    return userEntity;
  }

  static Map<String, dynamic> decodeJsonWithCompute(String rawJson) {
    return jsonDecode(rawJson);
  }
}
