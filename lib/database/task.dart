class Task{
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? desc;
  Task({this.id,this.title,this.desc});

  Task.fromFireStore(Map<String,dynamic>? data):
        this(id: data?['id'],
          title: data?['title'],
          desc: data?['desc'],
      );

  Map<String,dynamic>toFireStore(){
    return {
      'id':id,
      'title':title,
      'desc':desc,
    };
  }
}