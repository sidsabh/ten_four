/// -----------------------------------
///          External Packages
/// -----------------------------------

import 'package:flutter/material.dart';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'join.dart';
import 'home.dart';

const appScheme = 'tenfour';

/// -----------------------------------
///            Login Widget
/// -----------------------------------

/// -----------------------------------
///                 App
/// -----------------------------------

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({final Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _MyAppState extends State<MyApp> {
  Credentials? _credentials;
  late Auth0 auth0;

  bool isBusy = false;
  late String errorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10-4',
      home: Center(
        child:
            // isBusy ? const CircularProgressIndicator() :
            _credentials != null
                ? JoinScreen(logoutAction, _credentials?.user)
                : MyHomePage(loginAction, errorMessage),
      ),
    );
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final Credentials credentials =
          await auth0.webAuthentication(scheme: appScheme).login();

      setState(() {
        isBusy = false;
        _credentials = credentials;
      });
    } on Exception catch (e, s) {
      debugPrint('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> logoutAction() async {
    await auth0.webAuthentication(scheme: appScheme).logout();

    setState(() {
      _credentials = null;
    });
  }

  @override
  void initState() {
    super.initState();

    auth0 = Auth0('dev-b28y4sop0va1xoas.us.auth0.com',
        'KgTKTK8639hWDLi4z58LT6KyT5hvdv8q');
    errorMessage = '';
  }
}
