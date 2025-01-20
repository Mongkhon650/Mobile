import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DynamicProductPage extends StatefulWidget {
  final int productId; // รับ productId เป็นพารามิเตอร์เพื่อดึงข้อมูลสินค้า

  const DynamicProductPage({Key? key, required this.productId})
      : super(key: key);

  @override
  _DynamicProductPageState createState() => _DynamicProductPageState();
}

class _DynamicProductPageState extends State<DynamicProductPage> {
  Map<String, dynamic>? _product; // เก็บข้อมูลสินค้าที่ดึงมา
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  // ดึงข้อมูลสินค้าจาก API
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // เพิ่มฟังก์ชันค้นหา
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search clicked')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              // เพิ่มฟังก์ชันตะกร้าสินค้า
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart clicked')),
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
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
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
              const SizedBox(height: 8),

              // คะแนนรีวิวและจำนวนคงเหลือ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 4 // สมมุติให้คะแนนเป็น 4 ดาว
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                  Text(
                    'Stock: ${_product?['stock'] ?? 0}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // คำอธิบายสินค้า
              Text(
                _product?['description'] ??
                    'No description available.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // ปุ่มเพิ่มในตะกร้า
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // เพิ่มในตะกร้า (ยังไม่ได้เพิ่มฟังก์ชัน)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to cart!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 16,
                    ),
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
