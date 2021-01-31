import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
  await http.get('https://connpass.com/api/v1/event/?keyword=python');

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int resultsReturned;
  final int resultsAvailable;
  final int resultsStart;
  final List<Event> events;

  Album({
    this.resultsReturned,
    this.resultsAvailable,
    this.resultsStart,
    this.events,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
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

class MyApp extends StatelessWidget {
  final Event events;
  MyApp({Key key, this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('イベント詳細'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            titlePart(),
          ],
        ),
      ),
    );
  }

  Widget titlePart () {
    print(events);
    return Container(
      child: Column(
        children: [
          Text(
            events.title,
          ),
        ],
      ),
    );
  }
}

// child: FutureBuilder<Album>(
// future: futureAlbum,
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// return Text(snapshot.data.events.title);
// } else if (snapshot.hasError) {
// return Text("${snapshot.error}");
// }
//
// // By default, show a loading spinner.
// return CircularProgressIndicator();
// },
