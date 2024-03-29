part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class InitProfileEvent extends EditProfileEvent {}

class ChangeSellerTypeEvent extends EditProfileEvent {
  final SellerType sellerType;

  ChangeSellerTypeEvent({required this.sellerType});
}

class ChangePhoneNumberEvent extends EditProfileEvent {
  final String phoneNumber;

  ChangePhoneNumberEvent({required this.phoneNumber});
}

class SaveChangesEvent extends EditProfileEvent {}
