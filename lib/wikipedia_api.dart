import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Pages> fetchAlbum() async {
  var url = 'https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=info&titles=%E3%82%A8%E3%83%9E%E3%83%BB%E3%83%AF%E3%83%88%E3%82%BD%E3%83%B3';
  var response = await http.get(Uri.parse(url));

  Map map = json.decode(response.body);
  var pageId = map["query"]["pages"].keys.toList().first;
  var pages = Pages.fromJson(map["query"]["pages"][pageId]);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    print('Response body: ${response.body}');
    // then parse the JSON.
    return pages;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class Pages {
  final String title;

  Pages({this.title});

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      title: json['title'],
    );
  }
}