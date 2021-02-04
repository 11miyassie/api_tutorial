import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_tutorial/event.dart';
import 'package:api_tutorial/connpass.dart';

Future<Connpass> fetchConnpass() async {
  final response =
  await http.get('https://connpass.com/api/v1/event/?event_id=201351');

  if (response.statusCode == 200) {
    return Connpass.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('失敗');
  }
}

Future<Event> fetchEvent() async {
  final response =
  await http.get('https://connpass.com/api/v1/event/?event_id=201351');

  if (response.statusCode == 200) {
    return Event.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('失敗');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final List<Event> events;
  final String title;


  MyApp({Key key, this.events, this.title}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Connpass> futureConnpass;
  Future<Event> futureEvent;


  @override
  void initState() {
    super.initState();
    futureConnpass = fetchConnpass();
    futureEvent = fetchEvent();

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
          child: FutureBuilder<Event>(
            future: futureEvent,
            builder: (context, eventname) {
              if (eventname.hasData) {
                return Text(eventname.data.title);
              } else if (eventname.hasError) {
                return Text("${eventname.error}");
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
