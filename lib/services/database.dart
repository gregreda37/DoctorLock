import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_lock/models/patient.dart';
import 'package:doc_lock/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference doctorCollection = Firestore.instance.collection("doctor_patients");

  Future updateUserData(String pain, String symptoms, int severity, String name) async {
    return await doctorCollection.document(uid).setData({
      "pain":pain,
      "symptoms": symptoms,
      "severity": severity,
      "name": name,
      "uid": uid
    });
  }
  //brew list from snapshot
  List<Patient> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Patient(
        symptoms: doc.data["symptoms"] ?? "",
        severity: doc.data["severity"] ?? 0,
        pain: doc.data["pain"] ?? "0",
        uid: doc.data['uid'] ?? "",
        name: doc.data['name'] ?? ""
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      pain: snapshot.data['pain'],
      severity: snapshot.data['severity'],
      symptoms: snapshot.data['symptoms'],
    );
  }

  // get stream
  Stream<List<Patient>> get brews {
    return doctorCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return doctorCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}