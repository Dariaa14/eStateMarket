part of 'address_selection_bloc.dart';

class AddressSelectionState extends Equatable {
  final LocationPermissionStatus status;
  final LandmarkEntity? landmark;

  const AddressSelectionState({this.status = LocationPermissionStatus.denied, this.landmark});

  AddressSelectionState copyWith({LocationPermissionStatus? status, LandmarkEntity? landmark}) {
    return AddressSelectionState(
      status: status ?? this.status,
      landmark: landmark ?? this.landmark,
    );
  }

  @override
  List<Object?> get props => [status, landmark];
}
