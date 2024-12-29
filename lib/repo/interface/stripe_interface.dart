import 'package:parking/models/ProductRequest.dart';

import '../../models/PaymentIntentSheet.dart';
import '../../models/stripe_response.dart';

abstract class StripeInterface {

  Future<PaymentIntentSheet> productRequest (ProductRequest productRequest);

}