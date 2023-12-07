import 'dart:io';

import 'package:clean_news_app/core/constants/constants.dart';
import 'package:clean_news_app/core/resources/data_state.dart';
import 'package:clean_news_app/features/news/data/models/article.dart';
import 'package:clean_news_app/features/news/domain/entities/article.dart';
import 'package:clean_news_app/features/news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';
import '../data_sources/local/app_database.dart';
import '../data_sources/remote/news_api_service.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService,this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: newsAPIKey,
          category: categoryQuery,
          country: countryQuery
      );
      print(httpResponse.response);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioErrorType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioError catch(e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}