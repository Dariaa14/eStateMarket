part of 'address_selection_bloc.dart';

abstract class AddressSelectionEvent {}

class RequestLocationPermissionEvent extends AddressSelectionEvent {}

class FollowPositionEvent extends AddressSelectionEvent {}

class InitAddressSelectionEvent extends AddressSelectionEvent {}
