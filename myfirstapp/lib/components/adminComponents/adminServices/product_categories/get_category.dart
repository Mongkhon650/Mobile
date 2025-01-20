import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryServiceGet {
  static Future<List<dynamic>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/get-categories'));

      if (response.statusCode == 200) {
        return json.decode(response.body); // แปลงข้อมูล JSON เป็น List
      } else {
        throw Exception('เกิดข้อผิดพลาดในการดึงข้อมูลหมวดหมู่');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้');
    }
  }
}
