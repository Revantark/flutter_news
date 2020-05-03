import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlesList extends StatelessWidget {
  final List news;
  ArticlesList({this.news});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text("Last Updated " + news[index]),
              )
            ],
          );
        }
        String author = news[index]['author'];
        String url = news[index]['url'];
        if (author == null) author = "unknown";
        return Card(
          child: ListTile(
            title: Text(news[index]['title']),
            subtitle: Text(author),
            onTap: () async {
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
        );
      },
    );
  }
}
