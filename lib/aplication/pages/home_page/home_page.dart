import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/pages/generate_post/generate_post.dart';
import 'package:postownik/aplication/pages/setup_page/setup_page.dart';

import '../../core/page_config.dart';
import '../generate_image_page/generate_image_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
  }) : index = tabs.indexWhere((element) {
    return element.name == tab;
  });

  static final tabs = [
    GeneratePostPage.pageConfig,
    GenerateImagePage.pageConfig
  ];

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.home_rounded,
    name: 'home',
  );

  final int index;

  @override
  State<HomePage> createState() => _HomePageState();
}

final destinations = HomePage.tabs
    .map(
      (page) => NavigationDestination(icon: Icon(page.icon), label: page.name),
    )
    .toList();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
          child: AdaptiveLayout(
        primaryNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('primary-navigation-medium'),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                trailing: IconButton(onPressed: (){
                  context.pushNamed(SetupPage.pageConfig.name);
                }, icon: Icon(Icons.settings)),
                onDestinationSelected: (index) => _tapOnNavigationDestination(context, index),
                selectedIndex: widget.index,
                destinations: destinations
                    .map(
                      (_) => AdaptiveScaffold.toRailDestination(_),
                    )
                    .toList(),
              ),
            ),
          },
        ),
        bottomNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key("bottom-navigation-small"),
              builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                  destinations: destinations,
                  onDestinationSelected: (index) =>
                      _tapOnNavigationDestination(context, index),
                  currentIndex: widget.index
              ),
            ),
          },
        ),
        body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key("primary-body-small"),
              builder: (_) => HomePage.tabs[widget.index].child)
        }),
        secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('secondary-body-medium'),
              builder: AdaptiveScaffold.emptyBuilder)
        }),
      )),
    );
  }
  void _tapOnNavigationDestination(BuildContext context, int index) => context.goNamed(
    HomePage.pageConfig.name,
    pathParameters: {
      'tab': HomePage.tabs[index].name,
    },
  );}
