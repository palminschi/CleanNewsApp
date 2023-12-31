import 'package:clean_news_app/core/resources/data_state.dart';
import 'package:clean_news_app/core/usecases/usecase.dart';
import 'package:clean_news_app/features/news/domain/entities/article.dart';
import 'package:clean_news_app/features/news/domain/repository/article_repository.dart';

class GetArticlesUseCase implements UseCase<DataState<List<ArticleEntity>>, void> {

  final ArticleRepository _articleRepository;

  GetArticlesUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }

}