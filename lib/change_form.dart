import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wikipedia_client/http_test.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //氏名
  String _name;

  //社名
  String _company;

  //所属
  String _division;

  //役職
  String _title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('名刺詳細')),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: makeChildren(),
            )));
  }

  // paddingの中の要素たち
  List<Widget> makeChildren() {
    if (_name == null) {
      // 名刺が無いのでプログレスを表示
      return <Widget>[CircularProgressIndicator()];
    } else {
      // 名刺を表示
      return <Widget>[
        Text(_title),
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    var api = new WikipediaAPI();

    _title = api.fetch();

    // _title = api.getTitle();

    setState(() {
      _name = _title;
    });
  }

  // APIから取ってくる
  // loadData() async {
  //   String url = 'https://jjsonplaceholder.appspot.com/cards/1';
  //   http.Response response = await http.get(url);
  //   var card = json.decode(utf8.decode(response.bodyBytes));
  //   // 画面を更新
  //   setState(() {
  //     _name = card['name'];
  //     _company = card['company'];
  //     _division = card['division'];
  //     _title = card['title'];
  //   });
  // }
}