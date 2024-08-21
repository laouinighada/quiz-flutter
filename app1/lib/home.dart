import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart'; // Importer uni_links pour gérer les liens
import 'dart:async';
import 'quiz.dart';

void main() {
  runApp(MonApp());
}

class MonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application de Quiz',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Color(0xFF212932),
        appBarTheme: AppBarTheme(
          color: Colors.amber,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.amber),
        ),
      ),
      onGenerateRoute: _onGenerateRoute,
      home: Home(), // Page d'accueil pour générer le QR code
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/quiz') {
      return MaterialPageRoute(builder: (context) => PageQuiz());
    }
    return null; // Gérer les autres routes si nécessaire
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String quizUrl = "myapp://quiz"; 

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scannez le code QR pour accéder au quiz',
                style: TextStyle(fontSize: 20, color: Colors.amber),
              ),
              SizedBox(height: 20),
              FutureBuilder<MemoryImage>(
                future: _generateQRCode(quizUrl),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Image(image: snapshot.data!, width: 200, height: 200);
                    } else if (snapshot.hasError) {
                      return Text('Erreur lors de la génération du QR code', style: TextStyle(color: Colors.white));
                    }
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<MemoryImage> _generateQRCode(String data) async {
    final qrCode = QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: false,
    );

    final picData = await qrCode.toImageData(200);
    final buffer = picData!.buffer.asUint8List();

    return MemoryImage(buffer);
  }
}

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  Future<void> _handleIncomingLinks() async {
    // Handling app launch with a link
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _navigateToPage(initialLink);
      }
    } catch (e) {
      print('Erreur lors de la gestion du lien initial: $e');
    }

    // Handling incoming links when the app is in the foreground
    linkStream.listen((String? link) {
      if (link != null) {
        _navigateToPage(link);
      }
    });
  }

  void _navigateToPage(String link) {
    if (link == 'myapp://quiz') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageQuiz()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page d\'accueil', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
