import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/filter_bloc/bloc/filter_bloc.dart';

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
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: padding,
          child: ChoiceChip(
            onSelected: (value) {
              filterBloc.add(
                UserUpdatedSortByEvent(
                  sortBy: SortNewsBy.publishedAt.name,
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
              filterBloc.add(
                UserUpdatedSortByEvent(
                  sortBy: SortNewsBy.publishedAt.name,
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
              filterBloc.add(
                UserUpdatedSortByEvent(
                  sortBy: SortNewsBy.publishedAt.name,
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
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: padding,
          child: FilterChip(
            padding: padding,
            shape: chipBorder,
            selected: filterBloc.categoryFilterValues[Category.business]!,
            label: Text(
              getCategory(Category.business),
            ),
            onSelected: (bool value) {
              filterBloc.categoryFilterValues[Category.business] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: filterBloc.categoryFilterValues[Category.entertainment]!,
            label: Text(
              getCategory(Category.entertainment),
            ),
            onSelected: (bool value) {
              filterBloc.categoryFilterValues[Category.entertainment] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: filterBloc.categoryFilterValues[Category.general]!,
            label: Text(
              getCategory(Category.general),
            ),
            onSelected: (bool value) {
              filterBloc.categoryFilterValues[Category.general] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: filterBloc.categoryFilterValues[Category.health]!,
            label: Text(
              getCategory(Category.health),
            ),
            onSelected: (bool value) {
              filterBloc.categoryFilterValues[Category.health] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: filterBloc.categoryFilterValues[Category.science]!,
            label: Text(
              getCategory(Category.science),
            ),
            onSelected: (bool value) {
              filterBloc.categoryFilterValues[Category.science] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: filterBloc.categoryFilterValues[Category.sports]!,
            label: Text(
              getCategory(Category.sports),
            ),
            onSelected: (bool value) {
              filterBloc.categoryFilterValues[Category.sports] = value;
            },
          ),
        ),
        Padding(
          padding: padding,
          child: FilterChip(
            shape: chipBorder,
            padding: padding,
            selected: filterBloc.categoryFilterValues[Category.technology]!,
            label: Text(
              getCategory(Category.technology),
            ),
            onSelected: (bool value) {
              filterBloc.categoryFilterValues[Category.technology] = value;
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
    return const Row(
      children: [
        Text("Articles/Page : "),
        ArticlesCountSlider(),
      ],
    );
  }
}

class ArticlesCountSlider extends StatelessWidget {
  const ArticlesCountSlider({super.key});
  @override
  Widget build(BuildContext context) {
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    return StatefulBuilder(
      builder: (context, setState) {
        return Expanded(
          child: Slider(
            allowedInteraction: SliderInteraction.tapAndSlide,
            label: filterBloc.articlesPerPage.toString(),
            value: filterBloc.articlesPerPage.toDouble(),
            onChanged: (value) {
              setState(
                () {
                  filterBloc.add(
                    UserUpdatedArticlesPerPageEvent(
                      maxArticlesPerPage: value.toInt(),
                    ),
                  );
                },
              );
            },
            max: 100,
            divisions: 9,
            min: 10,
          ),
        );
      },
    );
  }
}
