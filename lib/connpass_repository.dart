import 'package:api_tutorial/event_repository.dart';

class ConnpassRepository {
  final int resultsReturned;
  final int resultsAvailable;
  final int resultsStart;
  final List<EventRepository> events;

  ConnpassRepository({
    this.resultsReturned,
    this.resultsAvailable,
    this.resultsStart,
    this.events,
  });

  factory ConnpassRepository.fromJson(Map<String, dynamic> json) {
    return ConnpassRepository(
        resultsReturned: json['results_returned'],
        resultsAvailable: json['results_available'],
        resultsStart: json['results_start'],
        events: json['events'].map<EventRepository>((e) => EventRepository.fromJson(e)).toList()
    );
  }
}
