import 'package:equatable/equatable.dart';

class PassState extends Equatable {
  final String pass;

  const PassState({this.pass = "4731411"});

  @override
  List<Object?> get props => [pass];
}
