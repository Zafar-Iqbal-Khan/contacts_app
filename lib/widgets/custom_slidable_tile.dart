import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/providers/contact_provider.dart';
import 'package:contacts_app/screens/add_edit_contact_screen.dart';
import 'package:contacts_app/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSlidableContactTile extends StatelessWidget {
  const CustomSlidableContactTile({
    super.key,
    required this.contact,
    required this.provider,
  });

  final Contact contact;
  final ContactProvider provider;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(contact.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (context) async {
              await provider.deleteContact(contact.id);
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            icon: Icons.delete_outline,
            borderRadius: BorderRadius.circular(16.r),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (context) async {
              await launchUrl(Uri.parse("tel:+91${contact.phone}"));
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            icon: Icons.call_outlined,
            borderRadius: BorderRadius.circular(16.r),
            padding: EdgeInsets.zero,
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditContactScreen(contact: contact),
                ),
              );
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            icon: Icons.edit_outlined,
            borderRadius: BorderRadius.circular(16.r),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: ContactTile(contact: contact),
    );
  }
}
