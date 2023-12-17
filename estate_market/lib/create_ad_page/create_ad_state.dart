part of 'create_ad_bloc.dart';

class CreateAdState extends Equatable {
  final AdCategory currentCategory;
  const CreateAdState({this.currentCategory = AdCategory.apartament});

  CreateAdState copyWith({AdCategory? currentCategory}) =>
      CreateAdState(currentCategory: currentCategory ?? this.currentCategory);

  @override
  List<Object> get props => [currentCategory];
}
