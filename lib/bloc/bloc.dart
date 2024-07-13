import 'package:bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';
import 'package:flutter_lasttime/repo/repo.dart';

class LastTimeBloc extends Bloc<BlocEvent, BlocState> {
  final Repo repo;
  LastTimeBloc(this.repo) : super(LoadingState()) {
    on<LoadEvent>(_onLoaded);
  }

  void _onLoaded(LoadEvent event, Emitter<BlocState> emit) async {
    final item = await repo.load();
    emit(ReadyState(item: item));
  }
}
