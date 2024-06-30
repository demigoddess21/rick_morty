import 'package:equatable/equatable.dart';
import 'package:rick_morty/model/character.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final CharacterResponse characterResponse;

  const CharacterLoaded(this.characterResponse);

  @override
  List<Object?> get props => [characterResponse];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object?> get props => [message];
}
