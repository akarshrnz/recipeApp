import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechProvider with ChangeNotifier {
  final FlutterTts _fluttrTts;

  TextToSpeechProvider(this._fluttrTts);



  Future<void> textToSpeech({required String text}) async {
    await _fluttrTts.setSpeechRate(0.5);

    await _fluttrTts.setVolume(1.0);

    await _fluttrTts.setLanguage('en-US');

    await _fluttrTts.speak(text);
  }
}
