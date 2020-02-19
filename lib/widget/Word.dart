import 'package:flutter/material.dart';
import '../argument/WordArguments.dart';

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
                      color: Colors.blue,
                      width: constraints.maxWidth/2,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      child: FlatButton(
                        onPressed: this._displayQuestion,
                        color: Colors.red,
                        child: Text(
                          "問題",
                          style: TextStyle(fontSize: 22)
                        )
                      )        
                    ),
                    Container(
                      color: Colors.green,
                      width: constraints.maxWidth/2,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      child: FlatButton(
                        onPressed: this._displayAnswer,
                        color: Colors.red,
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
                      IconButton(icon: const Icon(Icons.edit), onPressed: moveEditScreen),
                      Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),),
                      Icon(Icons.delete)
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
}