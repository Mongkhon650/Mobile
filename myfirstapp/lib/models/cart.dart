/*
import 'item.dart';

class CartItem {
  final Shirt shirt;
  final ShirtSize selectedSize;
  final ShirtColor selectedColor;
  final int quantity;

  CartItem({
    required this.shirt,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });

  // คำนวณราคาโดยคูณกับจำนวนสินค้า
  double get totalPrice => shirt.getDiscountedPrice() * quantity;
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    _items.add(item);
  }

  void removeItem(CartItem item) {
    _items.remove(item);
  }

  void clearCart() {
    _items.clear();
  }

  double get totalCartPrice {
    return _items.fold(0.0, (total, item) => total + item.totalPrice);
  }
}
*/