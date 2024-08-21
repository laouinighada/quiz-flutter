import 'package:flutter/material.dart';

class ProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212932),
      appBar: AppBar(
        title: Text('Programme'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildHeaderSection(),
              SizedBox(height: 20.0),
              _buildSection(
                title: 'Profil Utilisateur',
                content:
                    'Gérez votre profil utilisateur, mettez à jour vos informations personnelles et consultez votre historique de participation.',
                icon: Icons.person,
              ),
              _buildSection(
                title: 'Scanner QR pour les Questions',
                content:
                    'Utilisez cette fonctionnalité pour scanner les codes QR et obtenir les questions des sessions et des activités.',
                icon: Icons.qr_code_scanner,
              ),
              _buildSection(
                title: 'Définition des Fonctionnalités de l\'Application',
                content:
                    'Découvrez toutes les fonctionnalités disponibles dans l\'application pour maximiser votre expérience événementielle.',
                icon: Icons.apps,
              ),
              _buildSection(
                title: 'Badge Utilisateur avec QR Code',
                content:
                    'Générez et affichez votre badge utilisateur avec un code QR contenant vos informations personnelles pour un accès facile aux événements.',
                icon: Icons.badge,
              ),
              _buildSection(
                title: 'Vidéo à la Demande (VOD)',
                content:
                    'Accédez à une bibliothèque de vidéos à la demande pour revoir les sessions passées et enrichir vos connaissances.',
                icon: Icons.video_library,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Text(
          'Bienvenue dans notre application événementielle',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.0),
        Text(
          'Cette application vous guide à travers divers événements et activités.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required String content, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF2A2E3D),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: Colors.amber, size: 40.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
