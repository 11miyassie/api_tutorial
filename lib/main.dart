import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_tutorial/event_detail.dart';
import 'package:api_tutorial/connpass.dart';

Future<Connpass> fetchConnpass() async {
  final response =
  await http.get('https://connpass.com/api/v1/event/?event_id=201351');
  print('${jsonDecode(response.body)['events'][0]['title']}');

  if (response.statusCode == 200) {
    return Connpass.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('失敗');
  }
}

Future<EventDetail> fetchEventDetail() async {
  final response =
  await http.get('https://connpass.com/api/v1/event/?event_id=201351');

  if (response.statusCode == 200) {
    return EventDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('失敗');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Connpass> futureConnpass;
  Future<EventDetail> futureEventDetail;


  @override
  void initState() {
    super.initState();
    futureConnpass = fetchConnpass();
    futureEventDetail = fetchEventDetail();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'api of connpass',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('イベント詳細'),
        ),
        body: Center(
          child: FutureBuilder<EventDetail>(
            future: futureEventDetail,
            builder: (context, eventname) {
              if (eventname.hasData) {
                return Text('あ');
              } else if (eventname.hasError) {
                return Text("${eventname.error}");
              }
              // print('${jsonDecode(response.body)['events'][0]['title']}');

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
