import 'package:flutter/material.dart';

class FeaturedTile extends StatelessWidget {
  const FeaturedTile({super.key});

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
                'Featured',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // ไปยังหน้า FeaturedPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeaturedPage()),
                  );
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
                'No featured items available.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// หน้าเปล่า FeaturedPage
class FeaturedPage extends StatelessWidget {
  const FeaturedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Featured Page')),
      body: const Center(
        child: Text('This is the Featured Page.'),
      ),
    );
  }
}
