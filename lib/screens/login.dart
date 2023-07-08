import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/widget/custom_text_input.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var phone = "";
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Image.asset(
                    'assets/verify.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                CustomTextInput(
                  textEditController: _emailController,
                  hintTextString: 'Enter Email',
                  inputType: InputType.Email,
                  enableBorder: true,
                  cornerRadius: 30.0,
                  maxLength: 24,
                  // errorMessage:,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextInput(
                  textEditController: _passwordController,
                  hintTextString: 'Enter Password',
                  inputType: InputType.Password,
                  enableBorder: true,
                  cornerRadius: 48.0,
                  maxLength: 16,
                  prefixIcon:
                      Icon(Icons.lock, color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade600,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          print("test1");
                          UserCredential user = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                          print("test");
                          if (user != null) {
                            print(email);
                            email = _emailController.text;
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              'phone',
                              (route) => false,
                            );
                          } else {
                            print('user does not exist');
                          }
                        },
                        child: Text("Login")),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade600,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'signup',
                            (route) => false,
                          );
                        },
                        child: Text("SignUP")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
