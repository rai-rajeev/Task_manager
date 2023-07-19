class TaskData{
  String id;
  String taskName;
  String taskDetail;
  String date;

  TaskData({
    required this.id,
    required this.taskName,
    required this.taskDetail,
    required this.date
  });
  factory TaskData.fromJson(Map<String,dynamic> json){
    return TaskData(
        id: json['id'],
        taskName: json['taskName'],
        taskDetail: json['taskDetail'],
        date: json['date']);

  }
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'taskName':taskName,
      'taskDetail':taskDetail,
      'date':date

    };
  }
}