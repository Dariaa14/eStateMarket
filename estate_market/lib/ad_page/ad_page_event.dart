part of 'ad_page_bloc.dart';

abstract class AdPageEvent {}

class InitAdPageEvent extends AdPageEvent {
  final CoordinatesEntity coordinates;

  InitAdPageEvent({required this.coordinates});
}
