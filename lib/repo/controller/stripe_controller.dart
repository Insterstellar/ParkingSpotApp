import 'package:parking/models/ProductRequest.dart';

import '../../models/PaymentIntentSheet.dart';
import '../../models/stripe_response.dart';
import '../services/product_request_service.dart';

class StripeController {
  final ProductRequestService productRequestService;

  StripeController(this.productRequestService);

  Future<PaymentIntentSheet> stripeResponse (ProductRequest productRequest) async{

    return productRequestService.productRequest(productRequest);

  }
}