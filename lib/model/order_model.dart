class OrderModel {
  final String mainservicename;
  final String specificservicename;
  final String subcate;
  final String price;
  final String orderid;
  String orderquantity;
  String totalprice;
  final bool isFinished;
  final bool isPending;
  String datetime;
  final String address;
  String flatno;
  String contactname;
  String landmark;
  String userphoneNumber;
  String paymentmethod;
  String? workstartimage;
  String? workfinishimage;

  OrderModel(
      {required this.subcate,
      required this.flatno,
      required this.contactname,
      required this.landmark,
      required this.totalprice,
      required this.orderid,
      required this.mainservicename,
      required this.specificservicename,
      required this.orderquantity,
      required this.price,
      required this.isPending,
      required this.isFinished,
      required this.datetime,
      required this.address,
      required this.userphoneNumber,
      required this.paymentmethod,
      this.workfinishimage,
      this.workstartimage});
  Map<String, dynamic> toJson() => {
        'subcate': subcate,
        'orderid': orderid,
        'mainservicename': mainservicename,
        'price': price,
        'totalprice': totalprice,
        'orderquantity': orderquantity,
        'isFinished': isFinished,
        'isPending': isPending,
        'datetime': datetime,
        'address': address,
        'landmark': landmark,
        'contactname': contactname,
        'flatno': flatno,
        'specificservicename': specificservicename,
        'phonenum': userphoneNumber,
        'paymentmethod': paymentmethod,
        'workstartimage': workstartimage,
        'workfinishimage': workfinishimage
      };

  static OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
      subcate: json["subcate"],
      flatno: json["flatno"],
      contactname: json["contactname"],
      landmark: json["landmark"],
      totalprice: json['totalprice'],
      orderquantity: json['orderquantity'],
      mainservicename: json['mainservicename'],
      orderid: json['orderid'],
      price: json['price'],
      isFinished: json['isFinished'],
      isPending: json['isPending'],
      datetime: json['datetime'],
      address: json['address'],
      specificservicename: json['specificservicename'],
      userphoneNumber: json['phonenum'],
      paymentmethod: json['paymentmethod'],
      workfinishimage: json['workfinishimage'],
      workstartimage: json['workstartimage']);
}
