import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String? name;
  final bool? completed;
  TaskEntity({
    this.id,
    this.name,
    this.completed,
  });
  
  @override
  List<Object?> get props => [id,name,completed];


}
