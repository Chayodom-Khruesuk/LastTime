import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_event.dart';
import 'package:flutter_lasttime/bloc/bloc_state.dart';
import 'package:flutter_lasttime/widgets/action_check_list.dart';
import 'package:intl/intl.dart';

Expanded listPage() {
  return Expanded(
    child: BlocBuilder<LastTimeBloc, BlocState>(
      builder: (context, state) {
        final items = state.item.where((item) => item.action == null).toList();
        return items.isEmpty
            ? const Center(
                child: Text(
                  'Item not found',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 20,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 44, 42, 17),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlocBuilder<LastTimeBloc, BlocState>(
                          builder: (context, state) {
                        if (state is ReadyState || state is SearchState) {
                          if (items[index].action == null) {
                            return ListTile(
                              leading: actionCheckList(context, items, index),
                              title: Text(
                                items[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Text(
                                'เวลาคงเหลือ ${items[index].cycleDateTime} วัน',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          } else {
                            return ListTile(
                              // index name
                              title: Text(
                                items[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              // DateTime
                              trailing: Text(
                                'บันทึก: ${DateFormat('dd/MM/yyyy เวลา hh:mm').format(items[index].action!)} นาที',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              // delete icon
                              onTap: () {
                                context.read<LastTimeBloc>().add(
                                      RemoveEvent(items[index].id),
                                    );
                              },
                            );
                          }
                        } else if (state is RemoveState) {
                          return ListTile(
                              title: Text(
                                items[index].name,
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
                                    .add(RemoveEvent(items[index].id));
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
  );
}
