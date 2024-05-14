import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_model.dart';

// Map with [id] as a key and [amount] as a value
final cartProductStateProvider = StateProvider((ref) => <String, CartModel>{});
