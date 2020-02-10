import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'word App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFe7e3f5),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var container = SingleChildScrollView(
      child:
        Container(
          width: 500,
          //color: Colors.blue,
          child: Card(
            margin: EdgeInsets.only(top: 40, left: 60, right: 60),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
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
    return  Scaffold(
      appBar: AppBar(
        title: Text('単語帳アプリ'),
        centerTitle: true,
        leading: BackButton(color: Colors.white,),
        ),
      body: container,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
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
        ),
      )
    );
  }

  void createWord(){
    print("ボタンが押されました");
  }
}