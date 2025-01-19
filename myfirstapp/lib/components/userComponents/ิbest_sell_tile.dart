import 'package:flutter/material.dart';

class BestSellTile extends StatelessWidget {
  const BestSellTile({super.key});

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
                'Best Sell',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // ไปยังหน้า BestSellPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BestSellPage()),
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
                'No best-selling items available.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// หน้าเปล่า BestSellPage
class BestSellPage extends StatelessWidget {
  const BestSellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Best Sell Page')),
      body: const Center(
        child: Text('This is the Best Sell Page.'),
      ),
    );
  }
}
