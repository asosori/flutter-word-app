import 'package:flutter/material.dart';
import './layout/BaseScreen.dart';
import '../widget/Word.dart';

class WordListScreen extends StatefulWidget {
  WordListScreen({Key key}) : super(key: key);
  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  Widget _bodyContent;

  @override
  Widget build(BuildContext context) {
    _bodyContent = SingleChildScrollView(
      child:
        Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40)),
            Word(),
            Word()
          ],
        )
    );
    return BaseScreen(bodyContent: _bodyContent, index: 1,);
  }
}