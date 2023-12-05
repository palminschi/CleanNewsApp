import 'package:clean_news_app/features/news/domain/entities/article.dart';
import '../../../../core/resources/data_state.dart';

abstract class ArticleRepository {
  // API methods
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
