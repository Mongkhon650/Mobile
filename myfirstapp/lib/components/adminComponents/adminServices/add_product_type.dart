import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // นำเข้า image_picker
import 'dart:io'; // สำหรับจัดการไฟล์

class AddCategoryPage extends StatefulWidget {
  final Function(String name, String imagePath) onAddCategory;

  const AddCategoryPage({required this.onAddCategory});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage; // เก็บไฟล์รูปภาพที่เลือก

  final ImagePicker _imagePicker = ImagePicker(); // สร้างอินสแตนซ์ image_picker

  // ฟังก์ชันสำหรับเลือกรูปภาพจากแกลเลอรี่
  Future<void> _pickImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path); // บันทึก path ของรูปภาพที่เลือก
      });
    } else {
      // กรณีที่ผู้ใช้ยกเลิกการเลือกรูปภาพ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ไม่ได้เลือกรูปภาพ')),
      );
    }
  }

  void _showConfirmDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)), // มุมโค้งด้านบน
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ให้ Column ปรับขนาดตามเนื้อหา
            children: [
              const Text(
                'ยืนยันการเพิ่มข้อมูล',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'คุณต้องการเพิ่มประเภทนี้ใช่หรือไม่?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // ปิด Bottom Sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('ยกเลิก'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onAddCategory(_nameController.text, _selectedImage?.path ?? '');
                      Navigator.pop(context); // ปิด Bottom Sheet
                      Navigator.pop(context); // กลับไปหน้า Admin Panel
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('ยืนยัน'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('เพิ่มประเภท'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ชื่อประเภท', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'กรอกชื่อประเภทสินค้า',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage, // เรียกใช้ฟังก์ชันเลือกรูปภาพ
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty && _selectedImage != null) {
                    _showConfirmDialog();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Text(
                  'เพิ่มประเภท',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
