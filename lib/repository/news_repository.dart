
import 'package:news/repository/news_api_client.dart';

class NewsRepository {

  NewsApiClient newsApiClient ;

  NewsRepository({this.newsApiClient});

  Future<List> getNews() async {
    return await newsApiClient.fetchNews();
  }

} 