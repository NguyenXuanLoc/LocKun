import 'package:equatable/equatable.dart';

class WebState extends Equatable {
  final bool isLoading;
  final int value;

  const WebState({this.value = 0, this.isLoading = true});

  WebState copyOf({bool? isLoading, int? value}) => WebState(
      isLoading: isLoading ?? this.isLoading, value: value ?? this.value);

  @override
  List<Object?> get props => [isLoading, value];
}
