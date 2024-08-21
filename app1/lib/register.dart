import 'dart:convert';
import 'package:app1/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app1/api/api.dart';  // Assurez-vous d'importer votre fichier API

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _register() {
    if (_formKey.currentState!.validate()) {
      inscrire();
    }
  }

  inscrire() async {
    print("Attempting to register...");
    print("Email: ${_emailController.text.trim()}");
    print("Password: ${_passwordController.text.trim()}");

    try {
      var result = await Api.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (result['error'] == false) {
        Fluttertoast.showToast(msg: 'Compte créé avec succès');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => loginscreen()),
        );
      } else {
        Fluttertoast.showToast(msg: 'Erreur : ${result['message']}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Erreur : ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212932),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _emailController,
                  icon: Icons.email,
                  hintText: 'Adresse e-mail',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une adresse e-mail.';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                      return 'Veuillez entrer une adresse e-mail valide.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  hintText: 'Mot de passe',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _confirmPasswordController,
                  icon: Icons.lock,
                  hintText: 'Confirmer le mot de passe',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer le mot de passe.';
                    }
                    if (value != _passwordController.text) {
                      return 'Les mots de passe ne correspondent pas.';
                    }
                    return null;
                  },
                ),
                
                
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    onPressed: _register,
                    child: Text('Inscrire'),
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.amber),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear, color: Colors.grey),
          onPressed: () => controller.clear(),
        ),
      ),
      style: TextStyle(color: Colors.white),
      validator: validator,
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Login Screen'),
      ),
    );
  }
}
