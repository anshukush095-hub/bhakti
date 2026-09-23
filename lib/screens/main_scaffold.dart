import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/ad_banner_widget.dart';
import 'home_screen.dart';
import 'puja_vidhi_screen.dart';
import 'panchang_screen.dart';
import 'saved_lists_screen.dart';
import 'settings_screen.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    Widget currentBody;
    switch (appState.currentNavIndex) {
      case 0:
        currentBody = const HomeScreen();
        break;
      case 1:
        currentBody = const PujaVidhiScreen();
        break;
      case 2:
        currentBody = const PanchangScreen();
        break;
      case 3:
        currentBody = const SavedListsScreen();
        break;
      case 4:
        currentBody = const SettingsScreen();
        break;
      default:
        currentBody = const HomeScreen();
    }

    return Scaffold(
      body: currentBody,
      bottomNavigationBar: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AdBannerWidget(),
          PujaBottomNavBar(),
        ],
      ),
    );
  }
}
