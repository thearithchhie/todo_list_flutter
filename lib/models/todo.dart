class Todo {
  final String? id;
  final String? title;
  final String? description;
  final bool? isTodo;

  Todo({
    this.id,
     this.title,
     this.description,
     this.isTodo,
  });

  // Convert a map to a Todo object
  factory Todo.fromMap(Map<dynamic, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isTodo: map['isTodo'] ?? false,
    );
  }

  // Convert a Todo object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isTodo': isTodo,
    };
  }
}