class Notification {
  final String id;
  final String userId;
  final String type;
  final String content;
  final DateTime date;
  final bool isRead;

  Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.content,
    required this.date,
    required this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'content': content,
      'date': date.toIso8601String(),
      'isRead': isRead,
    };
  }
}

