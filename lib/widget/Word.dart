import 'package:flutter/material.dart';
import './WordCard.dart';

class Word extends StatefulWidget {
  final String question;
  final String answer;

  Word({this.question, this.answer});

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
      return WordCard(word: widget.question, displayQuestion: this._displayQuestion, displayAnswer: this._displayAnswer);
    } else {
      return WordCard(word: widget.answer, displayQuestion: this._displayQuestion, displayAnswer: this._displayAnswer);
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