class TODO {
  int? id;
  int? userId;
  String? title;
  bool? completed;


  TODO({this.userId, this.id, this.title, this.completed,});

  factory TODO.fromJson(Map<String, dynamic> json) {
    return TODO(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}