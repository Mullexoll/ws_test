import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/presentation/ui/screens/preview.screen.dart';

import '../../../../bloc/app_bloc.dart';
import '../../../../domain/models/data.model.dart';

class ResultListWidget extends StatelessWidget {
  const ResultListWidget({super.key});

  _navigateToPreviewScreen(BuildContext context, CellData cellData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(cellData: cellData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBlocState = BlocProvider.of<AppBloc>(context).state;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: (appBlocState as AppLoaded).cellData.length,
            (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () => _navigateToPreviewScreen(
                    context,
                    appBlocState.cellData[index],
                  ),
                  title: Center(
                    child: Text(
                      appBlocState.cellData[index].path,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
