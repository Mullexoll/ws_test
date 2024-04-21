import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/bloc/app_bloc.dart';
import 'package:webspark_test/domain/constants/app_constants.dart';
import 'package:webspark_test/presentation/ui/screens/home.screen.dart';
import 'package:webspark_test/theme/app.theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()
        ..add(
          AddUrlQueryEvent(
            urlQuery: AppConstants.websparkEndpoint,
          ),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}
