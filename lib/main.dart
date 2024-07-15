import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lasttime/bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_event.dart';
import 'package:flutter_lasttime/repo/mock_repo.dart';
import 'package:flutter_lasttime/widgets/nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LastTimeBloc>(create: (context) {
          final bloc = LastTimeBloc(MockRepo());
          bloc.add(LoadEvent());
          return bloc;
        }),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: NavBar()),
        ),
      ),
    );
  }
}
