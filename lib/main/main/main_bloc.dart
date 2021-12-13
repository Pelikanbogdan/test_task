import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/services/preferences_service.dart';

abstract class MainState {}

class InitialState extends MainState {}

class ShowLogin extends MainState {}

class ShowAuthorizedScreen extends MainState {}

abstract class MainEvent {}

class CheckIfLoggedIn extends MainEvent {}

class MainBloc extends Bloc<MainEvent, MainState> {
  final PreferencesService _preferencesService;
  MainBloc(this._preferencesService) : super(InitialState()) {
    on<CheckIfLoggedIn>((event, emit) async {
      final loginName = await _preferencesService.getLoginName();
      await Future.delayed(Duration(seconds: 1), () {
        if (loginName == '') {
          emit(ShowLogin());
        } else {
          emit(ShowAuthorizedScreen());
        }
      });
    });
  }
}
