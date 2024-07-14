sealed class BlocEvent {}

final class LoadEvent extends BlocEvent {}

final class SearchEvent extends BlocEvent {
  final String key;
  SearchEvent(this.key);
}

class RemoveEvent extends BlocEvent {
  final int id;
  RemoveEvent(this.id);
  List<Object?> get props => [id];
}

class RemoveButtonEvent extends BlocEvent {}

class AddEventAction extends BlocEvent {
  final String name;
  final int dateTime;

  AddEventAction({required this.name, required this.dateTime});
}

class SearchEventAction extends BlocEvent {
  final String query;
  SearchEventAction(this.query);

  Pattern? get pattern => null;
}

class SearchClearEvent extends BlocEvent {}
