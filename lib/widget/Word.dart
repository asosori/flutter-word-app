import 'package:flutter/material.dart';
import '../argument/WordArguments.dart';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';

class Word extends StatefulWidget {
  final num id;
  final String question;
  final String answer;

  Word({this.id, this.question, this.answer});

  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  bool _isQuestion;
  final Color color = Color(0xFFf9f7f0);

  @override
  void initState(){
    super.initState();
    _isQuestion = true; 
  }

  @override
  Widget build(BuildContext context){
    if (_isQuestion) {
      return wordCard(widget.question);
    } else {
      return wordCard(widget.answer);
    }
  }

  Widget wordCard(String word){
    return Container(
      child: Card(
        margin: EdgeInsets.only(bottom: 20, left: 40, right: 40),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth/2,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: _selectedBoxDecoration(_isQuestion),
                      child: FlatButton(
                        onPressed: this._displayQuestion,
                        child: Text(
                          "問題",
                          style: _selectedTextStyle(_isQuestion)
                        )
                      )
                    ),
                    Container(
                      width: constraints.maxWidth/2,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: _selectedBoxDecoration(!_isQuestion),
                      child: FlatButton(
                        onPressed: this._displayAnswer,
                        child: Text(
                          "解答",
                          style: _selectedTextStyle(!_isQuestion)
                        )
                      )        
                    ),
                  ],
                );
              }
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "$word",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(icon: const Icon(Icons.edit), onPressed: this.moveEditScreen),
                      IconButton(icon: const Icon(Icons.delete), onPressed: this.deleteWordModal),
                    ],
                  )
                ]
              )
            ),
          ]
        )
      )
    );
  }

  BoxDecoration _selectedBoxDecoration(bool isQuestion){
    if (isQuestion) {
      return BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 3,
            color: Color(0xFF4577f4),
          ),
        ),
        color: color,
      );
    } else {
      return BoxDecoration(
        color: color,
      );
    }
  }

  TextStyle _selectedTextStyle(bool isQuestion){
    if (isQuestion) {
      return TextStyle(
        color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold
      );
    } else {
      return TextStyle(fontSize: 16);
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

  void moveEditScreen(){
    Navigator.pushNamed(context, '/edit', arguments: WordArguments(id: widget.id, question: widget.question, answer: widget.answer));
  }

  void deleteWordModal(){
    final num id = widget.id;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("確認"),
        content: Text("この操作は取り消すことができません。削除してもよろしいでしょうか？"),
        actions: <Widget>[
          FlatButton(
            child: const Text('削除する'),
            onPressed: () => this.deleteWord(id),
          ),
          FlatButton(
            child: const Text('削除しない'),
            onPressed: () => Navigator.pushNamed(context, '/list')
          )
        ],
        )
    );
  }

  void deleteWord(num id) async {
    String dbPath = await getDatabasesPath();
    String path = Path.join(dbPath, "mydata.db");

    String query = 'DELETE FROM words WHERE id=$id';

    Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS words (id INTEGER PRIMARY KEY, question TEXT NOT NULL, answer TEXT NOT NULL)"
        );
      }
    );

    await database.transaction((txn) async {
      await txn.rawDelete(query);
    });

    Navigator.pushNamed(context, '/list');
  }
}