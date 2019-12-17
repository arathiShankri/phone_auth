import 'package:equatable/equatable.dart';

abstract class AbstractEvent extends Equatable {
  AbstractEvent();
  List<Object> get props => [];
  dynamic name();
}
