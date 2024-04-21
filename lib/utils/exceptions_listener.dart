import 'package:flutter/material.dart';

import '../bloc/app_bloc.dart';

class ExceptionsListener {
  final BuildContext context;
  final AppLoaded state;

  ExceptionsListener({
    required this.context,
    required this.state,
  });

  showExceptionsSnackBar() {
    final snackBar = SnackBar(
      content: Text(state.apiException!.message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
