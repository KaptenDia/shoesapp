import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jogjasport/theme.dart';
import 'package:jogjasport/widgets/order_card.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      Provider.of<TransactionProvider>(context, listen: false)
          .getTransactions(authProvider.user.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor3,
      appBar: AppBar(
        backgroundColor: bgColor1,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Order Page',
          style: primarytextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: transactionProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 24,
                    ),
                    itemCount: transactionProvider.transactions.length,
                    itemBuilder: (context, index) {
                      var transaction = transactionProvider.transactions[index];
                      return GestureDetector(
                        onTap: () {
                          var transaction =
                              transactionProvider.transactions[index];
                          log('Transaction: ${transaction.toJson()}');
                          if (transaction.items != null) {
                            log('Transaction items count: ${transaction.items.length}');
                            if (transaction.items.isNotEmpty) {
                              var firstItem = transaction.items[0];
                              log('First item: ${firstItem.toJson()}');
                              log('First item type: ${firstItem.type}');
                              Navigator.pushNamed(
                                context,
                                '/order-detail-page',
                                arguments: {
                                  'products': transaction.items,
                                },
                              );
                            } else {
                              log('No items in this transaction.');
                            }
                          } else {
                            log('Transaction data is null.');
                          }
                        },
                        child: OrderCard(
                          totalPrice: 'Rp.${transaction.totalPrice}',
                          status: transaction.status,
                          idTransaction: transaction.id.toString(),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
