import 'package:clean_news_app/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_news_app/features/news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:clean_news_app/features/news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../../domain/usecases/get_article_usecase.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent,RemoteArticlesState> {

  final GetArticlesUseCase _getArticlesUseCase;
  RemoteArticlesBloc(this._getArticlesUseCase): super(const RemoteArticlesLoading()) {
    on <GetArticles> (onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter<RemoteArticlesState> emitter) async {
    final dataState = await _getArticlesUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data!);
      emit(
        RemoteArticlesDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      print(dataState.error!);
      emit(
        RemoteArticlesError(dataState.error!)
      );
    }
  }
}