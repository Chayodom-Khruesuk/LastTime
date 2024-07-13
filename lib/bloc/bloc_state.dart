import 'package:flutter_lasttime/model/item_action.dart';

sealed class BlocState {
  final List<ItemAction> item;
  BlocState({required this.item});
}

const List<ItemAction> empty = [];

class LoadingState extends BlocState {
  LoadingState() : super(item: empty);
}

class SearchState extends BlocState {
  SearchState({required super.item});
}

class ReadyState extends BlocState {
  ReadyState({required super.item});
}
