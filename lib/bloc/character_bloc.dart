import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/services/character_repo.dart';
import 'character_event.dart';
import 'character_state.dart';
import 'package:rick_morty/model/character.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;

  CharacterBloc(this.repository) : super(CharacterInitial()) {
    on<FetchCharacters>(_onFetchCharacters);
  }

  void _onFetchCharacters(
      FetchCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    try {
      final characters =
          await repository.getCharacters(event.page, event.status);
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }
}
