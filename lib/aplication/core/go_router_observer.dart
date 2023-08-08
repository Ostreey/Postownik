import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver{
  GoRouterObserver();
  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint("did pop ${route.settings.name} from previous ${previousRoute?.settings.name}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint("did push ${route.settings.name} from previous ${previousRoute?.settings.name}");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint("did remove${route.settings.name} from previous ${previousRoute?.settings.name}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {

  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    debugPrint("did remove${route.settings.name} from previous ${previousRoute?.settings.name}");
  }

  @override
  void didStopUserGesture() {
    debugPrint("did stop gesture");
  }

}