import 'package:flutter/material.dart';
import 'package:app1/login.dart';
class forget extends StatefulWidget {
  const forget({super.key});

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  final TextEditingController _emailController = TextEditingController();

  void _sendResetLink() {
   
    final String email = _emailController.text.trim();
    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email manquant'),
          content: Text('Veuillez saisir votre adresse email.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Lien envoyé'),
          content: Text('Un lien de réinitialisation de mot de passe a été envoyé à $email.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color(0xFF212932),

      body: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  SizedBox(height: 16.0),
                TextFormField(
  controller: _emailController,
  decoration: InputDecoration(
    prefixIcon: Icon(Icons.email, color: Colors.amber),
    // ajouter l'icône d'email à gauche du champ
    hintText: 'Adresse e-mail',
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
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
      onPressed: () => _emailController.clear(),
    ),
  ),
  style: TextStyle(color: Colors.white),
)

,
    SizedBox(height: 16.0),
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: _sendResetLink,
    child: Text('Envoyer le lien de réinitialisation'),
    style: ElevatedButton.styleFrom(
     
    ),
  ),
),


                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}