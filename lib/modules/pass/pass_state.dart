import 'package:equatable/equatable.dart';

class PassState extends Equatable {
  final String pass;
  final String input;

  const PassState({this.pass = "473141998", this.input = ''});

  PassState copyOf({String? pass, String? input}) =>
      PassState(input: input ?? this.input, pass: pass ?? this.pass);

  @override
  List<Object?> get props => [pass, input];
}
