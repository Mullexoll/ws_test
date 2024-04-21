part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {}

class AppLoaded extends AppState {
  final String urlQuery;
  final bool isFetching;
  final List<CellData> cellData;
  final APIException? apiException;
  final List<String> calculationResult;

  AppLoaded({
    required this.urlQuery,
    required this.isFetching,
    required this.cellData,
    required this.apiException,
    required this.calculationResult,
  });

  AppLoaded copyWith({
    String? urlQuery,
    bool? isFetching,
    List<CellData>? cellData,
    APIException? apiException,
    List<String>? calculationResult,
  }) {
    return AppLoaded(
      urlQuery: urlQuery ?? this.urlQuery,
      isFetching: isFetching ?? this.isFetching,
      cellData: cellData ?? this.cellData,
      apiException: apiException,
      calculationResult: calculationResult ?? this.calculationResult,
    );
  }

  @override
  List<Object?> get props => [
        urlQuery,
        isFetching,
        cellData,
        apiException,
        calculationResult,
      ];
}
