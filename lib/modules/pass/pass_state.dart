import 'package:equatable/equatable.dart';

class PassState extends Equatable {
  final String pass;

  const PassState({this.pass = "4731411111"});

  @override
  List<Object?> get props => [pass];
}
