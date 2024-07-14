import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_event.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController dateTimeController = TextEditingController();

    return FloatingActionButton(
      backgroundColor: Colors.yellow,
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
