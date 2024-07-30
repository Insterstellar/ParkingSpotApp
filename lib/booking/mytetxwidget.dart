import 'package:flutter/cupertino.dart';
import 'package:parking/misc/mycolors/mycolors.dart';

import '../widgets/custom_text.dart';

class MytxtWidget extends StatelessWidget {
 String newTxt;
   MytxtWidget({super.key, required this.newTxt});

  @override
  Widget build(BuildContext context) {
    return CustomText(text:newTxt, fontWeight: FontWeight.bold, fontSize: 25 ,textColor:MyColors.primary1 );
  }
}
