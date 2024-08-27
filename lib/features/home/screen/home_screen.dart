import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_app/features/home/cubit/home_cubit.dart';
import 'package:pagination_app/features/home/widgets/app_bar.dart';
import 'package:pagination_app/features/home/widgets/bottom_navigation_bar.dart';
import 'package:pagination_app/features/home/widgets/suggestion_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit homeCubit;
  final ScrollController _scrollController = ScrollController();

  _loadMoreData() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !homeCubit.stopRequests) {
      homeCubit.stopRequests = true;
      homeCubit.getUsers();
    }
  }

  @override
  void initState() {
    homeCubit = context.read<HomeCubit>();
    homeCubit.getUsers();
    _scrollController.addListener(_loadMoreData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 27, 82),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: getSuggestionScreen(
                  controller: _scrollController, homeCubit: homeCubit)),
          const Positioned(
              bottom: 0, left: 0, right: 0, child: CustomBottomNavigationBar()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

Widget getSuggestionScreen(
    {required ScrollController? controller, required HomeCubit homeCubit}) {
  return CustomScrollView(
    controller: controller,
    slivers: [const CustomAppBar(), SuggestionScreen(homeCubit: homeCubit)],
  );
}
