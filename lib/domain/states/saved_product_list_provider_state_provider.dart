import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';

final savedProductListStateProvider = StateProvider((ref) => <ProductModel>[]);
