
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsApiClient {
  static const url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=b114574efb1b40f9b5995c81fb38563a";

  final http.Client httpClient;

  NewsApiClient({this.httpClient});

  Future<dynamic> fetchNews() async {
    final response = await httpClient.get(url);
  
    if (response.statusCode != 200) {
      throw Exception('error getting news');
    }
    final articles = jsonDecode(response.body);
    List<dynamic> a = articles['articles'];
    return a.sublist(0,10);
  }
}


void main() {
   test("news", () async{
     NewsApiClient n = NewsApiClient(httpClient: http.Client());
     final a = await n.fetchNews();
     print(a[0]);
     expect(a[0]['source']['name'], 'Firstpost.com');
   });
  
}