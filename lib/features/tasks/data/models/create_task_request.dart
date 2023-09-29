class CreateTaskRequest {
  final String name;
  CreateTaskRequest({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
    };
  }
}
