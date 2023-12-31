import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wall/Components/button.dart';
import 'package:wall/Components/text_feild.dart';

class LoginPage extends StatefulWidget {
  final Function? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async
  {
    showDialog(context: context, builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ));
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,);
        if(context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch(e)
    {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }
  void displayMessage(String message)
  {
    showDialog(context: context, builder: (context) => AlertDialog(title: Text(message),),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                //Welcome back msg
                Text(
                  "Welcome back, you've been missed",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 25),
                //email textfeild
                MyTextFeild(
                    controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false),
                //password textfield
                const SizedBox(height: 10),
                MyTextFeild(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(height: 25),

                //sign in button
                MyButton(onTap:signIn, text: 'Sign In'),
                const SizedBox(height: 15),

                //go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        widget.onTap!(); // Toggle the pages
                      },
                      child: const Text(
                        'Register now!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
