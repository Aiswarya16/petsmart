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
