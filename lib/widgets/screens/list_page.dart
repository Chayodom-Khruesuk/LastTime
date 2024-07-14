import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_event.dart';
import 'package:flutter_lasttime/bloc/bloc_state.dart';
import 'package:intl/intl.dart';

Expanded listPage() {
  return Expanded(
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
                        color: const Color.fromARGB(255, 44, 42, 17),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlocBuilder<LastTimeBloc, BlocState>(
                          builder: (context, state) {
                        if (state is ReadyState || state is SearchState) {
                          if (item[index].action == null) {
                            return ListTile(
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.check_box,
                                  color: Colors.yellow,
                                ),
                                iconSize: 28,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'ยืนยัน',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'คุณต้องการยกเลิกงานนี้หรือไม่',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text('ยกเลิก',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<LastTimeBloc>()
                                                    .add(UpdateTime(
                                                        id: item[index].id,
                                                        cycleDateTime:
                                                            DateTime.now()));
                                                /*Navigator.of(context).pop();
                                                context
                                                    .read<LastTimeBloc>()
                                                    .add(RemoveEvent(
                                                        item[index].id));*/
                                              },
                                              child: const Text('ตกลง',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                              title: Text(
                                item[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Text(
                                'เวลาคงเหลือ ${item[index].cycleDateTime} วัน',
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
                                item[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              // DateTime
                              trailing: Text(
                                'บันทึก: ${DateFormat('yyyy-MM-dd-kk:mm').format(item[index].action!)} นาที',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              // delete icon
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
              );
      },
    ),
  );
}
