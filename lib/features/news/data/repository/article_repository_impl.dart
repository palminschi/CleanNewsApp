import 'dart:io';

import 'package:clean_news_app/core/constants/constants.dart';
import 'package:clean_news_app/core/resources/data_state.dart';
import 'package:clean_news_app/features/news/data/models/article.dart';
import 'package:clean_news_app/features/news/domain/entities/article.dart';
import 'package:clean_news_app/features/news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';
import '../data_sources/remote/news_api_service.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: newsAPIKey,
          category: categoryQuery,
          country: categoryQuery
      );
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
}