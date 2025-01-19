import 'package:flutter/material.dart';
import 'package:myfirstapp/models/editAndDeleteButton.dart'; // เรียกใช้ปุ่มที่แยกออกมา

class CategoryCard extends StatelessWidget {
  final String name; // ชื่อประเภท
  final String? imagePath; // ที่อยู่รูปภาพ (อาจเป็น null)
  final VoidCallback onEdit; // ฟังก์ชันสำหรับแก้ไข
  final VoidCallback onDelete; // ฟังก์ชันสำหรับลบ

  const CategoryCard({
    required this.name,
    this.imagePath,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imagePath != null
              ? Image.network(
            imagePath!,
            height: 50,
            fit: BoxFit.cover,
          )
              : const Icon(Icons.image, size: 50, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // ใช้ ActionButtons แทนการเขียนปุ่มเอง
          ActionButtons(
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}
