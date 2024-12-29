import 'dart:convert';

import 'package:parking/data/urls.dart';
import 'package:parking/models/ProductRequest.dart';
import 'package:parking/repo/interface/stripe_interface.dart';
import 'package:http/http.dart' as http;

import '../../models/PaymentIntentSheet.dart';
import '../../models/stripe_response.dart';

class ProductRequestService implements StripeInterface {


  @override
  Future<PaymentIntentSheet> productRequest(ProductRequest productRequest) async{
    PaymentIntentSheet request ;
    var url= Uri.parse("${Urls.baseUrl}api/v1/checkout");
    var response = await http.post(url,  headers:{'Content-Type': 'application/json'},
        body: jsonEncode(productRequest));

    if(response.statusCode==200){
      var body = json.decode(response.body);
      print("stripe succeded =------"+response.statusCode.toString());
     return request = PaymentIntentSheet.fromJson(body);


    }else {
      print("---------------stripe check did not succed");
      print("stripe statis code =------"+response.statusCode.toString());
      return PaymentIntentSheet();
      throw UnimplementedError();
    }

    // TODO: implement productRequest

  }

}