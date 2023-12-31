import 'package:bnotes/database/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/user.dart';

class MyDataBase{

  static CollectionReference<User> getUsersCollection(){
    return FirebaseFirestore.instance.collection(User.collectionName)
        .withConverter<User>(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }
  static CollectionReference<Task> getTasksCollection(String uid){
    return getUsersCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore:(snapshot, options) => Task.fromFireStore(snapshot.data()) ,
        toFirestore:(task, options) => task.toFireStore());
  }

  static Future<void> addUser(User user){
    var collection = getUsersCollection();
    return collection.doc(user.id).set(user);
  }
  static Future<User?> readUser(String id)async{
    var collection = getUsersCollection();
    var docSnapshot = await collection.doc(id).get();
    return docSnapshot.data();
  }
  static Future<void> addTask(String uid,Task task){
    var newTaskDoc = getTasksCollection(uid)
        .doc();
    task.id = newTaskDoc.id;
    return newTaskDoc.set(task);

  }
  static Future<QuerySnapshot<Task>>getTasks(String uId){
    return getTasksCollection(uId)
        .get();
  }
  static Stream<QuerySnapshot<Task>>getTasksRealTimeUpdate(String uId,
      ){
    return getTasksCollection(uId)
        .snapshots();
  }
  static Future<void> deleteTask(String uid,String taskId){
    return getTasksCollection(uid)
        .doc(taskId)
        .delete();
  }
  static Future<void> editNote(String uId,Task task){
    return getTasksCollection(uId).doc(task.id).update(task.toFireStore());

  }
}