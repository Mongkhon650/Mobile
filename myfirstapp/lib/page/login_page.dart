import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_button.dart';
import 'package:myfirstapp/components/my_textfield.dart';
import 'package:myfirstapp/page/home_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, left: 6),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(height: 30,),
          
          // Email textfield
          MyTextfield(
            controller: emailController, 
            labelText: "Email", 
            obscureText: false,
            showSuffixIcon: false,
          ),

          const SizedBox(height: 10,),

          // Password textfield
          MyTextfield(
            controller: passwordController, 
            labelText: "Password", 
            obscureText: true,
          ),

          const SizedBox(height: 35,),

          MyButton(
            onTap: login, 
            text: "Login"
          ),

          const SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account ?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4,),

              GestureDetector(
                onTap: widget.onTap, // เรียก togglePage
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}