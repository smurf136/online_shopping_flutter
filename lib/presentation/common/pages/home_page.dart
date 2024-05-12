import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/constants/home_tab_content.dart';
import '../../../domain/states/current_home_page_tab_content_state_provider.dart';
import '../widgets/cart_tab_content.dart';
import '../widgets/home_tab_content.dart';
import '../widgets/saved_tab_content.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: {
        HomePageTabContent.home: HomeTabContent(),
        HomePageTabContent.saved: const SavedTabContent(),
        HomePageTabContent.cart: const CartTabContent(),
      }[ref.watch(currentHomePageTabContentStateProvider)],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          ref.read(currentHomePageTabContentStateProvider.notifier).state = HomePageTabContent.values[index];
        },
        currentIndex: ref.read(currentHomePageTabContentStateProvider).index,
        items: const [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: 'home'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart), activeIcon: FaIcon(FontAwesomeIcons.solidHeart), label: 'saved'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cartShopping), label: 'cart'),
        ],
      ),
    );
  }
}
