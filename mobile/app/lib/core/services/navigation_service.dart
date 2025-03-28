import 'package:flutter/material.dart';

abstract class NavigationService {
  GlobalKey<NavigatorState> get navigatorKey;
  Future<dynamic> navigateTo(String routeName, {Object? arguments});
  Future<dynamic> replaceTo(String routeName, {Object? arguments});
  void goBack({dynamic result});
}

class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return _navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> replaceTo(String routeName, {Object? arguments}) {
    return _navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  void goBack({dynamic result}) {
    return _navigatorKey.currentState!.pop(result);
  }
}

