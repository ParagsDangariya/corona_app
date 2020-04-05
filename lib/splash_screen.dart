import 'dart:async';

import 'package:flutter/material.dart';
import 'main.dart';
import 'networking.dart';

class SplashScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF46EBE1),
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future getdata() async {
    Networkhelper networkhelper =
        Networkhelper('https://api.covid19india.org/data.json');

    var casedata = await networkhelper.getnetworkData();


    return casedata;
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    var casedata = await getdata();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(
          casedata: casedata,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF46EBE1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/corona.png'),
            ),
            Text(
              'COVID-19',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
