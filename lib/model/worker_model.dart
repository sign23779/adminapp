class WorkerModel {
  final String? image;
  final String username;
  final String email;
  final String phonenumber;
  final String mainservice;
  final String specificservice;
  final String password;
  final String address;
  final String postalcode;
  final String datetime;
  final dynamic pdf;
  bool isAvailable;

  WorkerModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.datetime,
      required this.phonenumber,
      required this.image,
      required this.postalcode,
      required this.address,
      required this.mainservice,
      required this.specificservice,
      required this.pdf,
      required this.isAvailable});
  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'address': address,
        'phonenumber': phonenumber,
        'postalcode': postalcode,
        'datetime': datetime,
        'image': image,
        'mainservice': mainservice,
        'specificservice': specificservice,
        'pdf': pdf,
        'isAvailable': isAvailable
      };

  static WorkerModel fromJson(Map<String, dynamic> json) => WorkerModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      phonenumber: json['phonenumber'],
      postalcode: json['postalcode'],
      datetime: json['datetime'],
      image: json['image'],
      mainservice: json['mainservice'],
      specificservice: json['specificservice'],
      pdf: json['pdf'],
      isAvailable: json['isAvailable']);
}
