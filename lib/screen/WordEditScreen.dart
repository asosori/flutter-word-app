import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';
import './layout/BaseScreen.dart';

class WordEditScreen extends StatefulWidget {
  WordEditScreen({Key key}) : super(key: key);
  @override
  _WordEditScreenState createState() => _WordEditScreenState();
}

class _WordEditScreenState extends State<WordEditScreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  Widget _bodyContent;

  @override
  Widget build(BuildContext context) {
    _bodyContent = SingleChildScrollView(
      child:
        Container(
          child: Card(
            margin: EdgeInsets.only(top: 40, left: 60, right: 60),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, top: 30),
                  child:
                    Text(
                      "問題",
                      style: TextStyle(fontSize: 22,
                      )
                    )
                ),
                Padding(padding: EdgeInsets.all(10),),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: TextFormField(
                  controller: _questionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "問題を入力してください",
                    border: OutlineInputBorder()
                  ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5),
                  child:
                    Text(
                      "解答",
                      style: TextStyle(fontSize: 22,
                      )
                    )
                ),
                Padding(padding: EdgeInsets.all(10),),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: TextFormField(
                  controller: _answerController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "解答を入力してください",
                    border: OutlineInputBorder()
                  ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 30),),
                Center(
                  child: RaisedButton(
                  onPressed: this.submitWord,
                  color: Colors.teal,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "変更する",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                        ),
                      ),
                  )
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 30),),
              ]
            )
          )
        )
    );
    return BaseScreen(bodyContent: _bodyContent, index: 1);
  }

  void submitWord(){
    String questionWord = _questionController.text;
    String answerWord = _answerController.text;

    if (questionWord == "" || answerWord == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("エラー"),
          content: Text("問題か解答のどちらかが空欄になっているので、単語を更新できませんでした。")
          )
      );
    } else {
      updateWord(questionWord, answerWord);
    }
  }

  void updateWord(questionWord, answerWord) async {
    String dbPath = await getDatabasesPath();
    String path = Path.join(dbPath, "mydata.db");

    String query = 'INSERT INTO words(question, answer) VALUES("$questionWord", "$answerWord")';

    Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS words (id INTEGER PRIMARY KEY, question TEXT NOT NULL, answer TEXT NOT NULL)"
        );
      }
    );

    await database.transaction((txn) async {
      await txn.rawInsert(query);
    });

    setState(() {
      _questionController.text = '';
      _answerController.text = '';
    });
  }
}