class DataTask {
  final int id;
  final String name;
  final int total;
  final List<TaskModel> data;
  DataTask({required this.id, required this.name, required this.total, required this.data});

  factory DataTask.fromJson(Map<String, dynamic> json) => DataTask(
      id: json['id'],
      name: json['name'],
      total: json['total'],
      data: List.from(json['data'].map((task) => TaskModel.fromModel(task))));
}

class TaskModel {
  final int id;
  final String name;
  final int done;

  TaskModel({required this.id, required this.name, required this.done});

  factory TaskModel.fromModel(Map<String, dynamic> json) =>
      TaskModel(id: json['id'], name: json['name'], done: json['done']);
}
