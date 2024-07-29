import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jogjasport/theme.dart';

import '../models/transaction_model.dart';

class OrderDetailPage extends StatelessWidget {
  final List<Items> product;
  const OrderDetailPage({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic> ??
            {};

    final List<Items> products = args['products'] as List<Items> ?? [];
    log('Received products count: ${products.length}');
    log('First product type: ${products.isNotEmpty ? products[0].type : 'No products'}');
    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        backgroundColor: bgColor1,
        centerTitle: true,
        title: const Text(
          'Detail Pesanan',
        ),
        elevation: 0,
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
                'Kosong',
                style: primarytextStyle,
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        products[index].id.toString() ?? 'Unknown Product',
                        style: primarytextStyle,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
