part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsLoaded extends NewsState {
  final List articles;
  final String time;
  NewsLoaded({this.articles, this.time});

  @override
  List<Object> get props => [articles];
}



class NewsRefreshed extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}
