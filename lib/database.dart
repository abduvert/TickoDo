import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tickodo/Pages/Home.dart';

class DatabaseServ{


Future addTask(Map<String,dynamic> userTask, User? id) async{
    DocumentReference<Map<String, dynamic>> documentReference = await FirebaseFirestore.instance.collection("Incomplete Tasks").add(userTask);
    return documentReference.id;
 
  }

  
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('Incomplete Tasks');
  final CollectionReference tasks2Collection = FirebaseFirestore.instance.collection('Completed Tasks');

  Future<List<DocumentSnapshot>> searchTasks(String searchTerm) async {
  QuerySnapshot querySnapshot = await tasksCollection
      .where('title', isGreaterThanOrEqualTo: searchTerm.toLowerCase())
      .where('title', isLessThan: searchTerm.toLowerCase() + 'z')
      .get();

  QuerySnapshot querySnapshot2 = await tasks2Collection
      .where('title', isGreaterThanOrEqualTo: searchTerm.toLowerCase())
      .where('title', isLessThan: searchTerm.toLowerCase() + 'z')
      .get();

  List<DocumentSnapshot> combinedResults = [
      ...querySnapshot.docs,
      ...querySnapshot2.docs,
    ];

    return combinedResults;
}



  
  Future markCompleted(String id) async{
    DocumentSnapshot sourceDocumentSnapshot = await FirebaseFirestore.instance.collection("Incomplete Tasks").doc(id).get();
   
    if (sourceDocumentSnapshot.exists) {
    Map<String, dynamic> documentData = sourceDocumentSnapshot.data() as Map<String, dynamic>;

    await FirebaseFirestore.instance.collection("Completed Tasks").doc(id).set(documentData);
    await FirebaseFirestore.instance.collection("Incomplete Tasks").doc(id).delete();
  }

 
  }




Future<void> updateTask(String task, String id, Map<String, dynamic> newData) async {
    await FirebaseFirestore.instance
        .collection(task)
        .doc(id)  
        .set(newData);
  }

 Future<void> deleteTask(String task, String id) async {
    await FirebaseFirestore.instance
        .collection(task)
        .doc(id)
        .delete();
  } 

Stream<DocumentSnapshot<Map<String, dynamic>>> getTask(String task, String id) {
  //return FirebaseFirestore.instance.collection(task).snapshots();
   return FirebaseFirestore.instance
        .collection(task)
        .doc(id)
        .snapshots();

}

}