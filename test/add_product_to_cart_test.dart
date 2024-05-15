import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_shopping_flutter/domain/states/cart_product_state_provider.dart';
import 'package:online_shopping_flutter/main.dart';
import 'package:online_shopping_flutter/presentation/common/widgets/cart_item.dart';
import 'package:online_shopping_flutter/presentation/common/widgets/product_item.dart';
import 'package:online_shopping_flutter/presentation/product/pages/product_detail_page.dart';

void main() {
  group('add product to cart', () {
    testWidgets('add 1 product', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      final element = tester.element(find.byType(MyApp));
      final container = ProviderScope.containerOf(element);

      await tester.tap(find.text('home'));

      await tester.tap(find.byType(ProductItem).first);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(ProductDetailPage.addToCartButtonKey));
      await tester.pumpAndSettle();

      expect(container.read(cartProductStateProvider).keys.length, 0);

      await tester.tap(find.byKey(ProductDetailPage.addToCartButtonKey));

      expect(container.read(cartProductStateProvider).keys.length, 1);

      await tester.tap(find.byKey(ProductDetailPage.backButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.text('cart'));
      await tester.pumpAndSettle();

      expect(find.byType(CartItem), findsOneWidget);
    });

    testWidgets('add 2 product', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      final element = tester.element(find.byType(MyApp));
      final container = ProviderScope.containerOf(element);

      await tester.tap(find.text('home'));

      await tester.tap(find.byType(ProductItem).at(0));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(ProductDetailPage.addToCartButtonKey));
      await tester.pumpAndSettle();

      expect(container.read(cartProductStateProvider).keys.length, 0);

      await tester.tap(find.byKey(ProductDetailPage.addToCartButtonKey));

      expect(container.read(cartProductStateProvider).keys.length, 1);

      await tester.tap(find.byKey(ProductDetailPage.backButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ProductItem).at(1));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(ProductDetailPage.addToCartButtonKey));
      await tester.pumpAndSettle();

      expect(container.read(cartProductStateProvider).keys.length, 1);

      await tester.tap(find.byKey(ProductDetailPage.addToCartButtonKey));

      expect(container.read(cartProductStateProvider).keys.length, 2);

      await tester.tap(find.byKey(ProductDetailPage.backButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.text('cart'));
      await tester.pumpAndSettle();

      expect(find.byType(CartItem), findsExactly(2));
    });
  });
}
