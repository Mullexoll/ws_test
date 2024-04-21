import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:webspark_test/domain/constants/app_constants.dart';
import 'package:webspark_test/domain/exceptions/api_exceptions.dart';
import 'package:webspark_test/domain/models/cell_node.model.dart';
import 'package:webspark_test/infrastructure/datasource/api_service.dart';

import '../domain/models/data.model.dart';
import '../utils/shortest_path_finder.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final APIService apiService = APIService();

  AppBloc()
      : super(AppLoaded(
          urlQuery: '',
          isFetching: false,
          cellData: const [],
          apiException: null,
          calculationResult: const [],
        )) {
    on<FetchDataEvent>(_onFetchDataEvent);
    on<AddUrlQueryEvent>(_onAddUrlQueryEvent);
    on<StartCalculationEvent>(_onStartCalculationEvent);
    on<SendResultsEvent>(_onSendResultsEvent);
    on<ResetStateEvent>(_onResetStateEvent);
  }

  FutureOr<void> _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      _fetchStarted(emit, state);
      final List<CellData> data = await apiService.fetchData(
        (state as AppLoaded).urlQuery,
      );

      emit((state as AppLoaded).copyWith(cellData: data, isFetching: false));
      event.successCallback();
      add(StartCalculationEvent());
    } catch (e) {
      _fetchFinished(emit, state);
    }
  }

  FutureOr<void> _onAddUrlQueryEvent(
    AddUrlQueryEvent event,
    Emitter<AppState> emit,
  ) {
    state is AppLoaded
        ? emit(
            (state as AppLoaded).copyWith(urlQuery: event.urlQuery),
          )
        : emit(
            AppLoaded(
              urlQuery: event.urlQuery,
              isFetching: false,
              cellData: List.from([]),
              apiException: null,
              calculationResult: List.from([]),
            ),
          );
  }

  FutureOr<void> _onSendResultsEvent(
    SendResultsEvent event,
    Emitter<AppState> emit,
  ) async {
    List<Map<String, dynamic>> jsonList = [];
    _fetchStarted(emit, state);

    (state as AppLoaded)
        .cellData
        .map(
          (CellData cellData) => jsonList.add(
            cellData.toJson(),
          ),
        )
        .toList();

    try {
      await apiService.postData(AppConstants.websparkEndpoint, jsonList);
      _fetchFinished(emit, state);
      event.successCallback();
    } catch (e) {
      emit((state as AppLoaded).copyWith(apiException: e as APIException));
      emit(
        (state as AppLoaded).copyWith(
          apiException: null,
          isFetching: false,
        ),
      );
      //TODO: internal server must be fixed
      event.successCallback();
    }
  }

  FutureOr<void> _onStartCalculationEvent(
    StartCalculationEvent event,
    Emitter<AppState> emit,
  ) {
    final List<CellData> cellData = (state as AppLoaded).cellData;
    final List<CellData> cellDataWithPath = [];

    cellData.map((CellData e) {
      List<CellNode> cellNode = findShortestPath(
        matrix: e.field,
        startX: e.start.x,
        startY: e.start.y,
        endX: e.end.x,
        endY: e.end.y,
        id: e.id,
        onProgressUpdate: (progress) {
          log('Progress: ${progress.toStringAsFixed(2)}%');
        },
      );

      cellDataWithPath.add(
        CellData(
          id: e.id,
          field: e.field,
          start: e.start,
          end: e.end,
          path: convertListToString(
            cellNode.map((node) => [node.x, node.y]).toList(),
          ),
        ),
      );
    }).toList();

    emit((state as AppLoaded).copyWith(cellData: cellDataWithPath));
  }

  String convertListToString(List<List<int>> listOfLists) {
    List<String> formattedStrings =
        listOfLists.map((list) => "(${list[0]},${list[1]})").toList();

    String result = formattedStrings.join("->");

    return result;
  }

  void _fetchStarted(Emitter<AppState> emit, state) {
    emit((state as AppLoaded).copyWith(isFetching: true));
  }

  void _fetchFinished(Emitter<AppState> emit, state) {
    emit((state as AppLoaded).copyWith(isFetching: false));
  }

  FutureOr<void> _onResetStateEvent(
    ResetStateEvent event,
    Emitter<AppState> emit,
  ) {
    emit(
      AppLoaded(
        urlQuery: AppConstants.websparkEndpoint,
        isFetching: false,
        cellData: List.from([]),
        apiException: null,
        calculationResult: List.from([]),
      ),
    );
  }
}
