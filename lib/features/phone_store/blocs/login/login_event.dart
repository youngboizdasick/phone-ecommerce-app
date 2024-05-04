part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent{

  final String? username ;
  final String? password ;

  const LoginRequested({this.username, this.password});

  @override
  List<Object?> get props => [username, password];
}
