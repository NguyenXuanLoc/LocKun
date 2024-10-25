import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<String> lContent;
  final bool isRefreshUi;

  const HomeState({this.lContent = const [], this.isRefreshUi = false});

  HomeState copyOf({List<String>? lContent, bool? isRefreshUi}) => HomeState(
      lContent: lContent ?? this.lContent,
      isRefreshUi: isRefreshUi ?? this.isRefreshUi);

  @override
  List<Object?> get props => [lContent, isRefreshUi];
}
