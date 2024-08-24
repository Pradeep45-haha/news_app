import 'package:flutter/material.dart';
import 'package:news_app/config/data_helper.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/filter_bloc/bloc/filter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/url_launch_bloc/url_launch_bloc.dart';
import 'package:news_app/features/daily_news/presentation/widgets/filters.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context)
      ..add(
        const GetArticlesEvent(),
      );
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    debugPrint("from news page page count is: ${filterBloc.articlesPerPage}");

    return BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
      if (state is ShowCountrySelectionMenuState) {
        return CountryMenuList(
          countryNameAndCode: countryNameCodeMap,
        );
      }

      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                color: Colors.white,
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.white),
                    iconColor: WidgetStatePropertyAll<Color>(Colors.blue)),
                onPressed: () async {
                  showModalBottomSheet(
                    enableDrag: true,
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      return const Filters();
                    },
                  ).then(
                    (value) {
                      debugPrint("modal is closed");
                      filterBloc.add(
                        UserFilterFinalizedEvent(),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.filter_alt_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                color: Colors.white,
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.white),
                    iconColor: WidgetStatePropertyAll<Color>(Colors.blue)),
                onPressed: () {
                  filterBloc.add(ShowCountrySelectionMenuEvent());
                },
                icon: const Icon(Icons.travel_explore),
              ),
            ),
          ],
          title: const Text(
            "Today News",
            style: TextStyle(
              color: Colors.white,
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
                    maxWidth: 640,
                  ),
                  child: ListView.builder(
                    cacheExtent: 10000,
                    scrollDirection: Axis.vertical,
                    itemCount:
                        state.articleCountAndArticleEntity.article.length,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          newsTileBuilder(state
                              .articleCountAndArticleEntity.article[index]),
                          if (index >=
                              state.articleCountAndArticleEntity.article
                                      .length -
                                  1)
                            SizedBox(
                              height: 56,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.articleCountAndArticleEntity
                                          .totalResults ~/
                                      filterBloc.articlesPerPage,
                                  itemBuilder: (context, index) {
                                    double width = 30;
                                    if (index >= 9999) {
                                      width += 48;
                                    } else if (index >= 999) {
                                      width += 36;
                                    } else if (index >= 99) {
                                      width += 24;
                                    } else if (index >= 9) {
                                      width += 12;
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                filterBloc.pageNum == index + 1
                                                    ? Colors.blue
                                                    : Colors.transparent,
                                            border: Border.all(
                                                color: Colors.blue, width: 1)),
                                        width: width,
                                        child: TextButton(
                                          onPressed: () {
                                            filterBloc.add(
                                              UserChangedPageNumEvent(
                                                  pageNum: index + 1),
                                            );
                                          },
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                color: filterBloc.pageNum ==
                                                        index + 1
                                                    ? Colors.white
                                                    : Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          else
                            const SizedBox()
                        ],
                      );
                    },
                  ),
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
                "Something unexpected happened",
              ),
            );
          },
        ),
      );
    });
  }
}

Widget newsTileBuilder(ArticleEntity articleEntity) {
  if (!(articleEntity.title == "null" || articleEntity.url == "null")) {
    return Builder(builder: (context) {
      UrlLaunchBloc urlLaunchBloc = BlocProvider.of<UrlLaunchBloc>(context);
      return InkWell(
        onTap: () {
          urlLaunchBloc.add(OpenUrlEvent(url: articleEntity.url!));
        },
        child: Card(
          elevation: 4,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 8, left: 4, right: 4, top: 6),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  articleEntity.urlToImage == "null"
                      ? const SizedBox()
                      : SizedBox(
                          child: Image(
                            image: NetworkImage(
                              articleEntity.urlToImage!,
                            ),
                          ),
                        ),
                  Text(
                    articleEntity.title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    articleEntity.content == "null"
                        ? ""
                        : articleEntity.content!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
  return const SizedBox();
}
