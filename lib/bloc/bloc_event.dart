sealed class BlocEvent {}

final class LoadEvent extends BlocEvent {}

final class MarkEvent extends BlocEvent {
  final int id;
  final DateTime markdatetime;
  MarkEvent(this.id, this.markdatetime);
}

final class SearchEvent extends BlocEvent {
  final String key;
  SearchEvent(this.key);
}

final class SearchClearEvent extends BlocEvent {}
