import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_app/core/di/dipendency_injection.dart';
import 'package:pagination_app/features/home/screen/home_screen.dart';

import '../features/home/cubit/home_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: const HomeScreen(),
        ));
  }
}
