class EventDetail {
  final String title;

  EventDetail({
    this.title,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      title: json['title'],
    );
  }
}
