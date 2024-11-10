class ShoesModel {
  int? id;
  String? imageStr;
  String? name;
  double? price;
  int? quantity;
  int? size;
  String? description;

  double get total => (price ?? 0.0) * (quantity ?? 0);
  ShoesModel({
    this.id,
    this.imageStr,
    this.name,
    this.price,
    this.quantity,
    this.size,
    this.description,
  });
  ShoesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageStr = json['imageStr'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    size = json['size'];
    description = json['description'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageStr': imageStr,
      'name': name,
      'price': price,
      'quantity': quantity,
      'size': size,
      'description': description,
    };
  }
}

List<ShoesModel> cartItems = [];

List<ShoesModel> shoes = [
  ShoesModel()
    ..id = 1
    ..imageStr = 'assets/images/i1.png'
    ..name = 'Nike Jordan 1 Low FlyEase'
    ..price = 300
    ..quantity = 1
    ..size = 37
    ..description =
        'Lock in your style with this AJ1. We kept everything you love about the classic design—premium leather, Air cushioning, iconic Wings logo—while adding the Nike FlyEase closure system to make on and off a breeze. Getting out the door is now quicker than ever: just strap and zip.',
  ShoesModel()
    ..id = 2
    ..imageStr = 'assets/images/i2.png'
    ..name = 'Nike Air Max'
    ..price = 300
    ..quantity = 1
    ..size = 37
    ..description =
        'Meet the leader of the pack. Inspired by French architecture, celebrated in sport and revelled by fashion, this is the first shoe in the family that revealed Air to the world. With a fast-paced look, tried-and-tested cushioning and classic wavy mudguard, there is no wonder it is reigned supreme since 1987.',
  ShoesModel()
    ..id = 3
    ..imageStr = 'assets/images/i3.png'
    ..name = 'Nike Air Jordan 1 Low SE Craft'
    ..price = 200
    ..quantity = 2
    ..size = 37
    ..description =
        'Each Craft released puts a handmade feel on the AJ1 and these low-cut sneakers are no exception. Sandy neutrals come together in kicks that beg to be a part of every outfit. Premium suede adds texture while a lightly speckled outsole grounds your look with subtle detail.',
  ShoesModel()
    ..id = 4
    ..imageStr = 'assets/images/i4.png'
    ..name = 'Nike Dunk Low'
    ..size = 37
    ..price = 800
    ..quantity = 2
    ..description =
        'Created for the hardwood but taken to the streets, this 80s basketball icon returns with classic details and throwback hoops flair. The synthetic leather overlays help the Nike Dunk channel vintage style while its padded, low-cut collar lets you take your game anywhere—in comfort.',
  ShoesModel()
    ..id = 5
    ..imageStr = 'assets/images/i5.jpg'
    ..name = 'Nike SB Force 58'
    ..size = 37
    ..price = 500
    ..quantity = 3
    ..description =
        'The latest and greatest innovation to hit the streets, the Nike SB Force 58 gives you the durability of a cupsole with the flexibility of a vulcanised shoe. Made from canvas and suede and finished with perforations, the whole look is infused with heritage basketball DNA.',
];
