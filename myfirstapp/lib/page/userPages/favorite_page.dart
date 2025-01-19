import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/favorite_manager.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Items")),
      body: favoriteManager.favoriteItems.isEmpty
          ? const Center(child: Text('No favorite items yet.'))
          : ListView.builder(
        itemCount: favoriteManager.favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteManager.favoriteItems[index];
          return ListTile(
            title: Text(item.name),
            leading: Image.asset(item.imagePath[0]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                favoriteManager.removeFavorite(item);
              },
            ),
          );
        },
      ),
    );
  }
}
