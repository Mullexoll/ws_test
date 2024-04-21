class CellNode {
  String id;
  int x;
  int y;
  double gScore;
  double hScore;
  double fScore;
  CellNode? parent;

  CellNode(
    this.x,
    this.y, {
    this.gScore = 0,
    this.hScore = 0,
    this.fScore = 0,
    this.parent,
    required this.id,
  });
}
