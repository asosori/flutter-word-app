import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String word;
  final Function displayQuestion;
  final Function displayAnswer;

  WordCard({this.word, this.displayQuestion, this.displayAnswer});

  @override
  Widget build(BuildContext context){
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
                        onPressed: this.displayQuestion,
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
                        onPressed: this.displayAnswer,
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
                      Icon(Icons.edit),
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
}