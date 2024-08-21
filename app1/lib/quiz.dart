import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

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
      ),
      home: PageQuiz(),
    );
  }
}

class PageQuiz extends StatefulWidget {
  @override
  _PageQuizState createState() => _PageQuizState();
}

class _PageQuizState extends State<PageQuiz> {
  List<dynamic> _questions = [];
  bool _isLoading = true;
  String? _errorMessage;
  Map<int, List<int>> _selectedAnswers = {};
  int _currentQuestionIndex = 0;
  bool _quizCompleted = false;
  Timer? _timer;
  int _remainingTime = 10;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchQuestions() async {
    final url = 'http://localhost:3000/quiz';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> questions = json.decode(response.body);
        setState(() {
          _questions = questions;
          _isLoading = false;
          _startTimer();
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur serveur: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur réseau: $e';
        _isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingTime = 10;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _submitAnswer();
      }
    });
  }

  void _submitAnswer() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _startTimer();
      });
    } else {
      setState(() {
        _quizCompleted = true;
        _timer?.cancel();
      });
    }
  }

  void _prevQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
        _startTimer();
      }
    });
  }

  Widget _buildResult() {
    int correctAnswers = 0;
    List<String> correctAnswersList = [];

    for (var i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final correctIndexes = question['choices']
          .asMap()
          .entries
          .where((entry) => entry.value['is_correct'] == true)
          .map((entry) => entry.key)
          .toList();

      final selectedIndexes = _selectedAnswers[i] ?? [];

      if (ListEquality().equals(correctIndexes, selectedIndexes)) {
        correctAnswers++;
      }

      correctAnswersList.add(
          'Question ${i + 1}: ${correctIndexes.map((index) => question['choices'][index]['choice_text']).join(', ')}');
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz Terminé!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          SizedBox(height: 20),
          Text(
            'Vous avez obtenu $correctAnswers sur ${_questions.length} corrects!',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 20),
          ...correctAnswersList.map((answer) => Text(
                answer,
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212932),
      appBar: AppBar(
        title: Text('Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: _prevQuestion,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.amber))
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!, style: TextStyle(color: Colors.red)))
              : _quizCompleted
                  ? _buildResult()
                  : _buildQuestionCard(),
    );
  }

  Widget _buildQuestionCard() {
    final question = _questions[_currentQuestionIndex];
    final questionText = question['question_text'] ?? 'Pas de texte pour la question';
    final choices = question['choices'] as List<dynamic>? ?? [];

    return Card(
      color: Color(0xFF2A2D3E),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            ...choices.map<Widget>((choice) {
              final choiceText = choice['choice_text'] ?? 'Pas de texte pour le choix';
              final index = choices.indexOf(choice);
              final isSelected = _selectedAnswers[_currentQuestionIndex]?.contains(index) ?? false;

              return CheckboxListTile(
                title: Text(
                  choiceText,
                  style: TextStyle(
                      color: isSelected ? Colors.amber : Colors.white, fontSize: 16),
                ),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (_selectedAnswers[_currentQuestionIndex] == null) {
                      _selectedAnswers[_currentQuestionIndex] = [];
                    }
                    if (value == true) {
                      _selectedAnswers[_currentQuestionIndex]!.add(index);
                    } else {
                      _selectedAnswers[_currentQuestionIndex]!.remove(index);
                    }
                  });
                },
                activeColor: Colors.amber,
              );
            }).toList(),
            SizedBox(height: 20),
            Text(
              'Temps restant: $_remainingTime secondes',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
