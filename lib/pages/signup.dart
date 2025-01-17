import 'package:flutter/material.dart';
import 'package:penny_pilot/Services/auth_service.dart';
import 'package:penny_pilot/database/db_user.dart';
import 'package:penny_pilot/pages/login.dart';
import 'package:penny_pilot/utils/appvalidate.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phonenoController = TextEditingController();
  final _passwordController = TextEditingController();

  var authService = AuthService();
  bool _isPasswordVisible = false;

  // Submit form data
  Future<void> _submitForm() async {
    if (_formkey.currentState!.validate()) {
      var data = {
        "username": _usernameController.text,
        "email": _emailController.text,
        "phoneno": _phonenoController.text,
        "password": _passwordController.text,
      };


      await DatabaseUser.instance.insertUser(data);  

      // Simulate user creation (e.g., Firebase or another auth service)
      await authService.createUser(data, context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  "Create New Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: "Username"),
                  validator: Appvalidate().validateUsername,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: Appvalidate().validateEmail,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phonenoController,
                  decoration: InputDecoration(labelText: "Phone No."),
                  validator: Appvalidate().validatePhoneNo,
                ),
                  
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: Appvalidate().isEmptyCheck,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Create Account"),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
