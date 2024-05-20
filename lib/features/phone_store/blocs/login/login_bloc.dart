import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      await _onLoginRequested(event, emit);
    });
  }

  FutureOr<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final String username = event.username.toString();
      final String password = event.password.toString();

      final bool isLoggedIn = await ApiServices().loginUser(username, password);

      if (isLoggedIn == false) {
        return emit(const LoginFailure('Tài khoản sai'));
      }
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(LoginSuccess());
      });
    } on SocketException {
      print('Not connected!');
    } on TimeoutException {
      print('Request time out!');
    } catch (_) {
      return emit(const LoginFailure('Có lỗi xảy ra'));
    }
  }
}
