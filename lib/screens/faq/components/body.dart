import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:localservice/localization/language/languages.dart';
import 'package:localservice/services/AppService.dart';
import 'package:provider/provider.dart';
import 'package:localservice/theme/theme_colors.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  final bool isSearch;
  Body({required this.isSearch});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoaded = false;
  dynamic faqList;
  dynamic faqSearchList;
  late AppService _appService;
  TextEditingController editingController = TextEditingController();
  final _headerStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  final _contentStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    getFaqList();

    super.initState();
  }

  Future<void> getFaqList() async {
    dynamic response = await _appService.getFaqList();
    if (!mounted) return;

    if (response is String || response == null) {
      faqList = null;
      setState(() {
        isLoaded = true;
      });
      return;
    }
    setState(() {
      isLoaded = true;
    });
    faqList = response.data['data'];
    faqSearchList = faqList;
  }

  void filterSearchResults(String query) {
    faqSearchList = [];
    if (query.isNotEmpty) {
      faqList.forEach((item) {
        if (item['title'].contains(new RegExp(query, caseSensitive: false)) ||
            item['description']
                .contains(new RegExp(query, caseSensitive: false))) {
          faqSearchList.add(item);
        }
      });
      setState(() {});
      return;
    } else {
      setState(() {
        faqSearchList = faqList;
      });
    }
  }

  @override
  build(context) => Scaffold(
        body: !isLoaded
            ? Center(
                child: Container(
                width: 100,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballZigZag,
                    colors: [
                      context
                          .watch<AppService>()
                          .themeState
                          .customColors[AppColors.loadingIndicatorColor]!
                    ],
                    strokeWidth: 2,
                    backgroundColor: Colors.transparent,
                    pathBackgroundColor:
                        context.watch<AppService>().themeState.customColors[
                            AppColors.loadingIndicatorBackgroundColor]),
              ))
            : faqList == null
                ? SizedBox()
                : faqList.length == 0
                    ? Center(
                        child: Text(
                          Languages.of(context)!.noSearchResult,
                        ),
                      )
                    : Column(children: [
                        widget.isSearch
                            ? Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  onChanged: (value) {
                                    filterSearchResults(value);
                                  },
                                  controller: editingController,
                                  decoration: InputDecoration(
                                      labelText: Languages.of(context)!.search,
                                      hintText: Languages.of(context)!.search,
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)))),
                                ),
                              )
                            : Container(),
                        Expanded(
                            child: RefreshIndicator(
                                child: Accordion(
                                  maxOpenSections: 1,
                                  headerBackgroundColorOpened: !context
                                          .watch<AppService>()
                                          .themeState
                                          .isDarkTheme!
                                      ? Colors.white
                                      : darkThemeCardBackgroundColor,
                                  scaleWhenAnimating: true,
                                  openAndCloseAnimation: true,
                                  headerPadding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                  sectionOpeningHapticFeedback:
                                      SectionHapticFeedback.heavy,
                                  sectionClosingHapticFeedback:
                                      SectionHapticFeedback.light,
                                  children: [
                                    for (var faq in faqSearchList)
                                      AccordionSection(
                                        isOpen: false,
                                        headerBackgroundColor: !context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme!
                                            ? Colors.white
                                            : Color.fromRGBO(56, 59, 64, 1),
                                        headerBackgroundColorOpened: !context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme!
                                            ? Colors.white
                                            : darkThemeCardBackgroundColor,
                                        contentBackgroundColor: !context
                                                .watch<AppService>()
                                                .themeState
                                                .isDarkTheme!
                                            ? Colors.white
                                            : darkThemeCardBackgroundColor,
                                        header: Text(faq['title'],
                                            style: _headerStyle),
                                        content: Text(faq['description'],
                                            style: _contentStyle),
                                        rightIcon: const Icon(
                                            Icons.chevron_right_rounded,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1)),
                                        contentHorizontalPadding: 17,
                                        contentBorderWidth: 0,
                                        contentBorderRadius: 5,
                                        flipRightIconIfOpen: false,
                                      )
                                  ],
                                ),
                                onRefresh: () {
                                  return getFaqList();
                                }))
                      ]),
      );
} //__
