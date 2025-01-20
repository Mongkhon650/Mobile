import 'package:flutter/material.dart';
import 'package:myfirstapp/components/userComponents/my_drawer.dart';
import 'package:myfirstapp/components/my_searchfield.dart';
import 'package:myfirstapp/components/my_sliver_app_bar.dart';
import 'package:provider/provider.dart';
import '../../components/userComponents/my_categories.dart';
import 'package:myfirstapp/components/userComponents/userServices/dynamic_list_cate.dart';

class HomePage extends StatefulWidget {
  final String userName; // รับ userName จาก LoginPage

  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(userName: widget.userName), // ส่ง userName ไปยัง MyDrawer
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(),
        ],
        body: Container(
          color: Colors.grey.shade100,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: const [
                        MySearchfield(),
                        MyCategories(),
                        DynamicListCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
