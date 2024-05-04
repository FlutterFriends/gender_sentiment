import 'package:flutter/material.dart';
import 'package:gender_sentiment/database.dart';
import 'package:provider/provider.dart';
import 'dart:async';

const double portraitLabelFontSize = 15;
const double portraitIconFontSize = 15;
const double landscapeLabelFontSize = 25;
const double landscapeIconFontSize = 25;

const double portraitButtonHPadding = 10;
const double portraitButtonVPadding = 5;
const double landscapeButtonHPadding = 15;
const double landscapeButtonVPadding = 10;

final genderDisplayValues = {
  Gender.male: 'Male',
  Gender.female: 'Female',
  Gender.nonBinary: 'Non-binary'
};

final sentimentDisplayValues = {
  Sentiment.veryBad: 'Very Bad',
  Sentiment.bad: 'Bad',
  Sentiment.good: 'Good',
  Sentiment.veryGood: 'Very Good'
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

    final mediaQueryData = MediaQuery.of(context);
    final isPortrait = mediaQueryData.orientation == Orientation.portrait;

    double labelFontSize =
        isPortrait ? portraitLabelFontSize : landscapeLabelFontSize;
    double iconFontSize =
        isPortrait ? portraitIconFontSize : landscapeIconFontSize;
    double buttonHPadding =
        isPortrait ? portraitButtonHPadding : landscapeButtonHPadding;
    double buttonVPadding =
        isPortrait ? portraitButtonVPadding : landscapeButtonVPadding;

    final EdgeInsets buttonPadding = EdgeInsets.symmetric(
      horizontal: buttonHPadding,
      vertical: buttonVPadding,
    );

    const Color activeGenderColor = Colors.yellow;
    const Color inactiveButtonColor = Colors.white;
    const Color activeAwfulColor = Colors.redAccent;
    const Color activeBadColor = Colors.orangeAccent;
    const Color activeGoodColor = Colors.lightBlue;
    const Color activeGreatColor = Colors.greenAccent;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gender Sentiment Survey')),
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
                      padding: buttonPadding,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.female, size: iconFontSize),
                        Text(
                          genderDisplayValues[Gender.female]!,
                          style: TextStyle(fontSize: labelFontSize),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => kioskState.selectGender(Gender.male),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kioskState.selectedGender == Gender.male
                          ? activeGenderColor
                          : inactiveButtonColor,
                      padding: buttonPadding,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.male, size: iconFontSize),
                        Text(
                          genderDisplayValues[Gender.male]!,
                          style: TextStyle(fontSize: labelFontSize),
                        ),
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
                      padding: buttonPadding,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.transgender, size: iconFontSize),
                        Text(
                          genderDisplayValues[Gender.nonBinary]!,
                          style: TextStyle(fontSize: labelFontSize),
                        ),
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
                        kioskState.selectSentiment(Sentiment.veryBad),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedSentiment == Sentiment.veryBad
                              ? activeAwfulColor
                              : inactiveButtonColor,
                      padding: buttonPadding,
                      textStyle: TextStyle(fontSize: labelFontSize),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('😞', style: TextStyle(fontSize: iconFontSize)),
                        Text(
                          sentimentDisplayValues[Sentiment.veryBad]!,
                          style: TextStyle(fontSize: labelFontSize),
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
                      padding: buttonPadding,
                      textStyle: TextStyle(
                        fontSize: labelFontSize,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('😐', style: TextStyle(fontSize: iconFontSize)),
                        Text(
                          sentimentDisplayValues[Sentiment.bad]!,
                          style: TextStyle(fontSize: labelFontSize),
                        ),
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
                      padding: buttonPadding,
                      textStyle: TextStyle(fontSize: labelFontSize),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('🙂', style: TextStyle(fontSize: iconFontSize)),
                        Text(
                          sentimentDisplayValues[Sentiment.good]!,
                          style: TextStyle(fontSize: labelFontSize),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        kioskState.selectSentiment(Sentiment.veryGood),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          kioskState.selectedSentiment == Sentiment.veryGood
                              ? activeGreatColor
                              : inactiveButtonColor,
                      padding: buttonPadding,
                      textStyle: TextStyle(fontSize: labelFontSize),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('😄', style: TextStyle(fontSize: iconFontSize)),
                        Text(
                          sentimentDisplayValues[Sentiment.veryGood]!,
                          style: TextStyle(fontSize: labelFontSize),
                        ),
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
