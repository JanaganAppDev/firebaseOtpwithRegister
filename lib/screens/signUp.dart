import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/widget/custom_text_input.dart';

class SignUP extends StatefulWidget {
  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

/*
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print("valid");
      return;
    }else{
      print("not valid")
    }
    _formKey.currentState!.save();
  }*/

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
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
                "SignUp",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              CustomTextInput(
                validator: (val) {
                  if (val!.isEmpty) {
                    setState(() {
                      isLoading = true;
                      print("true");
                    });
                    return 'Enter valid email';
                  } else {
                    setState(() {
                      isLoading = false;
                      print("false");
                    });
                  }
                },
                textEditController: _nameController,
                hintTextString: 'Enter User name',
                inputType: InputType.Default,
                enableBorder: true,
                themeColor: Theme.of(context).primaryColor,
                cornerRadius: 48.0,
                maxLength: 24,
                prefixIcon:
                    Icon(Icons.person, color: Theme.of(context).primaryColor),
                textColor: Colors.black,
                errorMessage: 'User name cannot be empty',
                labelText: 'User Name',
              ),
              CustomTextInput(
                textEditController: _emailController,
                hintTextString: 'Enter Email',
                inputType: InputType.Email,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 24,
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
              CustomTextInput(
                textEditController: _phoneController,
                hintTextString: 'Enter Number',
                inputType: InputType.Number,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 10,
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
                        // _submit();
                        print("test1");
                        UserCredential user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        if (user != null) {
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(_emailController.text)
                              .set({
                            'FullName': _nameController.text,
                            'MobileNumber': _phoneController.text,
                            'Email': _emailController.text,
                          });
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'login',
                            (route) => false,
                          );
                        } else {
                          print('user does not exist');
                        }
                      },
                      child: Text("Register")),
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
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'login',
                          (route) => false,
                        );
                      },
                      child: Text("Login")),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
