import 'package:flutter/material.dart';

class PromotionTile extends StatelessWidget {
  const PromotionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Promotion',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // เปิดหน้า PromotionPage (สามารถเพิ่มได้ภายหลัง)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlaceholderPage()));
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 250, // ความสูงของ ListView
            child: Center(
              child: Text(
                'No promotions available.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// PlaceholderPage สำหรับการนำไปใช้งานในอนาคต
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Promotion Page")),
      body: const Center(
        child: Text("This is a placeholder page."),
      ),
    );
  }
}
