class EventRepository {
  final String title;

  EventRepository({
    this.title,
  });

  factory EventRepository.fromJson(Map<String, dynamic> json) {
    return EventRepository(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
  };
}
