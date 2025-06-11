import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/contact.dart';
import '../providers/contact_provider.dart';
import '../screens/add_edit_contact_screen.dart';
import '../screens/contact_detail.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  const ContactTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ContactProvider>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
        leading: CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.blue.shade100,
          child: Text(
            contact.name[0].toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          contact.phone,
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
        trailing: IconButton(
          icon: Icon(
            contact.isFavorite ? Icons.star : Icons.star_border,
            color: contact.isFavorite ? Colors.black : Colors.grey,
            size: 24.sp,
          ),
          tooltip: contact.isFavorite ? "Unfavorite" : "Mark as Favorite",
          onPressed: () => provider.toggleFavorite(contact),
        ),
        onTap: () => showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          builder: (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person, color: Colors.black, size: 24.sp),
                title: Text('Profile', style: TextStyle(fontSize: 16.sp)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ContactDetailScreen(contact: contact),
                    ),
                  );
                },
              ),
              const CustomDivider(),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.black, size: 24.sp),
                title: Text('Call', style: TextStyle(fontSize: 16.sp)),
                onTap: () async {
                  Navigator.pop(context);
                  await launchUrl(Uri.parse("tel:+91${contact.phone}"));
                },
              ),
              const CustomDivider(),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.black, size: 24.sp),
                title: Text('Edit', style: TextStyle(fontSize: 16.sp)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditContactScreen(contact: contact),
                    ),
                  );
                },
              ),
              const CustomDivider(),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.black, size: 24.sp),
                title: Text('Delete', style: TextStyle(fontSize: 16.sp)),
                onTap: () async {
                  Navigator.pop(context);
                  await provider.deleteContact(contact.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.grey.shade300,
    );
  }
}
