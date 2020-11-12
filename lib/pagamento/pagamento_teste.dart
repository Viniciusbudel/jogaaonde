import 'package:flutter/material.dart';
import 'package:mercado_pago_integration/core/failures.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:mercado_pago_integration/models/payment.dart';

final Map<String, Object> preference = {
  'items': [
    {
      'title': 'Test Product',
      'description': 'Description',
      'quantity': 3,
      'currency_id': 'ARS',
      'unit_price': 1500,
    }
  ],
  'payer': {'name': 'Buyer G.', 'email': 'test@gmail.com'},
};

class PagamentoTeste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercado Pago Integration Example'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            (await MercadoPagoIntegration.startCheckout(
              publicKey: "TEST-cb6fcf00-0dc2-4d60-abb7-c5b2f072a75f",
              preference: preference,
              accessToken: "TEST-373716422145450-111002-2c5edffd163aaf27791da1785da6ab91-216354271",
            ))
                .fold((Failure failure) {
              debugPrint('Failure => ${failure.message}');
            }, (Payment payment) {
              debugPrint('Payment => ${payment.paymentId}');
            });
          },
          child: Text('Test Integration'),
        ),
      ),
    );
  }
}
