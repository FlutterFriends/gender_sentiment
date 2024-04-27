import 'package:flutter/material.dart';
import 'package:gender_sentiment/database.dart';
import 'package:provider/provider.dart';
import 'dart:async';

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

  final database = AppDatabase();

  void selectGender(Gender gender) {
    selectedGender = gender;
    startTimer();
    notifyListeners();
    saveObservation();
  }

  void selectSentiment(Sentiment sentiment) {
    selectedSentiment = sentiment;
    startTimer();
    notifyListeners();
    saveObservation();
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

  Future<void> saveObservation() async {
    if (selectedGender == null || selectedSentiment == null) {
      return;
    }

    final observation = ObservationsCompanion.insert(
      gender: selectedGender!,
      sentiment: selectedSentiment!,
      timestamp: DateTime.now(),
    );

    await database.into(database.observations).insert(observation);

    // Pause for one second for the user to see their selection
    // before resetting the selections.
    await Future.delayed(const Duration(seconds: 1));

    resetSelections();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const GenderSentimentApp(),
    ),
  );
}

class GenderSentimentApp extends StatelessWidget {
  const GenderSentimentApp({super.key});

  @override
  Widget build(BuildContext context) {
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
                              : inactiveButtonColor,
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
                          : inactiveButtonColor,
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
                              : inactiveButtonColor,
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
                              : inactiveButtonColor,
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
                              : inactiveButtonColor,
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
                              : inactiveButtonColor,
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
                              : inactiveButtonColor,
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
