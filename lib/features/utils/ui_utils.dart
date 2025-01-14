import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

void setTopNavBarIndex(BuildContext context, int index) {
  DefaultTabController.of(context).index = index;
  AutoTabsRouter.of(context).setActiveIndex(index);
}
