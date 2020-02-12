import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget{
  final Widget bodyContent;
  final int index;

  BaseScreen({this.bodyContent, this.index});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('単語帳アプリ'),
        centerTitle: true,
        leading: BackButton(color: Colors.white,),
        ),
      body: bodyContent,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text("単語作成"),
              icon: Icon(Icons.library_add),
            ),
            BottomNavigationBarItem(
              title: Text("単語一覧"),
              icon: Icon(Icons.list)
            )
          ],
          onTap: (int value){
            if (value == 0){
              Navigator.pushNamed(
                context,
                '/'
              );
            } else if (value == 1) {
                Navigator.pushNamed(
                  context,
                  '/list'
                );   
            }
          },
        ),
      )
    );
  }
}