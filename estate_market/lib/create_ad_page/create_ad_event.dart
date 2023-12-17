part of 'create_ad_bloc.dart';

abstract class CreateAdEvent {}

class ChangeCurrentCategoryEvent extends CreateAdEvent {
  final AdCategory? category;

  ChangeCurrentCategoryEvent({required this.category});
}
