import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/article_bloc/bloc/article_bloc.dart';

const EdgeInsetsGeometry padding =
    EdgeInsets.symmetric(vertical: 2, horizontal: 2);
final OutlinedBorder chipBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(4),
  side: const BorderSide(color: Colors.blue, width: 1),
);

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: const Column(
        children: [
          MaxArticlePerPage(),
          CategoryList(),
          SortBy(),
        ],
      ),
    );
  }
}

class SortBy extends StatelessWidget {
  const SortBy({
    super.key,
  });

  ///relevancy, popularity, publishedAt
  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: padding,
          child: ChoiceChip(
            onSelected: (value) {
              articleBloc.add(
                UserUpdatedSortByEvent(
                  sortBy: SortBY.publishedAt.name,
                ),
              );
            },
            shape: chipBorder,
            padding: padding,
            label: const Text("Relevancy"),
            selected: true,
          ),
        ),
        Padding(
          padding: padding,
          child: ChoiceChip(
            onSelected: (value) {
              articleBloc.add(
                UserUpdatedSortByEvent(
                  sortBy: SortBY.publishedAt.name,
                ),
              );
            },
            shape: chipBorder,
            padding: padding,
            label: const Text("Popularity"),
            selected: false,
            selectedColor: Colors.white,
            showCheckmark: true,
          ),
        ),
        Padding(
          padding: padding,
          child: ChoiceChip(
            onSelected: (value) {
              articleBloc.add(
                UserUpdatedSortByEvent(
                  sortBy: SortBY.publishedAt.name,
                ),
              );
            },
            shape: chipBorder,
            padding: padding,
            label: const Text("Date Published"),
            selected: false,
          ),
        ),
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: padding,
          child: FilterChip(
            padding: padding,
            shape: chipBorder,
            selected: articleBloc.categoryFilterValues[Category.business]!,
            label: Text(
              getCategory(Category.business),
            ),
            onSelected: (bool value) {
              articleBloc.categoryFilterValues[Category.business] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: articleBloc.categoryFilterValues[Category.entertainment]!,
            label: Text(
              getCategory(Category.entertainment),
            ),
            onSelected: (bool value) {
              articleBloc.categoryFilterValues[Category.entertainment] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: articleBloc.categoryFilterValues[Category.general]!,
            label: Text(
              getCategory(Category.general),
            ),
            onSelected: (bool value) {
              articleBloc.categoryFilterValues[Category.general] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: articleBloc.categoryFilterValues[Category.health]!,
            label: Text(
              getCategory(Category.health),
            ),
            onSelected: (bool value) {
              articleBloc.categoryFilterValues[Category.health] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: articleBloc.categoryFilterValues[Category.science]!,
            label: Text(
              getCategory(Category.science),
            ),
            onSelected: (bool value) {
              articleBloc.categoryFilterValues[Category.science] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: articleBloc.categoryFilterValues[Category.sports]!,
            label: Text(
              getCategory(Category.sports),
            ),
            onSelected: (bool value) {
              articleBloc.categoryFilterValues[Category.sports] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: articleBloc.categoryFilterValues[Category.technology]!,
            label: Text(
              getCategory(Category.technology),
            ),
            onSelected: (bool value) {
              articleBloc.categoryFilterValues[Category.technology] = value;
            },
          ),
        ),
      ],
    );
  }
}

class MaxArticlePerPage extends StatelessWidget {
  const MaxArticlePerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context);
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        return Row(
          children: [
            const Text("Articles/Page : "),
            Slider(
              allowedInteraction: SliderInteraction.tapAndSlide,
              label: articleBloc.articlesPerPage.toString(),
              value: articleBloc.articlesPerPage.toDouble(),
              onChanged: (value) {
                articleBloc.add(
                  UserUpdatedArticlesPerPageEvent(
                    maxArticlesPerPage: value.toInt(),
                  ),
                );
              },
              max: 100,
              divisions: 10,
              min: 10,
            )
          ],
        );
      },
    );
  }
}
