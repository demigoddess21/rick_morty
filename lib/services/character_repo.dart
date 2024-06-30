import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty/model/character.dart';

class CharacterRepository {
  final GraphQLClient client;

  CharacterRepository(this.client);

  Future<CharacterResponse> getCharacters(int page, String status) async {
    final QueryOptions options = QueryOptions(
      document: gql(r'''
        query($page: Int, $status: String) {
          characters(page: $page, filter: {status: $status}) {
            info {
              count
              pages
              next
              prev
            }
            results {
              id
              name
              status
              species
              image
            }
          }
        }
      '''),
      variables: <String, dynamic>{
        'page': page,
        'status': status,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return CharacterResponse.fromJson(result.data!['characters']);
  }
}
