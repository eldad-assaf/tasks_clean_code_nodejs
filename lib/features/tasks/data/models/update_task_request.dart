class UpdateTaskRequest {
  final String id;
  final String? newName;
  final bool? completed;
  UpdateTaskRequest({
    required this.id,
    required this.newName,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {'id': this.id, 'name': this.newName, 'completed': this.completed};
  }
}
