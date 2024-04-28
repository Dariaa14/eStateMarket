import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ad_page_event.dart';
part 'ad_page_state.dart';

class AdPageBloc extends Bloc<AdPageEvent, AdPageState> {
  AdPageBloc() : super(const AdPageState());
}
