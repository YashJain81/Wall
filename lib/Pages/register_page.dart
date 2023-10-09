import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Components/button.dart';
import '../Components/text_feild.dart';

class RegisterPage extends StatefulWidget {
  final Function? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp() async
  {
    showDialog(context: context, builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ));
    //make sure passwords matches
    if(passwordTextController.text != confirmPasswordTextController.text)
    {
      Navigator.pop(context);
      displayMessage("Passwords do not match!");
      return;
    }
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text, password: passwordTextController.text);
      if(context.mounted) Navigator.pop(context);
    }
    on FirebaseAuthException catch(e)
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
                  "Let's create an account for you!",
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
                const SizedBox(height: 10),
                MyTextFeild(
                    controller: confirmPasswordTextController,
                    hintText: 'Confirm Password',
                    obscureText: true),
                const SizedBox(height: 25),

                //sign up button
                MyButton(onTap: signUp, text: 'Sign Up'),
                const SizedBox(height: 15),

                //go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        widget.onTap!(); // Toggle the pages
                      },
                      child:const Text(
                        'Login here!',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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


