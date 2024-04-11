import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*

This database stores ports that users have published in the app.
It is stored in a collection called "Ports" in Firebase

Each post contains;
- a message 
- email of user
- timestamp

*/

class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collections of posts from Firebase
  final CollectionReference post =
    FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
      .collection('Posts')
      .orderBy('TimeStamp', descending: true)
      .snapshots();

    return postStream;
  }
}