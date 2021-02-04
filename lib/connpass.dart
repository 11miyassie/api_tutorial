import 'package:api_tutorial/event_detail.dart';

class Connpass {
  final int resultsReturned;
  final int resultsAvailable;
  final int resultsStart;
  final List<EventDetail> events;

  Connpass({
    this.resultsReturned,
    this.resultsAvailable,
    this.resultsStart,
    this.events,
  });

  factory Connpass.fromJson(Map<String, dynamic> json) {
    events: EventDetail.fromJson(json['events']);
    var list = json['events'] as List;
    List<EventDetail> eventsList = list.map((e) => EventDetail.fromJson(e)).toList();

    return Connpass(
        resultsReturned: json['results_returned'],
        resultsAvailable: json['results_available'],
        resultsStart: json['results_start'],
        events: json['events'],
    );
  }
}
