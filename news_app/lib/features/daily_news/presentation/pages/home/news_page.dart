import 'package:flutter/material.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/widgets/filters.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context)
      ..add(
        const GetArticlesEvent(),
      );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                enableDrag: true,
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const Filters();
                },
              ).then(
                (value) {
                  articleBloc.add(
                    UserFilterFinalizedEvent(),
                  );
                },
              );
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromDirectional(
                    textDirection: TextDirection.ltr,
                    start: 1,
                    top: 1,
                    end: 20,
                    bottom: 20),
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    value: CountryName.india,
                    onTap: () {},
                    child: const Text("India"),
                  ),
                  PopupMenuItem(
                    value: CountryName.usa,
                    onTap: () {},
                    child: const Text("Usa"),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.travel_explore),
          ),
        ],
        title: const Text(
          "Today News",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is UserWantsToAddFiltersState) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return const Placeholder();
              },
            );
          }
          if (state is ArticleLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ArticleDoneState) {
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
          if (state is ArticleErrorState) {
            // debugPrint(state.exception.type.name);
            return Center(
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  articleBloc.add(
                    const GetArticlesEvent(),
                  );
                },
              ),
            );
          }
          return const Center(
            child: Text(
              "It look like something unexpected happened",
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
