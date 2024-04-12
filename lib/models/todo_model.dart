class TodoModel {
  int id;
  String name;
  String? due;
  int countTask;
  int countDone;

  TodoModel(
      {required this.id,
      required this.name,
      required this.due,
      required this.countTask,
      required this.countDone});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      name: json['name'],
      due: json['due'],
      countTask: json['countTask'],
      countDone: json['countDone'],
    );
  }
}
