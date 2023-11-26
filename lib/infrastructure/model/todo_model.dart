import 'dart:convert';

class TodoModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final String status;

  TodoModel( {
    this.id,
     this.title,
     this.description,
    this.date,
    this.status
  });

  // Convert a Breed into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date':date,
      'status':status
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() => 'TodoModel(id: $id, title: $title, description: $description,date:$date,status:$status)';
}