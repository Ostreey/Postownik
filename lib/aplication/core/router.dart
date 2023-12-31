
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/core/go_router_observer.dart';
import 'package:postownik/aplication/pages/change_company_details_page/change_company_details.dart';
import 'package:postownik/aplication/pages/facebook_login/facebook_login.dart';
import 'package:postownik/aplication/pages/facebook_pages/facebook_pages_page.dart';
import 'package:postownik/aplication/pages/generate_image_page/generate_image_page.dart';
import 'package:postownik/aplication/pages/home_page/home_page.dart';

import 'package:postownik/aplication/pages/setup_page/setup_page.dart';

import '../pages/generate_post/generate_post.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shellRoot');

const String _basePath = "/home";

final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/facebook_login',
    observers: [GoRouterObserver()],
    routes: [

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => child,
          routes: [
            GoRoute(path: '$_basePath/:tab',
            name: HomePage.pageConfig.name,
            builder: (context, state) =>  HomePage(
              key: state.pageKey,
              tab: state.pathParameters['tab']!,
            ),
            )
          ]
      ),
      GoRoute(
          path: '/setup_page',
          name: "/setup_page",
          builder: (context, state) {
            return SetupPage();
          }),
      GoRoute(
          path: '/change_company_details',
          name: ChangeCompanyDetailsPage.pageConfig.name,
          builder: (context, state) {
            return ChangeCompanyDetailsPage();
          }),
      GoRoute(
          path: '/facebook_login',
          name: FacebookLogin.pageConfig.name,
          builder: (context, state) {
            return FacebookLogin();
          }),
      GoRoute(
          path: '/facebook_pages',
          builder: (context, state) {
            return FacebookPagesPage();
          }),
    ]);
