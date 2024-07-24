class DealModel {
  final String restaurantName;
  final String category;
  final int distance;
  final String deal;
  final String avatar;
  final String poster;
  final List<DiscountModel> discount;
  final String tag;
  final String address;
  final String restaurantType;
  final String discription;
  final String expireTime;
  final String instagramName;
  final String phoneNumber;
  final double lat;
  final double lon;
  final String instagramUrl;

  DealModel(
      {this.address = '',
      this.instagramUrl = 'https://www.instagram.com/forwheel_app/',
      this.lat = 21.037099068692086,
      this.lon = 105.83465395585776,
      this.instagramName = 'anatolia_restaurant_lounge',
      this.phoneNumber = '823 329 321',
      this.expireTime = 'Zniżki do wykorzystania co 2 tygodnie',
      this.tag = '@anatolia_restaurant_lounge',
      this.discription =
          'Upmarket gathering place featuring creative cocktails & classic Turkish fare, plus a hookah lounge. The bio is too short but I think 3 lines of text are fine as here.',
      this.restaurantType = 'Kawa',
      required this.restaurantName,
      required this.discount,
      required this.category,
      required this.distance,
      required this.deal,
      required this.avatar,
      required this.poster});
}

class DiscountModel {
  final String type;
  final String discount;
  final String expireTime;
  final bool isValid;

  DiscountModel(
      {required this.type,
      required this.discount,
      required this.expireTime,
      this.isValid = true});
}
