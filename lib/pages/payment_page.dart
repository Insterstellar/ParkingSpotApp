import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/widgets/custom_button.dart';
import 'package:parking/widgets/custom_text.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: MyColors.grey_90,
                      borderRadius: BorderRadius.circular(50),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Icon(Icons.arrow_back, color: MyColors.grey_20),
                    )),
                CustomText(text: "Payment", fontWeight: FontWeight.w400, fontSize: 18, textColor: MyColors.grey_10),
                SizedBox(width: 10,)

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Payment", fontWeight: FontWeight.w400, fontSize: 30, textColor: MyColors.grey_10),
                    CustomText(text: "Method", fontWeight: FontWeight.w400, fontSize: 30, textColor: MyColors.grey_10),

                  ],
                ),
                Row(
                  children: [
                    Container(

                        decoration: BoxDecoration(
                          color: MyColors.grey_90,
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.wallet, color: MyColors.grey_20,),
                        )),
                    SizedBox(width: 10,),

                    Container(
                        decoration: BoxDecoration(
                          color: MyColors.grey_90,
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.account_balance, color: MyColors.grey_20),
                        )),
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            CustomText(text: "Bank Account", fontWeight: FontWeight.w600, fontSize: 20, textColor: MyColors.grey_20),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: MyColors.primary6_light,
                            borderRadius: BorderRadius.circular(50),

                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(23.0),
                            child: Icon(Icons.wallet, color: MyColors.primary6,),
                          )),
                      SizedBox(width: 10,),
                      Expanded(
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "National Bank", fontWeight: FontWeight.w400, fontSize: 18, textColor: MyColors.grey_20),
                            CustomText(text: "Bank Pay", fontWeight: FontWeight.w200, fontSize: 12, textColor: MyColors.grey_20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Icon(Icons.arrow_forward_ios_outlined, color: MyColors.grey_20,),
                ),

              ],
            ),
            SizedBox(height: 25,),
            CustomText(text: "Credit cards", fontWeight: FontWeight.w600, fontSize: 20, textColor: MyColors.grey_20),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: Row(

                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: MyColors.primary6_light,
                            borderRadius: BorderRadius.circular(50),

                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(23.0),
                            child: Icon(Icons.credit_card_outlined, color: MyColors.primary6,),
                          )),
                      SizedBox(width: 10,),
                      Expanded(
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "125363*********6474", fontWeight: FontWeight.w400, fontSize: 18, textColor: MyColors.grey_20),
                            CustomText(text: "Visa Pay", fontWeight: FontWeight.w200, fontSize: 12, textColor: MyColors.grey_20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                const Padding(
                  padding: EdgeInsets.all(23.0),
                  child: Icon(Icons.arrow_forward_ios_outlined, color: MyColors.grey_20,),
                ),

              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: MyColors.primary6_light,
                            borderRadius: BorderRadius.circular(50),

                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(23.0),
                            child: Icon(Icons.account_balance_wallet, color: MyColors.primary6,),
                          )),
                      SizedBox(width: 10,),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "3299********5252", fontWeight: FontWeight.w400, fontSize: 18, textColor: MyColors.grey_20),
                            CustomText(text: "Google pay", fontWeight: FontWeight.w200, fontSize: 12, textColor: MyColors.grey_20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Icon(Icons.arrow_forward_ios_outlined, color: MyColors.grey_20,),
                ),

              ],
            ),
            SizedBox(height: 30,),


            CustomButton(buttonText: "Continue", onTap: (){}, buttonTextColor: MyColors.primary1,btnColor: MyColors.primary6,),










          ],
        ),
      ),
    );
  }
}
