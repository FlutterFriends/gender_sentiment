import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const GenderSentimentApp());
}

class GenderSentimentApp extends StatefulWidget {
  const GenderSentimentApp({super.key});

  @override
  _GenderSentimentAppState createState() => _GenderSentimentAppState();
}

class _GenderSentimentAppState extends State<GenderSentimentApp> {
  String? selectedGender;
  String? selectedSentiment;
  Timer? timer;

  static const Color activeGenderColor = Colors.yellow;
  static const Color inactiveButtonColor = Colors.white;
  static const Color activeAwfulColor = Colors.redAccent;
  static const Color activeBadColor = Colors.orangeAccent;
  static const Color activeGoodColor = Colors.lightBlue;
  static const Color activeGreatColor = Colors.greenAccent;

  void startTimer() {
    timer = Timer(const Duration(seconds: 10), () {
      setState(() {
        selectedGender = null;
        selectedSentiment = null;
      });
    });
  }

  void selectGender(String gender) {
    if (timer?.isActive ?? false) timer!.cancel();
    setState(() {
      selectedGender = gender;
    });
    startTimer();
  }

  void selectSentiment(String sentiment) {
    if (timer?.isActive ?? false) timer!.cancel();
    setState(() {
      selectedSentiment = sentiment;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gender Sentiment Kiosk')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => selectGender('Female'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGender == 'Female'
                          ? activeGenderColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Female ', style: TextStyle(fontSize: 20)),
                        Icon(Icons.female, size: 40),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => selectGender('Male'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGender == 'Male'
                          ? activeGenderColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Male ', style: TextStyle(fontSize: 20)),
                        Icon(Icons.male, size: 40),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => selectGender('Non-binary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedGender == 'Non-binary'
                          ? activeGenderColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Non-binary ', style: TextStyle(fontSize: 20)),
                        Icon(Icons.transgender, size: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => selectSentiment('Awful'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSentiment == 'Awful'
                          ? activeAwfulColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Awful ', style: TextStyle(fontSize: 20)),
                        Text('😞', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => selectSentiment('Bad'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSentiment == 'Bad'
                          ? activeBadColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Bad ', style: TextStyle(fontSize: 20)),
                        Text('😐', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => selectSentiment('Good'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSentiment == 'Good'
                          ? activeGoodColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Good ', style: TextStyle(fontSize: 20)),
                        Text('🙂', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => selectSentiment('Great'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSentiment == 'Great'
                          ? activeGreatColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Great ', style: TextStyle(fontSize: 20)),
                        Text('😄', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
