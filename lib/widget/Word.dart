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

  Widget wordCard(String word){
    final Color color = Color(0xFFf9f7f0);

    return Container(
      child: Card(
        margin: EdgeInsets.only(bottom: 40, left: 40, right: 40),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth/2,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 5.0, color: Color(0xFF4577f4), ),
                        ),
                        color: color,
                      ),
                      child: FlatButton(
                        onPressed: this._displayQuestion,
                        child: Text(
                          "問題",
                          style: TextStyle(color: Colors.blue ,fontSize: 22, fontWeight: FontWeight.bold)
                        )
                      )     
                    ),
                    Container(
                      width: constraints.maxWidth/2,
                      color: color,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      child: FlatButton(
                        onPressed: this._displayAnswer,
                        child: Text(
                          "解答",
                          style: TextStyle(fontSize: 22)
                        )
                      )        
                    ),
                  ],
                );
              }
            ),
            Padding(padding: EdgeInsets.all(10),),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "$word",
                    style: TextStyle(fontSize: 18),
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
            Padding(padding: EdgeInsets.only(bottom: 20),),
          ]
        )
      )
    );
  }

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