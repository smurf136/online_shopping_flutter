import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_shopping_flutter/domain/states/saved_product_list_provider_state_provider.dart';
import 'package:online_shopping_flutter/main.dart';
import 'package:online_shopping_flutter/presentation/common/widgets/saved_button.dart';
import 'package:online_shopping_flutter/presentation/common/widgets/saved_item.dart';

void main() {
  group('saved product', () {
    testWidgets('save 1 product', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      final element = tester.element(find.byType(MyApp));
      final container = ProviderScope.containerOf(element);

      await tester.tap(find.text('home'));

      expect(container.read(savedProductListStateProvider).length, 0);

      await tester.tap(find.byType(SavedButton).first);

      expect(container.read(savedProductListStateProvider).length, 1);

      await tester.tap(find.text('saved'));
      await tester.pumpAndSettle();

      expect(find.byType(SavedItem), findsOneWidget);
    });

    testWidgets('save 2 product', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      final element = tester.element(find.byType(MyApp));
      final container = ProviderScope.containerOf(element);

      await tester.tap(find.text('home'));

      expect(container.read(savedProductListStateProvider).length, 0);

      await tester.tap(find.byType(SavedButton).at(0));
      await tester.tap(find.byType(SavedButton).at(1));

      expect(container.read(savedProductListStateProvider).length, 2);

      await tester.tap(find.text('saved'));
      await tester.pumpAndSettle();

      expect(find.byType(SavedItem), findsExactly(2));
    });

    testWidgets('remove all saved product', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      final element = tester.element(find.byType(MyApp));
      final container = ProviderScope.containerOf(element);

      await tester.tap(find.text('home'));

      expect(container.read(savedProductListStateProvider).length, 0);

      await tester.tap(find.byType(SavedButton).at(0));
      await tester.tap(find.byType(SavedButton).at(1));

      expect(container.read(savedProductListStateProvider).length, 2);

      await tester.tap(find.text('saved'));
      await tester.pumpAndSettle();

      expect(find.byType(SavedItem), findsExactly(2));

      await tester.tap(find.text('Remove all'));
      await tester.pumpAndSettle();

      expect(container.read(savedProductListStateProvider).length, 0);
      expect(find.byType(SavedItem), findsNothing);
    });
  });
}
