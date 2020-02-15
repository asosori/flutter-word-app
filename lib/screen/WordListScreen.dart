import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';
import './layout/BaseScreen.dart';
import '../widget/Word.dart';

class WordListScreen extends StatefulWidget {
  WordListScreen({Key key}) : super(key: key);
  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  Widget _bodyContent;
  List<Widget> _words = <Widget>[];

  @override
  void initState(){
    super.initState();
    fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    _bodyContent = SingleChildScrollView(
      child:
        Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40)),
            Column(
              children: _words
            )
          ],
        )
    );
    return BaseScreen(bodyContent: _bodyContent, index: 1,);
  }

  void fetchWords() async {
    List<Widget> words = <Widget>[];
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "mydata.db");

    Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS words (id INTEGER PRIMARY KEY, question TEXT NOT NULL, answer TEXT NOT NULL)"
        );
      }
    );

    List<Map> result = await database.rawQuery('SELECT * FROM words');

    for (Map word in result) {
      words.add(
        Word(question: word['question'], answer: word['answer'])
      );
    }

    setState(() {
      _words = words;
    });
  }
}