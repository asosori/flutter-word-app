import 'package:flutter/material.dart';
import './WordCard.dart';

class Word extends StatefulWidget {
  Word({Key key}) : super(key: key);
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  bool _isQuestion;

  @override
  void initState(){
    super.initState();
    _isQuestion = true; 
  }

  @override
  Widget build(BuildContext context){
    if (_isQuestion) {
      return WordCard(word: 'flutter', displayQuestion: this._displayQuestion, displayAnswer: this._displayAnswer);
    } else {
      return WordCard(word: 'フラッター', displayQuestion: this._displayQuestion, displayAnswer: this._displayAnswer);
    }
  }

  void _displayQuestion(){
    setState(() {
      _isQuestion = true;
    });
  }

  void _displayAnswer(){
    setState(() {
      _isQuestion = false;
    });
  }
}