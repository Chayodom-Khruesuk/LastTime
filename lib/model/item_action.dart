import 'package:equatable/equatable.dart';

class ItemAction extends Equatable {
  final int id;
  final String name;
  final int cycleDateTime;
  final DateTime? action;

  const ItemAction(this.id, this.name, this.cycleDateTime, this.action);

  @override
  List<Object?> get props => [id, action];
}
