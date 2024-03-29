part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final SellerType sellerType;
  final String phoneNumber;

  const EditProfileState({this.sellerType = SellerType.none, this.phoneNumber = ''});

  EditProfileState copyWith({SellerType? sellerType, String? phoneNumber}) {
    return EditProfileState(sellerType: sellerType ?? this.sellerType, phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  @override
  List<Object?> get props => [sellerType, phoneNumber];
}
