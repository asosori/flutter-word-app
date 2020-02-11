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
      initialRoute: '/',
      routes: {
        '/': (context) => WordCreateScreen(),
        '/list': (context) => WordListScreen(),
        //'/edit': (context) => WordEditScreen()
      },
    );
  }
}

class WordCreateScreen extends StatefulWidget {
  WordCreateScreen({Key key}) : super(key: key);
  @override
  _WordCreateScreenState createState() => _WordCreateScreenState();
}

class _WordCreateScreenState extends State<WordCreateScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var container = SingleChildScrollView(
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
    return BottomNaviBar(container: container, index: 0,);
  }

  void createWord(){
    print("ボタンが押されました");
  }
}

class WordListScreen extends StatefulWidget {
  WordListScreen({Key key}) : super(key: key);
  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  @override
  Widget build(BuildContext context) {
    var container = SingleChildScrollView(
      child:
        Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40)),
            Word(),
            Word()
          ],
        )
    );
    return BottomNaviBar(container: container, index: 1,);
  }

  void createWord(){
    print("ボタンが押されたよ");
  }
}

class Word extends StatefulWidget {
  Word({Key key}) : super(key: key);
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.red,    
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
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "問題",
                          style: TextStyle(fontSize: 22,
                          )                            
                        ),
                      )
                    ),
                    Container(
                      color: Colors.green,
                      width: constraints.maxWidth/2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "解答",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          )
                        ),
                      )
                    ),
                  ],
                );
              }
            ),
            Padding(padding: EdgeInsets.all(10),),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Text(
                'aaa',
                style: TextStyle(fontSize: 18),
                )
            ),
            Padding(padding: EdgeInsets.only(bottom: 30),),
          ]
        )
      )
    );
  }
}

class BottomNaviBar extends StatelessWidget{
  final Widget container;
  final int index;

  BottomNaviBar({this.container, this.index});

  @override
  Widget build(BuildContext context){
    return Scaffold(
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