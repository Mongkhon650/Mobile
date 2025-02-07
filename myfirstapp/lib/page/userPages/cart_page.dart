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
        bool hasItems = userCart.isNotEmpty; // ตรวจสอบว่ามีสินค้าในตะกร้าหรือไม่

        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.black,
            actions: [
              if (hasItems) // แสดงปุ่มล้างตะกร้าเฉพาะเมื่อมีสินค้า
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
                child: hasItems
                    ? ListView.builder(
                  itemCount: userCart.length,
                  itemBuilder: (context, index) {
                    final cartItem = userCart[index];
                    return MyCartTile(
                      cartItem: cartItem,
                      removeButtons: false,
                    );
                  },
                )
                    : const Center(
                  child: Text("ไม่มีสินค้าอยู่ในตะกร้าของคุณ"),
                ),
              ),
              if (hasItems) // แสดงปุ่มเลือกสถานที่ส่งเฉพาะเมื่อมีสินค้าในตะกร้า
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: MyButton(
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
                ),
            ],
          ),
        );
      },
    );
  }
}
