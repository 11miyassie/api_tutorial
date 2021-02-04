class Event {
  final int eventId;
  final String title;

  Event({
    this.eventId,
    this.title,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
  };
}
