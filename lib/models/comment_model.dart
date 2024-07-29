class Comments {
  String customerName;
  String comment;
  String rating;

  Comments({this.customerName, this.comment, this.rating});

  Comments.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_name'] = customerName;
    data['comment'] = comment;
    data['rating'] = rating;
    return data;
  }
}
