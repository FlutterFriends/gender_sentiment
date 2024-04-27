import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

enum Gender {
  female,
  male,
  nonBinary,
}

enum Sentiment {
  awful,
  bad,
  good,
  great,
}

final genderDisplayValues = {
  Gender.male: 'Male',
  Gender.female: 'Female',
  Gender.nonBinary: 'Non-binary'
};

final sentimentDisplayValues = {
  Sentiment.awful: 'Awful',
  Sentiment.bad: 'Bad',
  Sentiment.good: 'Good',
  Sentiment.great: 'Great'
};

class AppState with ChangeNotifier {
  Gender? selectedGender;
  Sentiment? selectedSentiment;
  Timer? _resetTimer;

  void selectGender(Gender gender) {
    selectedGender = gender;
    startTimer();
    notifyListeners();
  }

  void selectSentiment(Sentiment sentiment) {
    selectedSentiment = sentiment;
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    _resetTimer?.cancel(); // Cancel any previous timer
    _resetTimer = Timer(const Duration(seconds: 10), resetSelections);
    notifyListeners();
  }

  void resetSelections() {
    selectedGender = null;
    selectedSentiment = null;
    _resetTimer = null;
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
                    onPressed: () => kioskState.selectGender(Gender.female),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedGender == Gender.female
                              ? activeGenderColor
                              : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          genderDisplayValues[Gender.female]!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Icon(Icons.female, size: 40),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => kioskState.selectGender(Gender.male),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedGender == Gender.male
                          ? activeGenderColor
                          : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          genderDisplayValues[Gender.male]!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Icon(Icons.male, size: 40),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => kioskState.selectGender(Gender.nonBinary),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedGender == Gender.nonBinary
                              ? activeGenderColor
                              : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          genderDisplayValues[Gender.nonBinary]!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Icon(Icons.transgender, size: 40),
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
                    onPressed: () =>
                        kioskState.selectSentiment(Sentiment.awful),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedSentiment == Sentiment.awful
                              ? activeAwfulColor
                              : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          sentimentDisplayValues[Sentiment.awful]!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text(
                          '😞',
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => kioskState.selectSentiment(Sentiment.bad),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedSentiment == Sentiment.bad
                              ? activeBadColor
                              : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          sentimentDisplayValues[Sentiment.bad]!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text('😐', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => kioskState.selectSentiment(Sentiment.good),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedSentiment == Sentiment.good
                              ? activeGoodColor
                              : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          sentimentDisplayValues[Sentiment.good]!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text('🙂', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        kioskState.selectSentiment(Sentiment.great),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedSentiment == Sentiment.great
                              ? activeGreatColor
                              : inactiveButtonColor, // Highlight if selected
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          sentimentDisplayValues[Sentiment.great]!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text('😄', style: TextStyle(fontSize: 40)),
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
