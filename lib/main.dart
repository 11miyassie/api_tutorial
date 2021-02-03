import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class Connpass {
  final int resultsReturned;
  final int resultsAvailable;
  final int resultsStart;
  final List<Event> events;

  Connpass({
    this.resultsReturned,
    this.resultsAvailable,
    this.resultsStart,
    this.events,
  });

  factory Connpass.fromJson(Map<String, dynamic> json) {
    return Connpass(
      resultsReturned: json['results_returned'],
      resultsAvailable: json['results_available'],
      resultsStart: json['results_start'],
      events: json['events'].map<Event>((e) => Event.fromJson(e)).toList()
    );
  }
}

class Event {
  final int eventId;
  final String title;

  Event({
    this.eventId,
    this.title,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['event_id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
    'event_id': eventId,
    'title': title,
  };
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final List<Event> event;

  MyApp({Key key, this.event}) : super(key: key);

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
