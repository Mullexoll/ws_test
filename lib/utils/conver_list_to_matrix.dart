List<List<String>> convertToMatrix(List<String> input) {
  List<List<String>> matrix = [];

  for (String row in input) {
    List<String> rowChars = row.split('');
    matrix.add(rowChars);
  }

  return matrix;
}
