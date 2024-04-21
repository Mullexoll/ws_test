import 'package:flutter/material.dart';
import 'package:webspark_test/presentation/ui/widgets/preview_screen_widgets/preview_grid.dart';

import '../../../domain/models/data.model.dart';

class PreviewScreen extends StatelessWidget {
  final CellData cellData;

  const PreviewScreen({super.key, required this.cellData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Preview screen',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: PreviewGrid(cellData: cellData),
      ),
    );
  }
}
