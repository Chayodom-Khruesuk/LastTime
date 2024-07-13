import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item = context.select((LastTimeBloc bloc) => bloc.state.item);
    return Expanded(
        child: item.isEmpty
            ? const SizedBox(
                height: 200,
                width: double.infinity,
                child: Text(
                  'Not Found Data',
                  textAlign: TextAlign.center,
                ))
            : ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(item[index].name),
                  );
                },
              ));
  }
}
