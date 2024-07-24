class OpenRestaurantByProviderIdEvent {
  final int providerId;
  final int rootPage;

  OpenRestaurantByProviderIdEvent(
      {required this.providerId, required this.rootPage});
}
