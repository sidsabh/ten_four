import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

// an api request that send location and gets back a token
const bool isLocal = false;
const String baseUrl =
    isLocal ? 'http://localhost:3000' : 'https://ten-four-sidsabh.vercel.app';

// general get with auth using types
Future<http.Response> myGet(
  String endpoint,
  Map<String, String> headers,
) async {
  return http.get(
    Uri.parse(baseUrl + endpoint),
    headers: headers,
  );
}

// post
Future<http.Response> myPost(
    {required String endpoint,
    required String body,
    required Map<String, String> headers}) async {
  return http.post(
    Uri.parse(baseUrl + endpoint),
    headers: headers,
    body: body,
  );
}
