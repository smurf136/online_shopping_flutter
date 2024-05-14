import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../domain/states/cart_product_state_provider.dart';
import '../../../extensions/string_x.dart';
import '../../common/widgets/custom_outline_button.dart';
import '../../common/widgets/custom_snackbar.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  static const path = '/payment_page';

  static Future<void> show(
    BuildContext context, {
    required double price,
  }) async {
    Navigator.pushNamed(context, path, arguments: {
      'price': price,
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CupertinoButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.of(context).pop();
          },
          child: const FaIcon(FontAwesomeIcons.angleLeft),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 45),
            Center(
              child: QrImageView(
                data: 'https://payment-api.yimplaHorm.com/checkout?price=${args['price'] ?? 0}',
                size: 200,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text('Scan & Pay', style: Theme.of(context).textTheme.headlineMedium),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text('\$ ${(args['price'].toString()).currency}', style: Theme.of(context).textTheme.headlineMedium),
            ),
            const SizedBox(height: 32),
            Consumer(
              builder: (inContext, ref, _) {
                return CustomOutlineButton(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  title: 'Payment Success',
                  onPressed: () {
                    ref.read(cartProductStateProvider.notifier).state = {};

                    Navigator.of(context).pop();
                    CustomSnackbar.show(context, title: 'payment success');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
