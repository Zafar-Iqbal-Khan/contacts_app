import 'contact.dart';

class PendingAction {
  final String action; // 'add', 'update', 'delete'
  final Contact contact;

  PendingAction({required this.action, required this.contact});
}
