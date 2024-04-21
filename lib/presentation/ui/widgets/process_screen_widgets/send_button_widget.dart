import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/bloc/app_bloc.dart';
import 'package:webspark_test/presentation/ui/screens/result_list.screen.dart';

class SendButtonWidget extends StatefulWidget {
  const SendButtonWidget({super.key});

  @override
  State<SendButtonWidget> createState() => _SendButtonWidgetState();
}

class _SendButtonWidgetState extends State<SendButtonWidget> {
  successCallback() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResultListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLoaded state =
        (BlocProvider.of<AppBloc>(context).state as AppLoaded);

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () => (state).isFetching
                ? null
                : BlocProvider.of<AppBloc>(context).add(
                    SendResultsEvent(successCallback: successCallback),
                  ),
            child: (state as AppLoaded).isFetching
                ? const CircularProgressIndicator()
                : Text(
                    'Send results to server',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
          ),
        );
      },
    );
  }
}
