import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:parking/widgets/custom_button.dart';

class CustomCardPaymentScreen extends StatefulWidget {
  const CustomCardPaymentScreen({super.key});

  @override
  _CustomCardPaymentScreenState createState() =>
      _CustomCardPaymentScreenState();
}

class _CustomCardPaymentScreenState extends State<CustomCardPaymentScreen> {
  CardDetails _card = CardDetails();
  bool? _saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                   "nuljjl")),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Number'),
                      onChanged: (number) {
                        setState(() {
                          _card = _card.copyWith(number: number);
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    width: 80,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Exp. Year'),
                      onChanged: (number) {
                        setState(() {
                          _card = _card.copyWith(
                              expirationYear: int.tryParse(number));
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    width: 80,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Exp. Month'),
                      onChanged: (number) {
                        setState(() {
                          _card = _card.copyWith(
                              expirationMonth: int.tryParse(number));
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    width: 80,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'CVC'),
                      onChanged: (number) {
                        setState(() {
                          _card = _card.copyWith(cvc: number);
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            CheckboxListTile(
              value: _saveCard,
              onChanged: (value) {
                setState(() {
                  _saveCard = value;
                });
              },
              title: Text('Save card during payment'),
            ),
           CustomButton(buttonText: "Pay", onTap: (){})
          ],
        ),
      ),
    );
  }}