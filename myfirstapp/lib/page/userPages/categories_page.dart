import 'package:flutter/material.dart';
import '../../models/type_card.dart'; // Import TypeModel

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // AppBar พร้อมปุ่ม Search และ Cart
          SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // กลับไปหน้าก่อนหน้า
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // ฟังก์ชันค้นหา
                },
              ),
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {
                  // ฟังก์ชันไปหน้าตะกร้าสินค้า
                },
              ),
            ],
          ),
        ],
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // หัวข้อ "Categories"
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Categories',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              // GridView สำหรับแสดงหมวดหมู่สินค้า
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // แสดง 2 หมวดหมู่ต่อแถว
                      crossAxisSpacing: 16, // ระยะห่างแนวนอน
                      mainAxisSpacing: 16, // ระยะห่างแนวตั้ง
                      childAspectRatio: 1 / 1, // อัตราส่วนของการ์ด
                    ),
                    itemCount: typeImages.length, // จำนวนหมวดหมู่ใน typeImages
                    itemBuilder: (context, index) {
                      final TypeModel type = typeImages[index];
                      return Stack(
                        children: [
                          // รูปภาพพื้นหลัง
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              type.imageAsset ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          // ชื่อหมวดหมู่ตรงกลาง
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                  type.typeName ?? '',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
