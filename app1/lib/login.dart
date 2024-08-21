import 'package:app1/api/api.dart';
import 'package:app1/forgetPassword.dart';
import 'package:app1/home.dart';
import 'package:app1/navigation.dart';
import 'package:app1/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

final loginKey = GlobalKey<FormState>();
TextEditingController emailC = TextEditingController();
TextEditingController passwordC = TextEditingController();

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

bool isLoggingIn = false;

Future<void> login(BuildContext context) async {
  if (isLoggingIn) return; // Éviter les connexions multiples
  setState(() {
    isLoggingIn = true;
  });

  print("Attempting to login...");
  print("Login: ${emailC.text.trim()}");
  print("Password: ${passwordC.text.trim()}");

  try {
    var result = await Api.loginUser(
      email: emailC.text.trim(),
      password: passwordC.text.trim(),
    );

    if (result.containsKey('role')) {
      Fluttertoast.showToast(msg: 'Connexion réussie');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => navigation()), // Remplacez 'Navigation' par le widget de votre page de destination
      );
    } else {
      Fluttertoast.showToast(msg: 'Erreur : ${result['message']}');
    }
  } catch (e) {
    print("Login error: $e"); // Journalisation détaillée des erreurs
    Fluttertoast.showToast(msg: 'Erreur : ${e.toString()}');
  } finally {
    setState(() {
      isLoggingIn = false;
    });
  }
}

void setState(Null Function() param0) {}

class _loginscreenState extends State<loginscreen> {
  bool isEmailCorrect = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212932),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 70),
                Form(
                  key: loginKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 70,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                isEmailCorrect = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
                              });
                            },
                            controller: emailC,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'L\'adresse email ne peut pas être vide';
                              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Entrez une adresse email valide';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              suffixIcon: isEmailCorrect == false
                                  ? Icon(Icons.done, color: Colors.transparent)
                                  : Icon(Icons.done, color: Color.fromARGB(255, 8, 219, 8)),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: SizedBox(
                                  width: 60,
                                  child: Icon(Icons.email, color: Colors.amber),
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelText: "Email",
                              hintText: "Username@gmail.com",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: isEmailCorrect == false
                                      ? Color.fromARGB(255, 230, 7, 7)
                                      : Color.fromARGB(255, 81, 219, 17),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            style: TextStyle(color: Colors.black), // Changer la couleur du texte en noir
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 70,
                          child: TextFormField(
                            obscureText: !isVisible,
                            controller: passwordC,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Le mot de passe ne peut pas être vide';
                              } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                                return 'Le mot de passe doit contenir au moins une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial (!@#\$&*~)';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? Icon(Icons.visibility, color: Colors.amber)
                                    : Icon(Icons.visibility_off, color: Colors.amber),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: SizedBox(
                                  width: 60,
                                  child: Icon(Icons.lock, color: Colors.amber),
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelText: "Password",
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            style: TextStyle(color: Colors.black), // Changer la couleur du texte en noir
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200, top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => forget()),
                      );
                    },
                    child: Text(
                      "ForgetPassword ! ",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 17,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: 55,
                    width: 364,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(81, 255, 193, 7),
                          blurRadius: 10,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (loginKey.currentState!.validate()) {
                          login(context);
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80, top: 50),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(
                          "Don't have an account!",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 50),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
