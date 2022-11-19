const String tableNotes = 'notes';

class TableDetails {
  static final List values = [
    /// Add all fields
    id,
    name,
    title,
    product,
    status,
    remark,
    createdAt,
    image,
    price,
  ];
  static const String id = 'id';
  static const String name = 'name';
  static const String title = 'title';
  static const String product = 'product';
  static const String status = 'status';
  static const String remark = 'remark';
  static const String createdAt = 'createdAt';
  static const String image = 'image';
  static const String price = 'price';
}

class UserDetailsModel {
  String name;
  String title;
  String product;
  bool status;
  String remark;
  String createdAt;
  String image;
  num price;
  num id;

  UserDetailsModel({
    required this.name,
    required this.title,
    required this.product,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.image,
    required this.price,
    required this.id,
  });
  UserDetailsModel copy({
    int? id,
    String? name,
    String? title,
    String? product,
    bool? status,
    String? remark,
    String? createdAt,
    String? image,
    num? price,
  }) =>
      UserDetailsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        title: title ?? this.title,
        product: product ?? this.product,
        status: status ?? this.status,
        remark: remark ?? this.remark,
        createdAt: createdAt ?? this.createdAt,
        image: image ?? this.image,
        price: price ?? this.price,
      );
  factory UserDetailsModel.fromJson(dynamic json) {
    return UserDetailsModel(
      id: json['id'] == null ? 0 : json['id'] as num,
      name: json['name'] == null ? '' : json['name'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      product: json['product'] == null ? '' : json['product'] as String,
      status: json['status'] == null ? false : json['status'] as bool,
      remark: json['remark'] == null ? '' : json['remark'] as String,
      createdAt: json['createdAt'] == null ? '' : json['createdAt'] as String,
      image: json['image'] == null ? '' : json['image'] as String,
      price: json['price'] == null ? 0 : json['price'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id']['name'] = name;
    data['title'] = title;
    data['product'] = product;
    data['status'] = status;
    data['remark'] = remark;
    data['createdAt'] = createdAt;
    data['image'] = image;
    data['price'] = price;
    data['id'] = id;
    return data;
  }
}
