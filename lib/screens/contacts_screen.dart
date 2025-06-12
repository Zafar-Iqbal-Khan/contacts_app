import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/screens/login_screen.dart';
import 'package:contacts_app/widgets/custom_slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/contact_provider.dart';
import '../screens/add_edit_contact_screen.dart';
import '../widgets/contact_tile.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = context.watch<ContactProvider>().contacts;
    final provider = Provider.of<ContactProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: SafeArea(
        child: contacts.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.contact_page,
                        size: 80, color: Colors.grey),
                    SizedBox(height: 16.h),
                    const Text(
                      'No contacts found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : SlidableAutoCloseBehavior(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: contacts.length,
                  itemBuilder: (context, i) => CustomSlidableContactTile(
                    contact: contacts[i],
                    provider: provider,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditContactScreen()),
        ),
      ),
    );
  }
}
