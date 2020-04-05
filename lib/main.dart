import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'constant.dart';

void main() => runApp(SplashScreen());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp({this.casedata});

  final casedata;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF052d24),
      ),
      home: MyHomePage(
        title: 'INDIA COVID-19',
        casedata: casedata,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.casedata, this.title});

  final casedata;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String total, increasetotal;
  String activei;
  String recover, increaserecover;
  String death, increasedeath,time;
  @override
  void initState() {
    super.initState();

    updateUI(widget.casedata);
  }

  void updateUI(dynamic casedata) {
    setState(() {
      if (casedata == null) {
        total = '';
        activei = '';
        recover = '';
        death = '';
        time ='';
        increasetotal = '';
        increaserecover = '';
        increasedeath = '';
        return;
      }
      total = casedata['statewise'][0]['confirmed'];
      activei = casedata['statewise'][0]['active'];
      recover = casedata['statewise'][0]['recovered'];
      death = casedata['statewise'][0]['deaths'];
      time = casedata['statewise'][0]['lastupdatedtime'];
      increasetotal = casedata['statewise'][0]['deltaconfirmed'];
      increaserecover = casedata['statewise'][0]['deltarecovered'];
      increasedeath = casedata['statewise'][0]['deltadeaths'];
      print(total);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
             Container(
               alignment: Alignment.center,
               padding: EdgeInsets.only(top: 3.0,left: 5.0),
               margin: EdgeInsets.only(top: 3.0,left: 5.0),
               child: Text(
                  '🕒 LAST UPDATED $time ',
                  style: kTimeTextStyle,
                  textAlign: TextAlign.left,
                ),
             ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusebleContainer(
                      main: 'Total Number Of cases',
                      imageurl: 'images/virus.png',
                      number: total,
                      increased: '[ + $increasetotal ]',
                    ),
                  ),
                  Expanded(
                    child: ReusebleContainer(
                      main: 'Active cases',
                      imageurl: 'images/activecases.png',
                      number: activei,
                      increased: '[ + $increasetotal ]',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusebleContainer(
                      main: 'Recoverd',
                      imageurl: 'images/recover.png',
                      number: recover,
                      increased: '[ + $increaserecover ]',
                    ),
                  ),
                  Expanded(
                    child: ReusebleContainer(
                      main: 'Deaths',
                      imageurl: 'images/deaths.png',
                      number: death,
                      increased: '[ + $increasedeath ]',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40.0,
                left: 15.0,
                right: 15.0,
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFd4faf1),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ],
        ));
  }
}

class ReusebleContainer extends StatelessWidget {
  ReusebleContainer(
      {@required this.main,
      @required this.imageurl,
      @required this.increased,
      @required this.number});
  final String main, imageurl, number, increased;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Text(
              '$main',
              style: finalStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(imageurl, width: 100, height: 100, fit: BoxFit.fill),
          Text(
            ' ↗️ $increased ',
            style: initialStyle,
          ),
          Text(
            '$number',
            style: kTempTextStyle,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFd4faf1),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
