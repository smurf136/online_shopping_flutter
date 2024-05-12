import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/common/pages/home_page.dart';
import 'presentation/product/pages/product_detail_page.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Online Shopping',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Colors.white70,
          useMaterial3: true,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepPurple,
          ),
          textTheme: TextTheme(
            labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.deepPurple),
          ),
        ),
        initialRoute: '/',
        routes: {
          HomePage.path: (context) => const HomePage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final route = settings.name ?? '';
          final args = (settings.arguments ?? {}) as Map<String, dynamic>;

          if (route.contains(ProductDetailPage.path)) {
            final productId = route.split('/').last;

            if (productId.isEmpty) return null;

            // TODO: waiting implement with api
            return MaterialPageRoute<String>(
              builder: (BuildContext context) => ProductDetailPage(
                id: productId,
                imageUrl: args['imageUrl'] ?? '',
                productName: args['productName'] ?? '',
                price: args['price'] ?? 0,
              ),
              settings: settings,
            );
          }

          return null;
        });
  }
}
