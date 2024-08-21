import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<profile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _practiceCityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Sauvegarder les informations du profil
      // Vous pouvez ajouter ici votre logique de sauvegarde
      print('Profile saved');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212932),
      appBar: AppBar(
        title: Text('Profil'),
      ),
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
                  controller: _firstNameController,
                  icon: Icons.person,
                  hintText: 'Nom',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _lastNameController,
                  icon: Icons.person,
                  hintText: 'Prénom',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre prénom.';
                    }
                    return null;
                  },
                ),
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
                  controller: _phoneController,
                  icon: Icons.phone,
                  hintText: 'Numéro de téléphone',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un numéro de téléphone.';
                    }
                    if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                      return 'Veuillez entrer un numéro de téléphone valide.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _cityController,
                  icon: Icons.location_city,
                  hintText: 'Ville',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre ville.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _countryController,
                  icon: Icons.flag,
                  hintText: 'Pays',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre pays.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _specialityController,
                  icon: Icons.school,
                  hintText: 'Spécialité',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre spécialité.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _experienceController,
                  icon: Icons.work,
                  hintText: 'Ancienneté',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre ancienneté.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextFormField(
                  controller: _practiceCityController,
                  icon: Icons.location_city,
                  hintText: 'Ville d\'exercice',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre ville d\'exercice.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text('Sauvegarder'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
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
