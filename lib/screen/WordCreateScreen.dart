import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';
import './layout/BaseScreen.dart';

class WordCreateScreen extends StatefulWidget {
  WordCreateScreen({Key key}) : super(key: key);
  @override
  _WordCreateScreenState createState() => _WordCreateScreenState();
}

class _WordCreateScreenState extends State<WordCreateScreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  Widget _bodyContent;

  @override
  Widget build(BuildContext context) {
    _bodyContent = Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          height: 410,
          child: Card(
            margin: EdgeInsets.only(left: 60, right: 60),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
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
                  decoration: InputDecoration(
                    labelText: "問題を入力してください",
                    border: OutlineInputBorder()
                  ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),),
                Container(
                  alignment: Alignment.center,
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
                  decoration: InputDecoration(
                    labelText: "解答を入力してください",
                    border: OutlineInputBorder()
                  ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 40),),
                Center(
                  child: RaisedButton(
                  onPressed: this.submitWord,
                  color: Colors.teal,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "単語を作成する",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                        ),
                      ),
                  )
                  ),
                ),
              ]
            )
          )
        ),
      )
    );
    return BaseScreen(bodyContent: _bodyContent, index: 0,);
  }

  void submitWord(){
    String questionWord = _questionController.text;
    String answerWord = _answerController.text;

    if (questionWord == "" || answerWord == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("エラー"),
          content: Text("問題か解答のどちらかが空欄になっているので、単語を作成できませんでした。")
          )
      );
    } else {
      createWord(questionWord, answerWord);
    }
  }

  void createWord(questionWord, answerWord) async {
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

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text("新しく単語を作成しました！")
      )
    );
  }
}