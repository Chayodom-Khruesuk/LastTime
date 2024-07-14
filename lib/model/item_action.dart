import 'package:equatable/equatable.dart';

class ItemAction extends Equatable {
  final int id;
  final String name;
  final int cycleDateTime;
  final DateTime? action;

  const ItemAction(this.id, this.name, this.cycleDateTime, this.action);

  ItemAction copyWith({DateTime? action}) {
    return ItemAction(id, name, cycleDateTime, action ?? this.action);
  }

  @override
  List<Object?> get props => [id, action, action];
}
