sealed class BlocEvent {}

final class LoadEvent extends BlocEvent {}

final class LoadAnimationEvent extends BlocEvent {}

final class SearchEvent extends BlocEvent {
  final String key;
  SearchEvent(this.key);
}

class RemoveEvent extends BlocEvent {
  final int id;
  RemoveEvent(this.id);
}

class RemoveButtonEvent extends BlocEvent {}

class AddEventAction extends BlocEvent {
  final String name;
  final int cycleDateTime;

  AddEventAction({required this.name, required this.cycleDateTime});
}

class SearchEventAction extends BlocEvent {
  final String query;
  SearchEventAction(this.query);
}

class SearchClearEvent extends BlocEvent {}

class UpdateTime extends BlocEvent {
  final int id;
  final DateTime action;
  UpdateTime({required this.id, required this.action});
}
