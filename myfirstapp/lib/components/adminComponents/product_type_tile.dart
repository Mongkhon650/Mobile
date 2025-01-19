import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'adminServices/add_product_type.dart';
import 'adminServices/type_card.dart'; // ใช้งาน CategoryCard
import '../../models/category_model.dart'; // เรียกใช้ Model สำหรับจัดการข้อมูล

class ProductTypeTile extends StatefulWidget {
  @override
  _ProductTypeTileState createState() => _ProductTypeTileState();
}

class _ProductTypeTileState extends State<ProductTypeTile> {
  @override
  Widget build(BuildContext context) {
    final categoryModel = Provider.of<CategoryModel>(context); // เรียกใช้ Model

    return Center(
      child: Column(
        children: [
          Expanded(
            child: categoryModel.categories.isEmpty
                ? const Center(child: Text('ยังไม่มีประเภทสินค้า'))
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: categoryModel.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  name: categoryModel.categories[index]['name'],
                  imagePath: categoryModel.categories[index]['imagePath'],
                  onEdit: () {
                    _showEditDialog(
                      context,
                      index,
                      categoryModel.categories[index]['name'],
                          (newName) => categoryModel.editCategory(index, newName),
                    );
                  },
                  onDelete: () {
                    categoryModel.deleteCategory(index);
                  },
                );
              },
            ),
          ),
          // ปุ่มเพิ่มประเภท
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCategoryPage(
                      onAddCategory: (name, imagePath) =>
                          categoryModel.addCategory(name, imagePath),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const SizedBox(
                width: double.infinity, // ทำให้ปุ่มกว้างเต็มหน้าจอ
                child: Center(
                  child: Text(
                    'เพิ่มประเภท',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dialog สำหรับแก้ไขประเภทสินค้า
  void _showEditDialog(
      BuildContext context,
      int index,
      String currentName,
      ValueChanged<String> onEdit,
      ) {
    final TextEditingController controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('แก้ไขประเภทสินค้า'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'แก้ไขชื่อประเภทสินค้า',
            ),
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
                onEdit(controller.text); // เรียกฟังก์ชันแก้ไขจาก Model
                Navigator.pop(context);
              },
              child: const Text('บันทึก'),
            ),
          ],
        );
      },
    );
  }
}
