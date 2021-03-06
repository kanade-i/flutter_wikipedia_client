import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wikipedia_client/wikipedia_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Pages> futurePages;
  final TextEditingController _controller = new TextEditingController();
  String _searchWord = "";

  @override
  void initState() {
    super.initState();
  }

  void fetch() {
    setState(() {
      futurePages = fetchPages(_searchWord);
    });
  }

  void _onChanged(String e) {
    setState(() {
      _searchWord = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Wikipedia Client'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FutureBuilder<Pages>(
                  future: futurePages,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.pageId == -1) {
                        return Text("Error");
                      }
                      else return Text(snapshot.data.title ?? "default");
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    // return CircularProgressIndicator();
                    return Text("");
                  },
                ),
                ElevatedButton(
                    onPressed: fetch,
                    child: Text("検索")
                ),
                TextField(
                  enabled: true,
                  // 入力数
                  maxLength: 10,
                  style: TextStyle(color: Colors.blue),
                  obscureText: false,
                  maxLines:1 ,
                  controller: _controller,
                  onChanged: _onChanged,
                ),
              ]),
        ),
      ),
    );
  }
}
