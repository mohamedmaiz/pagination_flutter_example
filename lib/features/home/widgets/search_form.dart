import 'package:flutter/material.dart';

class SearchInputForm extends StatelessWidget {
  const SearchInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(
            fontSize: 11,
            color: Color.fromARGB(255, 94, 56, 244),
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromARGB(255, 94, 56, 244),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 146, 58, 223)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 146, 58, 223)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 146, 58, 223)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
    );
  }
}
