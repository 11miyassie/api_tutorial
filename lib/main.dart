import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_tutorial/event_repository.dart';
import 'package:api_tutorial/connpass_repository.dart';

Future<ConnpassRepository> fetchConnpassRepository() async {
  final response =
  await http.get('https://connpass.com/api/v1/event/?event_id=201351');

  if (response.statusCode == 200) {
    return ConnpassRepository.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('失敗');
  }
}

Future<EventRepository> fetchEventRepository() async {
  final response =
  await http.get('https://connpass.com/api/v1/event/?event_id=201351');

  if (response.statusCode == 200) {
    return EventRepository.fromJson(jsonDecode(response.body));
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
  Future<ConnpassRepository> futureConnpassRepository;
  Future<EventRepository> futureEventRepository;

  @override
  void initState() {
    super.initState();
    futureConnpassRepository = fetchConnpassRepository();
    futureEventRepository = fetchEventRepository();
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
          child: FutureBuilder<EventRepository>(
            future: futureEventRepository,
            builder: (context, eventname) {
              if (eventname.hasData) {
                return Text(eventname.data.title.toString());
              } else if (eventname.hasError) {
                return Text("${eventname.error}");
              }
              // print('${jsonDecode(response.body)['events'][0]['title']}');
              // ${jsonDecode(eventname.data.events)}
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
