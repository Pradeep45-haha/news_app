import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/themes.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/pages/home/news_page.dart';
import 'package:news_app/injections/injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(
    BlocProvider(
      create: (context) => RemoteArticleBloc(
        serviceLocator.get(),
        serviceLocator.get(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: const NewsPage(),
    );
  }
}
