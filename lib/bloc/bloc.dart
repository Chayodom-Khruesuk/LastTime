import 'package:bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';

class LastTimeBloc extends Bloc<BlocEvent, BlocState> {
  LastTimeBloc() : super(LoadingState());
}
