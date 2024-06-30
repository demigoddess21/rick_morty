import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/bloc/character_bloc.dart';
import 'package:rick_morty/screens/character_list_screen.dart';
import 'package:rick_morty/screens/splash_screen.dart';
import 'package:rick_morty/services/character_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink('https://rickandmortyapi.com/graphql');

  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final GraphQLClient client;

  MyApp({required this.client});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => CharacterRepository(client),
        child: BlocProvider(
            create: (context) => CharacterBloc(
                RepositoryProvider.of<CharacterRepository>(context)),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Color(0xFF3C3E44),
                scaffoldBackgroundColor: Color(0xFF272B33),
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: Color(0xFF97CE4C),
                ),
                textTheme: TextTheme(
                  bodyLarge: TextStyle(color: Color(0xFF97CE4C)),
                  bodyMedium: TextStyle(color: Color(0xFF97CE4C)),
                  headlineSmall: TextStyle(color: Color(0xFF97CE4C)),
                ),
                appBarTheme: AppBarTheme(
                  color: Color(0xFF3C3E44),
                  titleTextStyle: TextStyle(
                      color: Color(0xFF97CE4C),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                dropdownMenuTheme: DropdownMenuThemeData(
                  textStyle: TextStyle(color: Color(0xFF97CE4C)),
                  menuStyle: MenuStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF3C3E44)),
                  ),
                ),
              ),
              home: RepositoryProvider(
                create: (_) => CharacterRepository(client),
                child: BlocProvider(
                  create: (context) => CharacterBloc(
                      RepositoryProvider.of<CharacterRepository>(context)),
                  child: SplashScreen(),
                ),
              ),
            )));
  }
}
