import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{}

class FetchAllUserEvent implements UserEvent{
  @override
  List<Object> get props => null;
}