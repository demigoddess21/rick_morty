import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/character_bloc.dart';
import 'package:rick_morty/bloc/character_event.dart';
import 'package:rick_morty/bloc/character_state.dart';
import 'package:rick_morty/model/character.dart';

class CharacterScreen extends StatefulWidget {
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final ScrollController _scrollController = ScrollController();
  final _statuses = ['All', 'Alive', 'Dead', 'Unknown'];
  String _selectedStatus = 'All';
  int _currentPage = 1;
  bool _isLoadingMore = false;
  List<Character> _characters = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadCharacters();
  }

  void _loadCharacters() {
    final status = _selectedStatus == 'All' ? '' : _selectedStatus;
    BlocProvider.of<CharacterBloc>(context)
        .add(FetchCharacters(page: _currentPage, status: status));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });
      _loadCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty Characters'),
        actions: [
          DropdownButton<String>(
            value: _selectedStatus,
            dropdownColor: Theme.of(context).primaryColor,
            items: _statuses.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child:
                    Text(value, style: Theme.of(context).textTheme.bodyLarge),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedStatus = newValue!;
                _currentPage = 1;
                _characters.clear();
                _isLoadingMore = false;
                _loadCharacters();
              });
            },
          ),
        ],
      ),
      body: BlocListener<CharacterBloc, CharacterState>(
        listener: (context, state) {
          if (state is CharacterLoaded) {
            setState(() {
              _characters.addAll(state.characterResponse.results);
              _isLoadingMore = false;
            });
          } else if (state is CharacterError) {
            setState(() {
              _isLoadingMore = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: _characters.length + 1,
              itemBuilder: (context, index) {
                if (index < _characters.length) {
                  final character = _characters[index];
                  return ListTile(
                    leading: Image.network(character.image),
                    title: Text(character.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text('${character.status} - ${character.species}',
                        style: Theme.of(context).textTheme.bodyMedium),
                  );
                } else {
                  return _isLoadingMore
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
