import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/models/new_cart.dart';
import 'package:myfirstapp/components/userComponents/cart_tile.dart';
import 'package:myfirstapp/components/my_button.dart';

import 'select_address.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewCart>(
      builder: (context, cart, child) {
        final userCart = cart.items;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.black,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            cart.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          backgroundColor: Colors.grey.shade100,
          body: Column(
            children: [
              Expanded(
                child: userCart.isEmpty
                    ? const Center(
                        child: Text("Cart is empty.."),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          final cartItem = userCart[index];
                          return MyCartTile(
                            cartItem: cartItem,
                            removeButtons: false,
                          );
                        },
                      ),
              ),
              MyButton(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectAddress(),
                    ),
                  );

                },
                text: "เลือกสถานที่ส่ง",
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
