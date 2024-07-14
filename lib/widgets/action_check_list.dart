import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_event.dart';
import 'package:flutter_lasttime/model/item_action.dart';

IconButton actionCheckList(
    BuildContext context, List<ItemAction> item, int index) {
  return IconButton(
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
                style: TextStyle(fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    context.read<LastTimeBloc>().add(
                        UpdateTime(id: item[index].id, action: DateTime.now()));
                    Navigator.of(context).pop();
                  },
                  child: const Text('ตกลง',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ],
            );
          });
    },
  );
}
