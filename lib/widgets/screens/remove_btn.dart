import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_event.dart';
import 'package:flutter_lasttime/bloc/bloc_state.dart';

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
              color: Colors.black,
              size: 32,
            ));
      },
    );
  }
}
