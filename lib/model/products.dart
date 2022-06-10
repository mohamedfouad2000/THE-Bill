class productss {
  String? pro;
  int? num;
  int? price;

  productss({required this.pro, required this.num, required this.price});

  productss.fromJson(Map<String, dynamic> json) {
    pro = json['pro'];
    num = json['num'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pro'] = this.pro;
    data['num'] = this.num;
    data['price'] = this.price;
    return data;
  }
}
