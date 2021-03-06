import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Pages> fetchPages(String _searchWord) async {
  var url = 'https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=info' +
      '&titles=' +
      _searchWord;
  var response = await http.get(Uri.parse(url));

  Map map = json.decode(response.body);
  var pageId = map["query"]["pages"].keys.toList().first;
  var pages = Pages.fromJson(map["query"]["pages"][pageId]);

  if (response.statusCode == 200 && pageId != "-1") {
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
  final int pageId;
  final String title;

  Pages({this.pageId, this.title});

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      pageId: json['pageId'],
      title: json['title']
    );
  }
}