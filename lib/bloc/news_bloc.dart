import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/repository/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

  final NewsRepository newsRepository;
  NewsBloc({this.newsRepository});

  @override
  NewsState get initialState => NewsLoading();

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if(event is FetchNews){
      
      final news = await newsRepository.getNews();
      news.insert(0, currentTime());

      yield NewsLoaded(articles: news,time: currentTime());
    }
    if (event is RefreshNews){
      
      final news = await newsRepository.getNews();
      news.insert(0, currentTime());
      yield NewsRefreshed();
      
      yield NewsLoaded(articles: news,time: currentTime());

    }
  }

  String currentTime(){
    
    return DateTime.now().toString().substring(11,16);

  }



}
