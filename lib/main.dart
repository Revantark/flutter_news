import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/news_bloc.dart';
import 'package:news/repository/news_api_client.dart';
import 'package:news/repository/news_repository.dart';
import 'package:http/http.dart' as http;
import 'package:news/widgets/articles.dart';

void main() {
  NewsRepository newsRepository =
      NewsRepository(newsApiClient: NewsApiClient(httpClient: http.Client()));

  runApp(MyApp(res:newsRepository));
}

class MyApp extends StatelessWidget {
  final NewsRepository res;
  MyApp({this.res});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News",
      home: BlocProvider(
        create: (context) => NewsBloc(newsRepository: res),
        child: Articles(),
      ),
    );
  }
}
