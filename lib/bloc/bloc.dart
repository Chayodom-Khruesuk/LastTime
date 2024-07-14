import 'package:bloc/bloc.dart';
import 'package:flutter_lasttime/bloc/bloc_barrel.dart';
import 'package:flutter_lasttime/repo/repo.dart';

class LastTimeBloc extends Bloc<BlocEvent, BlocState> {
  final Repo repo;
  LastTimeBloc(this.repo) : super(LoadingState()) {
    on<LoadEvent>(_onLoaded);
    on<RemoveEvent>(_onRemove);
    on<RemoveButtonEvent>(_onRemoveButton);
    on<AddEvent>(_onAdd);
  }

  void _onLoaded(LoadEvent event, Emitter<BlocState> emit) async {
    final item = await repo.loadWithDelay();
    item.sort((a, b) => a.cycleDateTime.compareTo(b.cycleDateTime));
    emit(ReadyState(item: item));
  }

  void _onRemove(RemoveEvent event, Emitter<BlocState> emit) async {
    await repo.remove(id: event.id);
    emit(LoadingState());
    add(LoadEvent());
  }

  void _onRemoveButton(RemoveButtonEvent event, Emitter<BlocState> emit) async {
    final item = await repo.load();
    item.sort((a, b) => a.cycleDateTime.compareTo(b.cycleDateTime));
    if (state is ReadyState) {
      emit(RemoveState(item: item));
    } else {
      emit(ReadyState(item: item));
    }
  }

  void _onAdd(AddEvent event, Emitter<BlocState> emit) async {
    if (state is ReadyState) {
      await repo.add(name: event.name, cycleDateTime: event.cycleDateTime);
    }
  }
}
