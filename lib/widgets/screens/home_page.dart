import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';
import 'package:flutter_lasttime/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastTimeBloc, BlocState>(builder: (context, state) {
      return state is LoadingState
          ? const Center(child: CircularProgressIndicator())
          : const NavBar();
    });
  }
}
