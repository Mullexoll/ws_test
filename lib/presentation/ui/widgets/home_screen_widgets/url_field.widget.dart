import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/bloc/app_bloc.dart';

class UrlFieldWidget extends StatefulWidget {
  const UrlFieldWidget({super.key});

  @override
  State<UrlFieldWidget> createState() => _UrlFieldWidgetState();
}

class _UrlFieldWidgetState extends State<UrlFieldWidget> {
  final TextEditingController _textController =
      TextEditingController(text: 'https://flutter.webspark.dev/flutter/api');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set valid API base URL in order to continue',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: [
            const Icon(
              Icons.compare_arrows,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                onChanged: (String value) =>
                    BlocProvider.of<AppBloc>(context).add(
                  AddUrlQueryEvent(
                    urlQuery: _textController.text,
                  ),
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
