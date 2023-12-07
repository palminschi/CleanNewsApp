import 'package:clean_news_app/config/theme/app_themes.dart';
import 'package:clean_news_app/features/news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_news_app/features/news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:clean_news_app/features/news/presentation/pages/home/daily_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/routes.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
        create: (context) =>
        sl()
          ..add(const GetArticles()),
        child: MaterialApp(
            title: 'News app',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            theme: theme(),
            home: const DailyNews())
    );
  }
}
