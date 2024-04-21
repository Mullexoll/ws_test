import 'dart:collection';

import 'package:collection/collection.dart';

import '../domain/models/cell_node.model.dart';

List<CellNode> findShortestPath({
  required List<List<String>> matrix,
  required int startX,
  required int startY,
  required int endX,
  required int endY,
  required String id,
  void Function(double progress)? onProgressUpdate,
}) {
  int numRows = matrix.length;
  int numCols = matrix[0].length;

  double calculateDistance(int x1, int y1, int x2, int y2) {
    return ((x2 - x1).abs() + (y2 - y1).abs()).toDouble();
  }

  CellNode startNode = CellNode(startX, startY, id: '');
  CellNode endNode = CellNode(endX, endY, id: '');

  PriorityQueue<CellNode> openSet = PriorityQueue(
    (a, b) => (a.fScore - b.fScore).toInt(),
  );
  HashMap<CellNode, double> gScores = HashMap();
  HashMap<CellNode, double> fScores = HashMap();

  openSet.add(startNode);
  gScores[startNode] = 0;
  fScores[startNode] = calculateDistance(startX, startY, endX, endY);

  num totalSteps = (numRows * numCols);
  double currentStep = 0;

  while (openSet.isNotEmpty) {
    CellNode current = openSet.removeFirst();

    if (current.x == endNode.x && current.y == endNode.y) {
      List<CellNode> path = [];
      CellNode? backtrackNode = current;
      while (backtrackNode != null) {
        path.add(backtrackNode);
        backtrackNode = backtrackNode.parent;
      }
      return path.reversed.toList();
    }

    for (var dx = -1; dx <= 1; dx++) {
      for (var dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        int neighborX = current.x + dx;
        int neighborY = current.y + dy;
        if (neighborX >= 0 &&
            neighborX < numRows &&
            neighborY >= 0 &&
            neighborY < numCols) {
          if (matrix[neighborX][neighborY] != 'X') {
            CellNode neighbor = CellNode(neighborX, neighborY, id: id);
            double tentativeGScore = gScores[current]! + 1;
            if (!gScores.containsKey(neighbor) ||
                tentativeGScore < gScores[neighbor]!) {
              neighbor.gScore = tentativeGScore;
              neighbor.hScore =
                  calculateDistance(neighborX, neighborY, endX, endY);
              neighbor.fScore = neighbor.gScore + neighbor.hScore;
              neighbor.parent = current;
              gScores[neighbor] = tentativeGScore;
              fScores[neighbor] = neighbor.fScore;
              openSet.add(neighbor);
            }
          }
        }
      }
    }

    // Update progress
    currentStep++;
    double progress = (currentStep / totalSteps) * 100;
    if (onProgressUpdate != null) {
      onProgressUpdate(progress);
    }
  }

  return [];
}
