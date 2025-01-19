import 'package:flutter/material.dart';
import 'item.dart';

class FavoriteManager extends ChangeNotifier { // สืบทอดจาก ChangeNotifier
  final List<Shirt> _favoriteItems = [];

  List<Shirt> get favoriteItems => _favoriteItems;

  void addFavorite(Shirt shirt) {
    if (!_favoriteItems.contains(shirt)) {
      _favoriteItems.add(shirt);
      notifyListeners(); // แจ้งเตือนเมื่อมีการเปลี่ยนแปลง
    }
  }

  void removeFavorite(Shirt shirt) {
    _favoriteItems.remove(shirt);
    notifyListeners(); // แจ้งเตือนเมื่อมีการเปลี่ยนแปลง
  }
}
