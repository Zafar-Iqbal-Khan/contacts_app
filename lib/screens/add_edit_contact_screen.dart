import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/contact.dart';
import '../providers/contact_provider.dart';
import '../utils/validators.dart'; // <-- Add this

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact;
  const AddEditContactScreen({super.key, this.contact});

  @override
  _AddEditContactScreenState createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name, _phone, _email;

  @override
  void initState() {
    _name = TextEditingController(text: widget.contact?.name ?? '');
    _phone = TextEditingController(text: widget.contact?.phone ?? '');
    _email = TextEditingController(text: widget.contact?.email ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.contact != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Contact' : 'Add Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: _inputDecoration('Name', Icons.person),
                validator: validateName,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _phone,
                decoration: _inputDecoration('Phone', Icons.phone),
                keyboardType: TextInputType.phone,
                validator: validatePhone,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _email,
                decoration: _inputDecoration('Email', Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                isEdit: isEdit,
                formKey: _formKey,
                widget: widget,
                name: _name,
                phone: _phone,
                email: _email,
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.blue.shade400, width: 1.5),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.isEdit,
    required GlobalKey<FormState> formKey,
    required this.widget,
    required TextEditingController name,
    required TextEditingController phone,
    required TextEditingController email,
  })  : _formKey = formKey,
        _name = name,
        _phone = phone,
        _email = email;

  final bool isEdit;
  final GlobalKey<FormState> _formKey;
  final AddEditContactScreen widget;
  final TextEditingController _name;
  final TextEditingController _phone;
  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 3,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        icon: Icon(
          isEdit ? Icons.update : Icons.add,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          isEdit ? 'Update Contact' : 'Add Contact',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final provider = context.read<ContactProvider>();
            final contact = Contact(
              id: isEdit ? widget.contact!.id : UniqueKey().toString(),
              name: _name.text.trim(),
              phone: _phone.text.trim(),
              email: _email.text.trim(),
              isFavorite: isEdit ? widget.contact!.isFavorite : false,
            );

            isEdit
                ? provider.updateContact(contact)
                : provider.addContact(contact);

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
