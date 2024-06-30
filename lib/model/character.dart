import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String id;
  final String name;
  final String status;
  final String species;
  final String image;

  Character(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
    );
  }

  @override
  List<Object?> get props => [id, name, status, species, image];
}

class CharacterInfo extends Equatable {
  final int count;
  final int pages;
  final int? next;
  final int? prev;

  CharacterInfo(
      {required this.count, required this.pages, this.next, this.prev});

  factory CharacterInfo.fromJson(Map<String, dynamic> json) {
    return CharacterInfo(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }

  @override
  List<Object?> get props => [count, pages, next, prev];
}

class CharacterResponse extends Equatable {
  final CharacterInfo info;
  final List<Character> results;

  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      info: CharacterInfo.fromJson(json['info']),
      results: List<Character>.from(
          json['results'].map((x) => Character.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [info, results];
}
