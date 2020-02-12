import 'package:flutter/material.dart';
import './layout/BaseScreen.dart';

class WordCreateScreen extends StatefulWidget {
  WordCreateScreen({Key key}) : super(key: key);
  @override
  _WordCreateScreenState createState() => _WordCreateScreenState();
}

class _WordCreateScreenState extends State<WordCreateScreen> {
  final controller = TextEditingController();
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
                  controller: controller,
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
                  controller: controller,
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
                  onPressed: createWord,
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
                Padding(padding: EdgeInsets.only(bottom: 30),),
              ]
            )
          )
        )
    );
    return BaseScreen(bodyContent: _bodyContent, index: 0,);
  }

  void createWord(){
    print("ボタンが押されました");
  }
}