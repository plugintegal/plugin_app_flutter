import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserEvent extends Equatable{}

class FetchAllUserEvent implements UserEvent{
  @override
  List<Object> get props => null;
}

class FetchMyProfile implements UserEvent {
  @override
  List<Object> get props => null;
}

class DoLogin implements UserEvent{
  final String member, password;

  DoLogin({@required this.member, @required this.password});
  @override
  List<Object> get props => [member, password];

}