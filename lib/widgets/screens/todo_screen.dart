import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item = context.select((LastTimeBloc bloc) => bloc.state.item);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: item.isEmpty
                ? const SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Data Not Found',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 77, 76, 76),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: BlocBuilder<LastTimeBloc, BlocState>(
                              builder: (context, state) {
                            if (state is ReadyState) {
                              if (item[index].action == null) {
                                return ListTile(
                                  title: Text(
                                    item[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: const Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              } else {
                                return ListTile(
                                  title: Text(
                                    item[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: Text(
                                    item[index].action.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    context.read<LastTimeBloc>().add(
                                          RemoveEvent(item[index].id),
                                        );
                                  },
                                );
                              }
                            } else if (state is RemoveState) {
                              return ListTile(
                                  title: Text(
                                    item[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    context
                                        .read<LastTimeBloc>()
                                        .add(RemoveEvent(item[index].id));
                                  });
                            } else {
                              return const Material();
                            }
                          }),
                        ),
                      );
                    },
                  ),
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

class RemoveBtn extends StatelessWidget {
  const RemoveBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red, // Example color
      onPressed: () {
        context.read<LastTimeBloc>().add(
              RemoveButtonEvent(),
            );
      },
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ), // Replace with your desired icon
    );
  }
}

class AddEvent extends StatelessWidget {
  const AddEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(176, 52, 150, 231),
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.8),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                AlertDialog(
                  title: const Text('Add Event'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          hintText: 'Task Title...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          hintText: 'Task DateTime...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 40,
                      ),
                      label: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
