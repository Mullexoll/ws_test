import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/bloc/app_bloc.dart';
import 'package:webspark_test/presentation/ui/screens/process.screen.dart';

class StartButtonWidget extends StatefulWidget {
  final AppLoaded state;

  const StartButtonWidget({super.key, required this.state});

  @override
  State<StartButtonWidget> createState() => _StartButtonWidgetState();
}

class _StartButtonWidgetState extends State<StartButtonWidget> {
  successCallback() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProcessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style,
        onPressed: () => widget.state.isFetching
            ? null
            : BlocProvider.of<AppBloc>(context).add(
                FetchDataEvent(successCallback: successCallback),
              ),
        child: widget.state.isFetching
            ? const CircularProgressIndicator()
            : Text(
                'Start counting process',
                style: Theme.of(context).textTheme.titleMedium,
              ),
      ),
    );
  }
}
