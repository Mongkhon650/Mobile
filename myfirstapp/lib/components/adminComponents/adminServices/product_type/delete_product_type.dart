import 'package:http/http.dart' as http;

class ProductTypeServiceDel {
  static Future<void> deleteProductType(int id) async {
    try {
      final response = await http.delete(Uri.parse('http://10.0.2.2:3000/api/delete-product-type/$id'));
      if (response.statusCode != 200) {
        throw Exception('เกิดข้อผิดพลาดในการลบประเภทสินค้า');
      }
    } catch (e) {
      print('Error deleting product type: $e');
      throw Exception('ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้');
    }
  }
}
