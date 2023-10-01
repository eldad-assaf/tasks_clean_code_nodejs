class RemoveTaskRequest {
  final String id;
  RemoveTaskRequest({
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
    };
  }
}
