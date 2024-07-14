import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';

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
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
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
              Expanded(
                child: BlocBuilder<LastTimeBloc, BlocState>(
                  builder: (context, state) {
                    final item = state.item;
                    return item.isEmpty
                        ? const Center(
                            child: Text(
                              'No item found',
                              style: TextStyle(color: Colors.white),
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
                                    color:
                                        const Color.fromARGB(255, 77, 76, 76),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: BlocBuilder<LastTimeBloc, BlocState>(
                                      builder: (context, state) {
                                    if (state is ReadyState ||
                                        state is SearchState) {
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
                                            context.read<LastTimeBloc>().add(
                                                RemoveEvent(item[index].id));
                                          });
                                    } else {
                                      return const Material();
                                    }
                                  }),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
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

class RemoveBtn extends StatelessWidget {
  const RemoveBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastTimeBloc, BlocState>(
      builder: (context, state) {
        return FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              context.read<LastTimeBloc>().add(RemoveButtonEvent());
            },
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ));
      },
    );
  }
}

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController dateTimeController = TextEditingController();

    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(175, 82, 169, 240),
      onPressed: () async {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Stack(
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
                          controller: titleController,
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
                          controller: dateTimeController,
                          keyboardType: TextInputType.datetime,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: titleController,
                        builder: (context, titleValue, _) {
                          return ValueListenableBuilder<TextEditingValue>(
                            valueListenable: dateTimeController,
                            builder: (context, dateTimeValue, _) {
                              if (titleValue.text.isNotEmpty &&
                                  dateTimeValue.text.isNotEmpty) {
                                return TextButton.icon(
                                  onPressed: () {
                                    String title = titleValue.text;
                                    int? dateTime =
                                        int.tryParse(dateTimeValue.text);
                                    if (dateTime != null) {
                                      context
                                          .read<LastTimeBloc>()
                                          .add(AddEventAction(
                                            name: title,
                                            dateTime: dateTime,
                                          ));
                                      context
                                          .read<LastTimeBloc>()
                                          .add(LoadEvent());
                                      titleController.clear();
                                      dateTimeController.clear();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                  label: const SizedBox.shrink(),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
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
