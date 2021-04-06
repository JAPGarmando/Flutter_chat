import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final _fireStore = FirebaseFirestore.instance;
  void save({String collectionName, Map<String, dynamic> collectionValues}) {
    _fireStore.collection("messages").add(collectionValues);
  }

  Future<QuerySnapshot> getMessages() async {
    return await _fireStore.collection("messages").get();
  }

  Stream<QuerySnapshot> getMessageStream() {
    return _fireStore.collection("messages").snapshots();
  }
}
