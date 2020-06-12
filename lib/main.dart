import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/firebase_auth.dart';
import 'screen/signin.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
    Widget build(BuildContext context) {

      return Provider<FirebaseMethods>(
        create: (_) => FirebaseMethods(),
        child: MaterialApp(
        title: 'Flutter auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SignIn(),
        },
      ),
     );
    }
}