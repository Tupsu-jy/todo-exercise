class Todo {
  final String id; // UUID string
  final String description;
  final bool isDone;

  Todo({
    required this.id,
    required this.description,
    this.isDone = false, // default value is false
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      description: json['description'] as String,
      isDone: json['is_completed'] as bool? ?? false, // handle null cas
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description, 'is_completed': isDone};
  }

  // Flexible function to create JSON with only the fields we want
  static Map<String, dynamic> createRequestJson({
    String? description,
    bool? isCompleted,
  }) {
    final Map<String, dynamic> json = {};

    if (description != null) json['description'] = description;
    if (isCompleted != null) json['is_completed'] = isCompleted;

    return json;
  }
}
