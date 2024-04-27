import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class AppState with ChangeNotifier {
  String? selectedGender;
  String? selectedSentiment;
  bool isTimerActive = false;

  void selectGender(String gender) {
    selectedGender = gender;
    startTimer();
    notifyListeners();
  }

  void selectSentiment(String sentiment) {
    selectedSentiment = sentiment;
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    isTimerActive = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 10), () {
      resetSelections();
    });
  }

  void resetSelections() {
    selectedGender = null;
    selectedSentiment = null;
    isTimerActive = false;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const StatelessGenderSentimentApp(),
    ),
  );
}

class StatelessGenderSentimentApp extends StatelessWidget {
  const StatelessGenderSentimentApp({super.key}); // Made it a StatelessWidget

  @override
  Widget build(BuildContext context) {
    // Access your KioskState using Consumer
    final kioskState = Provider.of<AppState>(context);

    const Color activeGenderColor = Colors.yellow;
    const Color inactiveButtonColor = Colors.white;
    const Color activeAwfulColor = Colors.redAccent;
    const Color activeBadColor = Colors.orangeAccent;
    const Color activeGoodColor = Colors.lightBlue;
    const Color activeGreatColor = Colors.greenAccent;

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
                    onPressed: () => kioskState.selectGender('Female'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedGender == 'Female'
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
                    onPressed: () => kioskState.selectGender('Male'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedGender == 'Male'
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
                    onPressed: () => kioskState.selectGender('Non-binary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedGender == 'Non-binary'
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
                    onPressed: () => kioskState.selectSentiment('Awful'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedSentiment == 'Awful'
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
                    onPressed: () => kioskState.selectSentiment('Bad'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedSentiment == 'Bad'
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
                    onPressed: () => kioskState.selectSentiment('Good'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedSentiment == 'Good'
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
                    onPressed: () => kioskState.selectSentiment('Great'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedSentiment == 'Great'
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
