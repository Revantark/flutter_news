import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/news_bloc.dart';

import 'articles_list.dart';

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
      ),
      body: BlocConsumer<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state is NewsRefreshed) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
            final snackBar = SnackBar(
            content: Text('News updated'),
            
          );
          Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is NewsLoading) {
            newsBloc.add(FetchNews());
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            


            return RefreshIndicator(
              child: ArticlesList(news: state.articles),
              onRefresh: () {
                newsBloc.add(RefreshNews());
                return _refreshCompleter.future;
              },
            );
          }
          
        },
      ),
    );
  }
}
