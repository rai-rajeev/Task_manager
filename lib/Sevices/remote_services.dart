
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/task_data.dart';

class RemoteServices{
  final reference=FirebaseFirestore.instance;
  Stream<List<TaskData>> getTasks(String id) {
    return reference.collection('users').doc(id).collection('tasks').snapshots().map(
            (event) =>
            event.docs.map((doc) => TaskData.fromJson(doc.data())).toList());
  }

  Future<void> setTask(String id, TaskData task) async {
    final DocumentSnapshot docSnap =
    await reference.collection('users/$id/tasks').doc(task.id).get();
    if (!docSnap.exists) {
      try {
        reference
            .collection('users/$id/tasks')
            .doc(task.id)
            .set(task.toJson())
            .catchError((e) => throw Exception('$e'));
      } on FirebaseException catch (e) {
        throw Exception('$e');
      } catch (e) {
        rethrow;
      }
    }
  }
  Future<void> updateTask(String id, Map<String, dynamic> upd,String messageId) async {
    try {
      reference
          .collection('users')
          .doc(id).collection('tasks').doc(messageId)
          .update(upd)
          .catchError((e) => throw Exception('$e'));
    } on FirebaseException catch (e) {
      throw Exception('$e');
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteSingleTask(String id,String messageId)async {
    try {
      FirebaseFirestore.instance.collection('users').doc(id).collection('tasks').doc(messageId).delete()
          .catchError((e) => throw Exception('$e'));
    }catch(e){
      rethrow;
    }
  }

}