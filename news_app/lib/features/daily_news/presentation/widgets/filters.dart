import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/features/daily_news/presentation/bloc/remote/filter_bloc/bloc/filter_bloc.dart';

const EdgeInsetsGeometry padding =
    EdgeInsets.symmetric(vertical: 6, horizontal: 6);
final OutlinedBorder chipBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(4),
  side: const BorderSide(color: Colors.blue, width: 1),
);

Color color = Colors.blue[100]!;
bool showCheckmark = true;
Color unSelectedColor = Colors.white;
TextStyle textStyle = const TextStyle(fontWeight: FontWeight.w600);

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: MaxArticlePerPage(),
            ),
            const CategoryList(),
            //const SortBy(),
            const Flexible(
              fit: FlexFit.loose,
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: TextButton(
                onPressed: () {
                  filterBloc.add(UserClearedAllFiltersEvent());
                },
                child: const Text("Clear all filters"),
              ),
            ),
          ],
        ),
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
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        debugPrint("state is $state");
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 16),
              child: Text(
                "Sort By",
                style: textStyle,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: padding,
                  child: ChoiceChip(
                      backgroundColor: unSelectedColor,
                      onSelected: (value) {
                        filterBloc.add(
                          const UserUpdatedSortByEvent(
                            sortBy: SortNewsBy.relevancy,
                          ),
                        );
                      },
                      shape: chipBorder,
                      padding: padding,
                      selectedColor: color,
                      showCheckmark: showCheckmark,
                      label: const Text("Relevancy"),
                      selected: filterBloc.sortByValues[SortNewsBy.relevancy]!),
                ),
                Padding(
                  padding: padding,
                  child: ChoiceChip(
                    onSelected: (value) {
                      filterBloc.add(
                        const UserUpdatedSortByEvent(
                          sortBy: SortNewsBy.popularity,
                        ),
                      );
                    },
                    shape: chipBorder,
                    backgroundColor: Colors.white,
                    padding: padding,
                    label: const Text("Popularity"),
                    selected: filterBloc.sortByValues[SortNewsBy.popularity]!,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                  ),
                ),
                Padding(
                  padding: padding,
                  child: ChoiceChip(
                      backgroundColor: unSelectedColor,
                      onSelected: (value) {
                        filterBloc.add(
                          const UserUpdatedSortByEvent(
                            sortBy: SortNewsBy.publishedAt,
                          ),
                        );
                      },
                      shape: chipBorder,
                      padding: padding,
                      selectedColor: color,
                      showCheckmark: showCheckmark,
                      label: const Text("Date Published"),
                      selected:
                          filterBloc.sortByValues[SortNewsBy.publishedAt]!),
                ),
              ],
            ),
          ],
        );
      },
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
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 16),
              child: Text(
                "Category",
                style: textStyle,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: padding,
                  child: FilterChip(
                    backgroundColor: unSelectedColor,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                    padding: padding,
                    shape: chipBorder,
                    selected:
                        filterBloc.categoryFilterValues[Category.business]!,
                    label: const Text(
                      "Business",
                    ),
                    onSelected: (bool value) {
                      filterBloc.add(const UserUpdatedCategoryEvent(
                          category: Category.business));
                    },
                  ),
                ),
                Padding(
                  padding: padding,
                  child: FilterChip(
                    backgroundColor: unSelectedColor,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                    shape: chipBorder,
                    padding: padding,
                    selected: filterBloc
                        .categoryFilterValues[Category.entertainment]!,
                    label: const Text(
                      "Entertainment",
                    ),
                    onSelected: (bool value) {
                      filterBloc.add(const UserUpdatedCategoryEvent(
                          category: Category.entertainment));
                    },
                  ),
                ),
                Padding(
                  padding: padding,
                  child: FilterChip(
                    backgroundColor: unSelectedColor,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                    shape: chipBorder,
                    padding: padding,
                    selected:
                        filterBloc.categoryFilterValues[Category.general]!,
                    label: const Text(
                      "General",
                    ),
                    onSelected: (bool value) {
                      filterBloc.add(const UserUpdatedCategoryEvent(
                          category: Category.general));
                    },
                  ),
                ),
                Padding(
                  padding: padding,
                  child: FilterChip(
                    backgroundColor: unSelectedColor,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                    shape: chipBorder,
                    padding: padding,
                    selected: filterBloc.categoryFilterValues[Category.health]!,
                    label: const Text(
                      "Health",
                    ),
                    onSelected: (bool value) {
                      filterBloc.add(const UserUpdatedCategoryEvent(
                          category: Category.health));
                    },
                  ),
                ),
                Padding(
                  padding: padding,
                  child: FilterChip(
                    backgroundColor: unSelectedColor,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                    shape: chipBorder,
                    padding: padding,
                    selected:
                        filterBloc.categoryFilterValues[Category.science]!,
                    label: const Text(
                      "Science",
                    ),
                    onSelected: (bool value) {
                      filterBloc.add(const UserUpdatedCategoryEvent(
                          category: Category.science));
                    },
                  ),
                ),
                Padding(
                  padding: padding,
                  child: FilterChip(
                    backgroundColor: unSelectedColor,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                    shape: chipBorder,
                    padding: padding,
                    selected: filterBloc.categoryFilterValues[Category.sports]!,
                    label: const Text(
                      "Sports",
                    ),
                    onSelected: (bool value) {
                      filterBloc.add(const UserUpdatedCategoryEvent(
                          category: Category.sports));
                    },
                  ),
                ),
                Padding(
                  padding: padding,
                  child: FilterChip(
                    backgroundColor: unSelectedColor,
                    selectedColor: color,
                    showCheckmark: showCheckmark,
                    shape: chipBorder,
                    padding: padding,
                    selected:
                        filterBloc.categoryFilterValues[Category.technology]!,
                    label: const Text(
                      "Technology",
                    ),
                    onSelected: (bool value) {
                      filterBloc.add(const UserUpdatedCategoryEvent(
                          category: Category.technology));
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MaxArticlePerPage extends StatelessWidget {
  const MaxArticlePerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Articles/Page ",
          style: textStyle,
        ),
        const ArticlesCountSlider(),
      ],
    );
  }
}

