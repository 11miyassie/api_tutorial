class EventRepository {
  final String title;
  final String event_url;

  EventRepository({
    this.title, this.event_url,
  });

  factory EventRepository.fromJson(Map<String, dynamic> json) {
    return EventRepository(
      title: json['title'],
      event_url: json['event_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'event_url': event_url,
  };
}
