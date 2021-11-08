import 'package:intl/intl.dart';

class Order {
  late String id;
  late bool isActive;
  late double price;
  late String company;
  late String picture;
  late String buyer;
  late List<String> tags;
  late Status status;
  late String registered;

  Order(
      {required this.id,
      required this.isActive,
      required this.price,
      required this.company,
      required this.picture,
      required this.buyer,
      required this.tags,
      required this.status,
      required this.registered});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    price = convertPrice(json['price']);
    company = json['company'];
    picture = json['picture'];
    buyer = json['buyer'];
    tags = json['tags'].cast<String>();
    status = convertStatus(json['status']);
    registered = convertDate(json['registered']);
  }

  Status convertStatus(String status) {
    switch (status) {
      case 'RETURNED':
        return Status.RETURNED;
      case 'ORDERED':
        return Status.ORDERED;
      case 'DELIVERED':
        return Status.DELIVERED;
      default:
        return Status.DELIVERED;
    }
  }

  double convertPrice(String price) {
    String x = price.replaceAll("\$", '').replaceAll(',', '');
    return double.parse(x);
  }

  String convertDate(String registered) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    var inputDate = inputFormat.parse(registered);
    var outputFormat = DateFormat('MMM');
    return outputFormat.format(inputDate);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isActive'] = this.isActive;
    data['price'] = this.price;
    data['company'] = this.company;
    data['picture'] = this.picture;
    data['buyer'] = this.buyer;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['registered'] = this.registered;
    return data;
  }
}

enum Status { ORDERED, DELIVERED, RETURNED }
