import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/remote_article_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    RemoteArticleBloc remoteArticleBloc =
        BlocProvider.of<RemoteArticleBloc>(context)
          ..add(
            const GetArticlesEvent(),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Today News",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (context, state) {
          if (state is RemoteArticleLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RemoteArticleDoneState) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.articlesEntity.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    itemBuilder: (context, index) {
                      return newsTileBuilder(state.articlesEntity[index]);
                    }),
              ),
            );
          }
          if (state is RemoteArticleErrorState) {
            // debugPrint(state.exception.type.name);
            return Center(
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  remoteArticleBloc.add(
                    const GetArticlesEvent(),
                  );
                },
              ),
            );
          }
          return const Center(
            child: Text(
              "It look like somthing unexpeted happened",
            ),
          );
        },
      ),
    );
  }
}

Widget newsTileBuilder(ArticleEntity articleEntity) {
  if (!(articleEntity.description == "null" ||
      articleEntity.content == "null")) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            articleEntity.urlToImage == null
                ? const SizedBox()
                : SizedBox(
                    child: Image(
                      image: NetworkImage(
                        articleEntity.urlToImage!,
                      ),
                    ),
                  ),
            Text(
              articleEntity.description!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              articleEntity.content!,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
  return const SizedBox();
}
