import 'package:flutter/material.dart';
import 'package:webspark_test/presentation/ui/widgets/result_screen_widgets/result_list_widget.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

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
            'Result list screen',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: const ResultListWidget(),
      ),
    );
  }
}
