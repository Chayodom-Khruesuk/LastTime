import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';
import 'package:intl/intl.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastTimeBloc, BlocState>(
      builder: (context, state) {
        final items = state.item.where((item) => item.action != null).toList();
        return items.isEmpty
            ? const Center(
                child: Text('Not event complete',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 42, 17),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(items[index].name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 179, 178, 178),
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 3)),
                        trailing: Text(
                          'บันทึก: ${DateFormat('dd/MM/yyyy เวลา hh:mm').format(items[index].action!)} นาที',
                          style: const TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
