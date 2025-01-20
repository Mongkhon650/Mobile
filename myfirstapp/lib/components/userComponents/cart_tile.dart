import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_quantity_selector.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/models/new_cart.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  final bool removeButtons; // กำหนดให้สามารถซ่อนปุ่มได้

  const MyCartTile({
    super.key,
    required this.cartItem,
    this.removeButtons = true, // ค่าเริ่มต้นแสดงปุ่ม
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewCart>(
      builder: (context, cart, child) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 1),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          cartItem.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!removeButtons)
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: QuantitySelector(
                            quantity: cartItem.quantity,
                            onIncrement: () {
                              cart.updateItemQuantity(
                                  cartItem, cartItem.quantity + 1);
                            },
                            onDecrement: () {
                              if (cartItem.quantity > 1) {
                                cart.updateItemQuantity(
                                    cartItem, cartItem.quantity - 1);
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!removeButtons)
            Positioned(
              top: 16,
              right: 28,
              child: GestureDetector(
                onTap: () {
                  cart.removeItem(cartItem);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
