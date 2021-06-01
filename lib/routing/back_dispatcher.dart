import 'package:flutter/material.dart';
import 'router_delegate.dart';

class EminBackButtonDispatcher extends RootBackButtonDispatcher {
  final EminRouterDelegate _routerDelegate;

  EminBackButtonDispatcher(this._routerDelegate) : super();

  @override
  Future<bool> didPopRoute() {
    print("Back pressed");
    return _routerDelegate.popRoute();
  }
}
