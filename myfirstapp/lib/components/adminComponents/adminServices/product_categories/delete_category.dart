import 'package:http/http.dart' as http;

class CategoryServiceDelete {
  static Future<void> deleteCategory(int id) async {
    try {
      final response = await http.delete(Uri.parse('http://10.0.2.2:3000/api/delete-category/$id'));

      if (response.statusCode != 200) {
        throw Exception('เกิดข้อผิดพลาดในการลบหมวดหมู่');
      }
    } catch (e) {
      print('Error deleting category: $e');
      throw Exception('ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้');
    }
  }
}
