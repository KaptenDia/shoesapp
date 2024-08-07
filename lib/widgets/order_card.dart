import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogjasport/models/transaction_model.dart';
import 'package:jogjasport/providers/auth_provider.dart';
import 'package:jogjasport/providers/transaction_provider.dart';
import 'package:jogjasport/widgets/loading_button.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class OrderCard extends StatefulWidget {
  String? transactionId;
  String? status;
  String? totalPrice;
  List<Items>? items;
  BuildContext context;

  OrderCard({
    Key? key,
    this.transactionId,
    this.status,
    this.totalPrice,
    this.items,
    required this.context,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () => _showDialogOrder(context, authProvider),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffECEDEF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Id Transaksi # ${widget.transactionId ?? '-'}',
              style: pricetextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.price_change_rounded,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(widget.totalPrice ?? '-'),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.payment_rounded,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(widget.status ?? '-'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogOrder(BuildContext context, AuthProvider authProvider) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        builder: (builder){
          return new Container(
            width: double.infinity,
            color: Colors.transparent,
            child: new Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Detail Order", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    ListView.separated(
                      itemCount: widget.items!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 24,),
                      itemBuilder: (contexts, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    widget.items![index].product!.galleries!.isEmpty ? 'https://via.placeholder.com/215x150' : widget.items![index].product!.galleries!.first.url!,
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: Icon(
                                            Icons.warning_amber
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.items?[index].product?.name}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: blacktextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Warna : ${widget.items?[index].color?.color ?? '-'}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(","),
                                          SizedBox(width: 5,),
                                          Text(
                                            'Ukuran : ${widget.items?[index].size?.size ?? '-'}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: medium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        'Qty : ${widget.items?[index].quantity}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: medium,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.deepPurple
                                            ),
                                            child: Text("${widget.status}", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),),
                                          ),
                                          if(widget.status?.toUpperCase() == "DIKIRIM") ...[
                                            SizedBox(width: 10,),
                                            GestureDetector(
                                              onTap: () async {
                                                if (await TransactionProvider().updateTransaction(
                                                  orderId: widget.transactionId!,
                                                  token: authProvider.user.token!
                                                )) {
                                                  await TransactionProvider().getTransactions(authProvider.user.token!);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    backgroundColor: Colors.green,
                                                    content: const Text(
                                                      'Sukses selesaikan pesanan',
                                                    textAlign: TextAlign.center,
                                                    ),
                                                  ));
                                                } else {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    backgroundColor: alertColor,
                                                    content: const Text(
                                                      'Terjadi Kesalahan',
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ));
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.green
                                                ),
                                                child: Text("TERIMA PESANAN", style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                ),),
                                              ),
                                            ),
                                          ]
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      if(widget.status?.toUpperCase() == "SEDANG DIPROSES" || widget.status?.toUpperCase() == "DIKIRIM") ... [
                                        SizedBox(),
                                      ] else ...[
                                        if(widget.items![index].product!.comments!.isEmpty) ... [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              _dialogAddReview(context, widget.items![index].product!.id!, authProvider);
                                            },
                                            child: Text("Beri ulasan", style: TextStyle(
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline
                                            ),),
                                          ),
                                        ] else ...[
                                          Row(
                                            children: List.generate(
                                              5,
                                                  (indexs) {
                                                return Icon(
                                                  indexs < (widget.items![index].product!.comments!.isEmpty ? 0.0 : double.tryParse(widget.items![index].product!.comments!.first.rating ?? "0")!.toInt()) ? Icons.star : Icons.star_border,
                                                  color: Colors.amber,
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Divider(),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            "Ulasan : ${widget.items![index].product!.comments!.isEmpty ? '-' : widget.items?[index].product?.comments?.first.comment} ",
                                          )
                                        ]
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  ],
                )
            ),
          );
        }
    );
  }

  void _dialogAddReview(BuildContext context, int productId, AuthProvider authProvider) {
    var _ulasanTEC = TextEditingController();
    int _rating = 0;
    bool isLoading = false;

    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        builder: (builder){
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: new Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Tambah Ulasan", style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: _ulasanTEC,
                                  decoration: InputDecoration(
                                    labelText: 'Tulis ulasan Anda',
                                    border: const OutlineInputBorder(),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    isDense: true,
                                    counterText: '',
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12,),
                                Row(
                                  children: List.generate(
                                    5, (indexs) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _rating = indexs + 1;
                                          });
                                        },
                                        child: Icon(
                                          indexs < _rating ? Icons.star : Icons.star_border,
                                          color: Colors.amber,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 20,),
                                SizedBox(
                                  width: double.infinity,
                                  child: isLoading ? LoadingButton() : ElevatedButton(
                                    onPressed: () async {
                                      if(_ulasanTEC.text == '' || _rating == 0) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: alertColor,
                                            content: const Text(
                                              'Mohon Lengkapi Data',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (await TransactionProvider().addComment(
                                          comment: _ulasanTEC.text,
                                          rating: _rating,
                                          productId: productId,
                                          token: authProvider.user.token!
                                        )) {
                                          // await TransactionProvider().getTransactions(authProvider.user.token!);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            backgroundColor: Colors.green,
                                            content: const Text(
                                              'Sukses menambahkan ulasan',
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        } else {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            backgroundColor: alertColor,
                                            content: const Text(
                                              'Terjadi Kesalahan',
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        }

                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "Kirim Ulasan",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          );
                        }
                      )
                  )
                ),
            ),
          );
         }
    );
  }
}
