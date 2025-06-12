import 'package:contacts_app/widgets/custom_slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<ContactProvider>().favorites;
    final provider = context.read<ContactProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SafeArea(
        child: favorites.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_border, size: 80, color: Colors.grey),
                    SizedBox(height: 16.h),
                    const Text(
                      'No favorites yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : SlidableAutoCloseBehavior(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  physics: const BouncingScrollPhysics(),
                  itemCount: favorites.length,
                  itemBuilder: (context, i) => CustomSlidableContactTile(
                    contact: favorites[i],
                    provider: provider,
                  ),
                ),
              ),
      ),
    );
  }
}
