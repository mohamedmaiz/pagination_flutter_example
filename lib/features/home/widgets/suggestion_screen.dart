import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class SuggestionScreen extends StatelessWidget {
  final HomeCubit homeCubit;
  const SuggestionScreen({super.key, required this.homeCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (state.runtimeType == UsersLoaded) {
                if (index < homeCubit.users.length) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        border: const GradientBoxBorder(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 146, 58, 223),
                          Color.fromARGB(255, 90, 90, 245)
                        ])),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(2),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: homeCubit.users[index].gender ==
                                              'Female'
                                          ? Colors.pink
                                          : Colors.blue,
                                      width: 1.5)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: homeCubit.users[index].avatar ??
                                        '', // Network image URL
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            Color.fromARGB(255, 146, 58, 223),
                                      ), // Loading indicator
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                            Icons.error), // Error handling
                                    fit: BoxFit.contain, // Adjust fit as needed
                                  )),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${homeCubit.users[index].firstName ?? ''} ${homeCubit.users[index].lastName ?? ''}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "(${homeCubit.users[index].title ?? ''})",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      homeCubit.users[index].address?.country ??
                                          '',
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 94, 56, 244),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 60,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: homeCubit.users[index]
                                                        .isActive ==
                                                    true
                                                ? Colors.green
                                                : Colors.grey),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        homeCubit.users[index].isActive == true
                                            ? 'Active'
                                            : 'Inactive',
                                        style: const TextStyle(
                                            color: Colors.white60,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Icon(
                                    homeCubit.users[index].gender == 'Female'
                                        ? Icons.female
                                        : Icons.male,
                                    color: homeCubit.users[index].gender ==
                                            'Female'
                                        ? Colors.pink
                                        : Colors.blue,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: double.infinity,
                        child: const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 146, 58, 223),
                          ),
                        )),
                  );
                }
              } else if (state.runtimeType == ErrorLoadProducts) {
                return Center(
                  child: Text(
                    homeCubit.error,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 146, 58, 223),
                      ),
                    ),
                  ),
                );
              }
            },
            childCount: homeCubit.users.length + 1,
          ),
        );
      },
    );
  }
}
