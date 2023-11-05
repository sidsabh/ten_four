import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// an api request that send location and gets back a token
const bool isLocal = true;
const String baseUrl =
    isLocal ? 'http://localhost:3000' : 'https://ten-four-api.herokuapp.com';

void getToken() async {
  // app.get('/rtc/:channel/:role/:tokentype/:uid', nocache , generateRTCToken)
  // ex:
  // http://localhost:3000/rtc/test/publisher/uid/1

  // get location

  // send location to api
  // get token from api
  // return token
}
