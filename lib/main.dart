import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_apple/presentation/bloc/main/main_cubit.dart';
import 'package:weather_apple/presentation/bloc/search/search_cubit.dart';
import 'package:weather_apple/presentation/screens/home_screen.dart';
import 'package:weather_apple/presentation/screens/search_screen.dart';

import 'locate_service.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(create: (context) => getIt<MainCubit>()),
        BlocProvider<SearchCubit>(create: (context) => getIt<SearchCubit>()),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const HomeScreen(),
          '/search': (context) => const SearchScreen(),
        },
        initialRoute: '/',
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
