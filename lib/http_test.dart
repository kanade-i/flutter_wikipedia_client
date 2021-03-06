import 'dart:convert';

import 'package:http/http.dart' as http;

class WikipediaAPI {
  String title = "dddddd";

  fetch() async {
    var url = 'https://ja.wikipedia.org/w/api.php?format=json&action=query&prop=info&titles=%E3%82%A8%E3%83%9E%E3%83%BB%E3%83%AF%E3%83%88%E3%82%BD%E3%83%B3';
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map map = json.decode(response.body);
    var pageId = map["query"]["pages"].keys.toList().first;
    var pages = new Pages.fromJson(map["query"]["pages"][pageId]);

    title = pages.title;

    print(pages.title);
    return pages.title;
  }

  getTitle() {
    print(title);
    return title;
  }
}

class Pages {
  final String title;

  Pages(
  {
    this.title
  });

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      title: json["title"] as String
    );
  }
}

main() {
  WikipediaAPI().fetch();
}