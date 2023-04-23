part of 'manage_listings_bloc.dart';

@immutable
abstract class ManageListingsEvent {}

class AddListingsEvent extends ManageListingsEvent {
  final String title,
      description,
      age,
      gender,
      address,
      phone,
      place,
      district,
      state,
      pin;
  final int price, discountedPrice, categoryId;

  final PlatformFile image;

  AddListingsEvent({
    required this.image,
    required this.title,
    required this.description,
    required this.age,
    required this.gender,
    required this.address,
    required this.phone,
    required this.place,
    required this.district,
    required this.state,
    required this.pin,
    required this.price,
    required this.discountedPrice,
    required this.categoryId,
  });
}

class EditListingsEvent extends ManageListingsEvent {
  final String title,
      description,
      age,
      gender,
      address,
      phone,
      place,
      district,
      state,
      pin;
  final int price, discountedPrice, listingId;

  EditListingsEvent({
    required this.listingId,
    required this.title,
    required this.description,
    required this.age,
    required this.gender,
    required this.address,
    required this.phone,
    required this.place,
    required this.district,
    required this.state,
    required this.pin,
    required this.price,
    required this.discountedPrice,
  });
}

class UploadImageListingsEvent extends ManageListingsEvent {
  final int listingId;
  final PlatformFile image;

  UploadImageListingsEvent({
    required this.listingId,
    required this.image,
  });
}

class DeleteListingsEvent extends ManageListingsEvent {
  final int listingId;

  DeleteListingsEvent({required this.listingId});
}

class DeleteImageListingsEvent extends ManageListingsEvent {
  final int imageId;

  DeleteImageListingsEvent({required this.imageId});
}

class GetAllListingsEvent extends ManageListingsEvent {
  final String? query;

  GetAllListingsEvent({
    this.query,
  });
}

class GetOthersListingsEvent extends ManageListingsEvent {
  final String? query;
  final int? categoryId;
  final bool favorite;

  GetOthersListingsEvent({
    this.query,
    this.categoryId,
    this.favorite = false,
  });
}

class FavoriteListingsEvent extends ManageListingsEvent {
  final int listingId;
  final bool favorite;

  FavoriteListingsEvent({
    required this.listingId,
    required this.favorite,
  });
}

class OrderListingsEvent extends ManageListingsEvent {
  final int listingId;

  OrderListingsEvent({
    required this.listingId,
  });
}

class GetMyOrderListingsEvent extends ManageListingsEvent {
  final String status;

  GetMyOrderListingsEvent({required this.status});
}

class CollectMyOrderListingsEvent extends ManageListingsEvent {
  final int listingId;

  CollectMyOrderListingsEvent({required this.listingId});
}
