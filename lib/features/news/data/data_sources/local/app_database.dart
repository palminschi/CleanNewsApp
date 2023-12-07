import 'package:clean_news_app/features/news/data/data_sources/local/dao/article_dao.dart';
import 'package:floor/floor.dart';
import '../../models/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';


@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}