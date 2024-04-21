import 'package:webspark_test/utils/convert_list_to_matrix.dart';

class CellData {
  final String id;
  final List<List<String>> field;
  final Position start;
  final Position end;
  final String path;

  CellData({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
    required this.path,
  });

  factory CellData.fromJson(Map<String, dynamic> json) {
    List<dynamic> fieldData = json['field'];
    List<String> fieldList = fieldData.map((item) => item.toString()).toList();

    return CellData(
      id: json['id'] as String,
      field: convertToMatrix(fieldList),
      start: Position.fromJson(json['start']),
      end: Position.fromJson(json['end']),
      path: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': [
          start.toJson(),
          end.toJson(),
        ],
        'path': path,
      }
    };
  }
}

class Position {
  final int x;
  final int y;

  Position({
    required this.x,
    required this.y,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x.toString(),
      'y': y.toString(),
    };
  }
}
