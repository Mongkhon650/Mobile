import 'package:flutter/material.dart';

class CartItem {
  final int productId;
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

class NewCart with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(CartItem item) {
    // ตรวจสอบว่าสินค้านี้อยู่ในตะกร้าแล้วหรือไม่
    final existingItemIndex = _items.indexWhere((i) => i.productId == item.productId);

    if (existingItemIndex >= 0) {
      // หากมีสินค้าอยู่ในตะกร้าแล้ว เพิ่มจำนวน
      _items[existingItemIndex].quantity += item.quantity;
    } else {
      // หากยังไม่มีสินค้าในตะกร้า เพิ่มใหม่
      _items.add(item);
    }
    notifyListeners();
  }

  void updateItemQuantity(CartItem item, int newQuantity) {
    final itemIndex = _items.indexWhere((i) => i.productId == item.productId);

    if (itemIndex >= 0 && newQuantity > 0) {
      _items[itemIndex].quantity = newQuantity;
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    _items.removeWhere((i) => i.productId == item.productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
}
