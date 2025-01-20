import 'package:http/http.dart' as http;

class ProductServiceDelete {
  static Future<void> deleteProduct(int productId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:3000/api/delete-product/$productId'),
      );

      if (response.statusCode != 200) {
        throw Exception('เกิดข้อผิดพลาดในการลบสินค้า');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้');
    }
  }
}
