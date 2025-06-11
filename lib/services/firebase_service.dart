import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> _userContactsRef(
      String uid) {
    return _firestore.collection('users').doc(uid).collection('contacts');
  }

  static Future<List<Contact>> fetchContacts(String uid) async {
    final snapshot = await _userContactsRef(uid).get();
    return snapshot.docs.map((doc) => Contact.fromJson(doc.data())).toList();
  }

  static Future<void> addContact(String uid, Contact contact) async {
    await _userContactsRef(uid).doc(contact.id).set(contact.toJson());
  }

  static Future<void> updateContact(String uid, Contact contact) async {
    await _userContactsRef(uid).doc(contact.id).update(contact.toJson());
  }

  static Future<void> deleteContact(String uid, String id) async {
    await _userContactsRef(uid).doc(id).delete();
  }
}
