class TodoModel {
  int? id;
  DateTime? createdAt;
  final String title;
  final String description;
  final String categories;
  final DateTime deadline;
  String? userId;
  final int priority;
  bool isActive;

  TodoModel({
    this.id,
    this.createdAt,
    required this.title,
    required this.description,
    required this.categories,
    required this.deadline,
    this.userId,
    required this.priority,
    required this.isActive,
  });

  // Convert JSON to TodoModel
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      title: json['title'] as String,
      description: json['description'] as String,
      categories: json['categories'] as String,
      deadline: DateTime.parse(json['deadline']),
      userId: json['userId'] as String?,
      priority: json['priority'] as int,
      isActive: json['isActive'] as bool,
    );
  }

  // Convert  to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categories': categories,
      'deadline': deadline.toIso8601String(),
      'priority': priority,
    };
  }

  // CopyWith method to create a modified copy of the object
  TodoModel copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    String? description,
    String? categories,
    DateTime? deadline,
    String? userId,
    int? priority,
    bool? isActive,
  }) {
    return TodoModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      deadline: deadline ?? this.deadline,
      userId: userId ?? this.userId,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
    );
  }
}
