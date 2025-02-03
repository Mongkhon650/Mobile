import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myfirstapp/utils/config.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<dynamic> favoriteItems = [];
  int userId = 1; // ควรใช้ userId จากระบบ Login จริง
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    if (userId == 0) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/api/get-favorites?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print("📌 API Response: $result"); // Debug เช็คค่าจาก API

        if (result['success'] == true && result.containsKey('favorites')) {
          setState(() {
            favoriteItems = result['favorites'];
            isLoading = false;
            hasError = false;
          });
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Fetch Favorites Error: $e");
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Products")),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // กำลังโหลด
          : hasError
          ? Center(child: Text("เกิดข้อผิดพลาดในการโหลดข้อมูล"))
          : favoriteItems.isEmpty
          ? Center(child: Text("ไม่มีสินค้าใน Favorite"))
          : RefreshIndicator(
        onRefresh: _fetchFavorites, // ดึงข้อมูลใหม่เมื่อ Refresh
        child: ListView.builder(
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoriteItems[index];

            return Card(
              margin: EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              child: ListTile(
                leading: Image.network(item['image'],
                    width: 50, height: 50, fit: BoxFit.cover),
                title: Text(item['name']),
                subtitle: Text("฿${item['price']}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      _removeFromFavorites(item['product_id']),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _removeFromFavorites(int productId) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/remove-from-wishlist'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': userId, 'product_id': productId}),
      );

      if (response.statusCode == 200) {
        _fetchFavorites(); // โหลดข้อมูลใหม่หลังจากลบสินค้า
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("ลบสินค้าออกจาก Favorite สำเร็จ")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เกิดข้อผิดพลาดในการลบสินค้า")),
      );
    }
  }
}
