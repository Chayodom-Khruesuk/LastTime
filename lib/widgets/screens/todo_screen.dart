import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';
import 'package:flutter_lasttime/widgets/screens/add_event.dart';
import 'package:flutter_lasttime/widgets/screens/list_page.dart';
import 'package:flutter_lasttime/widgets/screens/remove_btn.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search....',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 110, 128, 14),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 206, 193, 8)),
                    ),
                  ),
                  onChanged: (query) {
                    if (query.isEmpty) {
                      context.read<LastTimeBloc>().add(SearchClearEvent());
                    } else {
                      context
                          .read<LastTimeBloc>()
                          .add(SearchEventAction(query));
                    }
                  },
                ),
              ),
              listPage(),
            ],
          ),
          const Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              children: [
                AddEvent(),
                SizedBox(width: 16),
                RemoveBtn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
