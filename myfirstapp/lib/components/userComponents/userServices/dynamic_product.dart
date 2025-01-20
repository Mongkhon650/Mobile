import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myfirstapp/models/new_cart.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../page/userPages/cart_page.dart';

class DynamicProductPage extends StatefulWidget {
  final int productId;

  const DynamicProductPage({Key? key, required this.productId})
      : super(key: key);

  @override
  _DynamicProductPageState createState() => _DynamicProductPageState();
}

class _DynamicProductPageState extends State<DynamicProductPage> {
  Map<String, dynamic>? _product;
  bool _isLoading = true;
  

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/get-product/${widget.productId}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _product = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // ฟังก์ชันสำหรับแสดง Dialog เลือกจำนวนสินค้า
  Future<void> _showQuantityDialog(BuildContext context, int? maxStock) async {
    // ตรวจสอบว่า maxStock มีค่า null หรือไม่
    if (maxStock == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock information is unavailable.')),
      );
      return;
    }

    int quantity = 1;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('เลือกจำนวนสินค้า'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('สต็อกคงเหลือ: $maxStock'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (quantity < maxStock) {
                            setState(() {
                              quantity++;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ยกเลิก'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    // เพิ่มสินค้าในตะกร้าตามจำนวนที่เลือก
                    if (_product != null) {
                      final cartItem = CartItem(
                        productId:
                            _product!['product_id'], // ตรวจสอบคีย์ที่ถูกต้อง
                        name: _product!['name'],
                        image: _product!['image'] ?? '',
                        price: double.parse(_product!['price'].toString()),
                        quantity: quantity,
                      );

                      Provider.of<NewCart>(context, listen: false)
                          .addToCart(cartItem);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('เพิ่มสินค้า $quantity ชิ้นในตะกร้า')),
                      );
                    }
                  },
                  child: const Text('ยืนยัน'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _product == null
              ? const Center(child: Text('Product not found.'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // รูปสินค้า
                        Center(
                          child: Image.network(
                            _product?['image'] ??
                                'https://via.placeholder.com/300',
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ชื่อสินค้า
                        Text(
                          _product?['name'] ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // ราคาสินค้า
                        Text(
                          '฿${_product?['price'] ?? '0.00'}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),

// ปุ่มเพิ่มในตะกร้า
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_product != null) {
                                // ตรวจสอบ stock
                                final maxStock = _product!['stock'] ??
                                    0; // กำหนดค่าเริ่มต้นให้ 0 หาก stock เป็น null

                                if (maxStock > 0) {
                                  // เรียก dialog เพื่อเลือกจำนวนสินค้า
                                  _showQuantityDialog(context, maxStock);
                                } else {
                                  // แสดงข้อความแจ้งเตือนหากสินค้าไม่มี stock
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('สินค้าหมดสต็อก')),
                                  );
                                }
                              } else {
                                // แสดงข้อความแจ้งเตือนหาก _product เป็น null
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('ไม่สามารถโหลดข้อมูลสินค้าได้')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'เพิ่มในตะกร้า',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
} 