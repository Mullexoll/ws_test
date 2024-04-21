part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {}

class AddUrlQueryEvent extends AppEvent {
  final String urlQuery;

  AddUrlQueryEvent({required this.urlQuery});

  @override
  List<Object?> get props => [urlQuery];
}

class FetchDataEvent extends AppEvent {
  final Function successCallback;
  FetchDataEvent({required this.successCallback});

  @override
  List<Object?> get props => [successCallback];
}

class StartCalculationEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class SendResultsEvent extends AppEvent {
  final Function successCallback;

  SendResultsEvent({required this.successCallback});
  @override
  List<Object?> get props => [successCallback];
}

class ResetStateEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}
