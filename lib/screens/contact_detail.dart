import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.blue.shade400,
              child: Text(
                contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '',
                style: TextStyle(fontSize: 32.sp, color: Colors.white),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              contact.name,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.grey),
              title: Text(contact.phone, style: TextStyle(fontSize: 16.sp)),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.grey),
              title: Text(contact.email, style: TextStyle(fontSize: 16.sp)),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.black, size: 24.sp),
              title: Text('Call', style: TextStyle(fontSize: 16.sp)),
              onTap: () async {
                Navigator.pop(context);
                await launchUrl(Uri.parse("tel:+91${contact.phone}"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
