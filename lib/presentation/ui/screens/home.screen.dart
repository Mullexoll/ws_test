import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/presentation/ui/widgets/home_screen_widgets/start_button.widget.dart';

import '../../../bloc/app_bloc.dart';
import '../../../utils/exceptions_listener.dart';
import '../widgets/home_screen_widgets/url_field.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Home Screen',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if ((state as AppLoaded).apiException != null) {
              ExceptionsListener(
                context: context,
                state: state,
              ).showExceptionsSnackBar();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state is AppLoaded) {
                  return Column(
                    children: [
                      const UrlFieldWidget(),
                      const Spacer(),
                      StartButtonWidget(
                        state: state,
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
