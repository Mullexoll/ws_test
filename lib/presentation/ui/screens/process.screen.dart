import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:webspark_test/presentation/ui/widgets/process_screen_widgets/send_button_widget.dart';

import '../../../bloc/app_bloc.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              BlocProvider.of<AppBloc>(context).add(
                ResetStateEvent(),
              );
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Process screen',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                child: Text(
                  'All calculations has finished, you can send your result to server',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text(
                '100%',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Divider(),
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: 1.0,
                progressColor: Colors.blueAccent,
              ),
              const Spacer(),
              const SendButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
