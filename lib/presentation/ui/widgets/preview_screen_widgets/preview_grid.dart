import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:webspark_test/domain/constants/app_constants.dart';

import '../../../../domain/models/data.model.dart';

class PreviewGrid extends StatelessWidget {
  final CellData cellData;

  const PreviewGrid({super.key, required this.cellData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: GridView.builder(
            itemCount: cellData.field.length * cellData.field[0].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cellData.field[0].length,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              List<List<int>> coordinates = cellData.path
                  .replaceAll("(", "")
                  .replaceAll(")", "")
                  .split("->")
                  .map((pair) => pair.split(",").map(int.parse).toList())
                  .toList();

              int row = (index / cellData.field[0].length).floor();
              int col = index % cellData.field[0].length;
              List<int> currentCoordinate = [col, row];
              String position = '($col.$row)';

              Color color = Colors.white;

              if (currentCoordinate.equals(coordinates.first)) {
                color = AppConstants.startCellColor;
              } else if (currentCoordinate.equals(coordinates.last)) {
                color = AppConstants.endCellColor;
              } else if (coordinates
                  .any((coord) => coord.equals(currentCoordinate))) {
                color = AppConstants.shortestPathColor;
              }

              return _buildGridTile(position, color, context);
            },
          ),
        ),
        Flexible(
          child: Text(
            cellData.path,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildGridTile(String position, Color color, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: Center(
        child: Text(
          position,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
