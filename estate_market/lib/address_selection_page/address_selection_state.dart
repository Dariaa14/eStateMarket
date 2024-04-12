part of 'address_selection_bloc.dart';

class AddressSelectionState extends Equatable {
  final LocationPermissionStatus status;

  const AddressSelectionState({this.status = LocationPermissionStatus.denied});

  AddressSelectionState copyWith({LocationPermissionStatus? status}) {
    return AddressSelectionState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