class ArticlesCountSlider extends StatelessWidget {
  const ArticlesCountSlider({super.key});
  @override
  Widget build(BuildContext context) {
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return SliderTheme(
          data: const SliderThemeData(
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.blue,
              valueIndicatorTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
          child: Expanded(
            child: Slider(
              allowedInteraction: SliderInteraction.tapAndSlide,
              label: filterBloc.articlesPerPage.toString(),
              value: filterBloc.articlesPerPage.toDouble(),
              onChanged: (value) {
                filterBloc.add(
                  UserUpdatedArticlesPerPageEvent(
                    maxArticlesPerPage: value.toInt(),
                  ),
                );
              },
              max: 100,
              divisions: 9,
              min: 10,
            ),
          ),
        );
      },
    );
  }
}

class CountryMenuList extends StatelessWidget {
  final Map<String, String> countryNameAndCode;
  const CountryMenuList({super.key, required this.countryNameAndCode});

  @override
  Widget build(BuildContext context) {
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 30, 148, 245),
                  width: 2,
                ),
              ),
              height: MediaQuery.of(context).size.height * .60,
              width: MediaQuery.of(context).size.width * .5,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: countryNameAndCode.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      debugPrint(
                          "country ${countryNameAndCode.entries.toList()[index].key} selected");
                      filterBloc.add(UserUpdatedCountryEvent(
                          country:
                              countryNameAndCode.entries.toList()[index].key));
                      filterBloc.add(UserFilterFinalizedEvent());
                      filterBloc.add(const CloseCountrySelectionMenuEvent());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color.fromARGB(255, 30, 148, 245),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          countryNameAndCode.entries.toList()[index].key,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                filterBloc.add(const CloseCountrySelectionMenuEvent());
              },
              icon: const Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}
