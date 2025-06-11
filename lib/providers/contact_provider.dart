import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/contact.dart';
import '../models/pending_action.dart';
import '../services/local_db_service.dart';
import '../services/firebase_service.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  final List<PendingAction> _pendingActions = [];

  User? _user;

  ContactProvider() {
    _monitorConnectivity();
  }

  List<Contact> get contacts => _contacts;
  List<Contact> get favorites => _contacts.where((c) => c.isFavorite).toList();
  User? get user => _user;

  Future<void> init() async {
    await LocalDbService.initDb();
    await _autoLogin();
    if (_user != null) {
      await loadLocalContacts();
      await syncFromFirebase();
    }
  }

  Future<void> _autoLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    _user = auth.currentUser;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return;

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    _user = authResult.user;
    notifyListeners();

    await loadLocalContacts();
    await syncFromFirebase();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    _user = null;
    _contacts = [];
    notifyListeners();
  }

  Future<void> loadLocalContacts() async {
    _contacts = await LocalDbService.getAllContacts();
    notifyListeners();
  }

  Future<void> syncFromFirebase() async {
    if (!await _isConnected() || _user == null) return;

    try {
      final firebaseContacts = await FirebaseService.fetchContacts(_user!.uid);
      _contacts = firebaseContacts;

      await LocalDbService.clearAllContacts();
      for (final contact in firebaseContacts) {
        await LocalDbService.insertContact(contact);
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Sync failed: $e");
    }
  }

  Future<void> addContact(Contact contact) async {
    if (_user == null) return;

    if (await _isConnected()) {
      await FirebaseService.addContact(_user!.uid, contact);
    } else {
      _pendingActions.add(PendingAction(action: 'add', contact: contact));
    }

    await LocalDbService.insertContact(contact);
    _contacts.add(contact);
    notifyListeners();
  }

  Future<void> updateContact(Contact contact) async {
    if (_user == null) return;

    if (await _isConnected()) {
      await FirebaseService.updateContact(_user!.uid, contact);
    } else {
      _pendingActions.add(PendingAction(action: 'update', contact: contact));
    }

    await LocalDbService.updateContact(contact);
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) _contacts[index] = contact;
    notifyListeners();
  }

  Future<void> deleteContact(String id) async {
    if (_user == null) return;

    final contact = _contacts.firstWhere((c) => c.id == id);

    if (await _isConnected()) {
      await FirebaseService.deleteContact(_user!.uid, id);
    } else {
      _pendingActions.add(PendingAction(action: 'delete', contact: contact));
    }

    await LocalDbService.deleteContact(id);
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  Future<void> toggleFavorite(Contact contact) async {
    if (_user == null) return;

    final updatedContact = Contact(
      id: contact.id,
      name: contact.name,
      phone: contact.phone,
      email: contact.email,
      isFavorite: !contact.isFavorite,
    );

    if (await _isConnected()) {
      await FirebaseService.updateContact(_user!.uid, updatedContact);
    } else {
      _pendingActions
          .add(PendingAction(action: 'update', contact: updatedContact));
    }

    await LocalDbService.updateContact(updatedContact);

    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }

  Future<bool> _isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void _monitorConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _syncPendingActions();
      }
    });
  }

  Future<void> _syncPendingActions() async {
    if (_user == null) {
      debugPrint('[Sync] Skipped: User is null');
      return;
    }

    if (_pendingActions.isEmpty) {
      debugPrint('[Sync] Skipped: No pending actions');
      return;
    }

    debugPrint('[Sync] Started syncing ${_pendingActions.length} actions');

    final actions = List<PendingAction>.from(_pendingActions);
    _pendingActions.clear();

    for (final action in actions) {
      try {
        debugPrint(
            '[Sync] Processing action: ${action.action} for contact: ${action.contact.id}');
        if (action.action == 'add') {
          await FirebaseService.addContact(_user!.uid, action.contact);
          debugPrint('[Sync] Add successful for: ${action.contact.id}');
        } else if (action.action == 'update') {
          await FirebaseService.updateContact(_user!.uid, action.contact);
          debugPrint('[Sync] Update successful for: ${action.contact.id}');
        } else if (action.action == 'delete') {
          await FirebaseService.deleteContact(_user!.uid, action.contact.id);
          debugPrint('[Sync] Delete successful for: ${action.contact.id}');
        } else {
          debugPrint('[Sync] Unknown action: ${action.action}');
        }
      } catch (e) {
        debugPrint(
            '[Sync] Failed for action: ${action.action} on contact: ${action.contact.id}, error: $e');
        _pendingActions.add(action);
      }
    }

    debugPrint('[Sync] Completed');
  }
}
