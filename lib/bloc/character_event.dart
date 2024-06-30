import 'package:equatable/equatable.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object?> get props => [];
}

class FetchCharacters extends CharacterEvent {
  final int page;
  final String status;

  const FetchCharacters({this.page = 1, this.status = ''});

  @override
  List<Object?> get props => [page, status];
}
