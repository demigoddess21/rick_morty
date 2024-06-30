import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty/bloc/character_bloc.dart';
import 'package:rick_morty/bloc/character_event.dart';
import 'package:rick_morty/bloc/character_state.dart';
import 'package:rick_morty/model/character.dart';
import 'package:rick_morty/services/character_repo.dart';

import '../mocks/mock_character_repository.dart';

void main() {
  group('CharacterBloc', () {
    late CharacterRepository characterRepository;
    late CharacterBloc characterBloc;

    setUp(() {
      characterRepository = MockCharacterRepository();
      characterBloc = CharacterBloc(characterRepository);
    });

    tearDown(() {
      characterBloc.close();
    });

    final character = Character(
      id: '1',
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    );

    final characterResponse = CharacterResponse(
      info: CharacterInfo(count: 1, pages: 1, next: null, prev: null),
      results: [character],
    );

    blocTest<CharacterBloc, CharacterState>(
      'emits [CharacterLoading, CharacterLoaded] when FetchCharacters is added and characters are fetched successfully',
      build: () {
        when(characterRepository.getCharacters(1, ''))
            .thenAnswer((_) async => characterResponse);
        return characterBloc;
      },
      act: (bloc) => bloc.add(FetchCharacters(page: 1, status: '')),
      expect: () => [
        CharacterLoading(),
        CharacterLoaded(characterResponse),
      ],
    );

    blocTest<CharacterBloc, CharacterState>(
      'emits [CharacterLoading, CharacterError] when FetchCharacters is added and there is an error',
      build: () {
        when(characterRepository.getCharacters(1, ''))
            .thenThrow(Exception('Failed to fetch characters'));
        return characterBloc;
      },
      act: (bloc) => bloc.add(FetchCharacters(page: 1, status: '')),
      expect: () => [
        CharacterLoading(),
        CharacterError('Exception: Failed to fetch characters'),
      ],
    );
  });
}
