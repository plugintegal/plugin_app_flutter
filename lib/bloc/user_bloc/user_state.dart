import 'package:equatable/equatable.dart';
import 'package:plugin_app_flutter/models/user.dart';
import 'package:meta/meta.dart';
abstract class UserState extends Equatable{}

class UserInitState extends UserState{
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState{
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState{
  final List<User> users;
  UserLoadedState({@required this.users});
  @override
  List<Object> get props => [users];
}

class UserSingleLoadedState extends UserState {
  final User user;
  UserSingleLoadedState({@required this.user});
  @override
  List<Object> get props => [user];
}

class UserErrorState extends UserState{
  final String err;
  UserErrorState({@required this.err});
  @override
  List<Object> get props => [err];  
}
