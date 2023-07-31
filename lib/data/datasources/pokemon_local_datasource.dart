// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:path/path.dart';
import 'package:pokedex/data/models/pokemon_team_model.dart';
import 'package:pokedex/domain/entities/pokemon_team.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class PokemonLocalDatasource {
  Future<int> insertPokemon(String pokemonName);
  Future<int> insertUser({
    required String username,
    required String password,
  });
  Future<void> removeSessionId();
  Future<void> setSessionId(int userId);
  int getSessionId();
  Future<int> login({
    required String username,
    required String password,
  });
  Future<int> insertTeam({
    required String teamName,
    required int userId,
  });
  Future<void> insertTeams_Pokemon({
    required int teamId,
    required int pokemonId,
  });
  Future<int> getPokemonId(String pokemonName);
  Future<List<Map<String, dynamic>>> getTeams(int userId);
  Future<List<int>> getPokemonIdsInTeams(int teamId);
  Future<String> getPokemonName(int pokemonId);
}

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  static const _databaseName = 'pokemondb';
  static const _databaseVersion = 1;
  static const _columnId = 'id';
  static const _usersTable = 'users';
  static const _nameColumn = 'name';
  static const _userIdColumn = 'userId';
  static const _teamsTable = 'teams';
  static const _pokemonTable = 'pokemon';
  static const _teamIdColumn = 'teamId';
  static const _pokemonIdColumn = 'pokemonId';
  static const _usernameColumn = "username";
  static const _passwordColumn = "password";
  static const _teams_pokemonsTable = '${_teamsTable}_$_pokemonTable';
  static const _sessionIdKey = 'userId';

  PokemonLocalDatasourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  @override
  Future<int> insertTeam({
    required String teamName,
    required int userId,
  }) async {
    final db = await database;
    return await db.insert(
      _teamsTable,
      {
        _nameColumn: teamName,
        _userIdColumn: userId,
      },
    );
  }

  @override
  Future<void> insertTeams_Pokemon({
    required int teamId,
    required int pokemonId,
  }) async {
    final db = await database;

    await db.insert(
      _teams_pokemonsTable,
      {
        _teamIdColumn: teamId,
        _pokemonIdColumn: pokemonId,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getTeams(int userId) async {
    final db = await database;
    final result = await db.query(
      _teamsTable,
      where: '$_userIdColumn = ?',
      whereArgs: [userId],
    );
    return result;
  }

  @override
  Future<List<int>> getPokemonIdsInTeams(int teamId) async {
    final db = await database;
    final result = await db.query(
      _teams_pokemonsTable,
      where: '$_teamIdColumn = ?',
      whereArgs: [teamId],
    );
    return result.map((e) => e[_pokemonIdColumn] as int).toList();
  }

  @override
  Future<String> getPokemonName(int pokemonId) async {
    final db = await database;
    final result = await db.query(
      _pokemonTable,
      where: '$_columnId = ?',
      whereArgs: [pokemonId],
    );
    return result.first[_nameColumn] as String;
  }

  @override
  Future<int> getPokemonId(String pokemonName) async {
    final db = await database;
    final result = await db.query(
      _pokemonTable,
      where: '$_nameColumn = ?',
      whereArgs: [pokemonName],
    );
    return result.first[_columnId] as int;
  }

  @override
  Future<int> insertPokemon(String pokemonName) async {
    final db = await database;
    return await db.insert(
      _pokemonTable,
      {
        _nameColumn: pokemonName,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<int> insertUser({
    required String username,
    required String password,
  }) async {
    final db = await database;
    return await db.insert(
      _usersTable,
      {
        'username': username,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<int> login({
    required String username,
    required String password,
  }) async {
    final db = await database;
    final result = await db.query(
      _usersTable,
      where: '''
          $_usernameColumn = ? 
          AND $_passwordColumn = ?
        ''',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first[_columnId] as int : result.length;
  }

  @override
  Future<void> removeSessionId() async {
    await sharedPreferences.remove(_sessionIdKey);
  }

  @override
  Future<void> setSessionId(int userId) async {
    await sharedPreferences.setInt(_sessionIdKey, userId);
  }

  @override
  int getSessionId() {
    return sharedPreferences.getInt(_sessionIdKey) ?? 0;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE $_pokemonTable(
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $_nameColumn TEXT NOT NULL UNIQUE
          )
        ''');
        db.execute('''
          CREATE TABLE $_usersTable(
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $_usernameColumn TEXT NOT NULL UNIQUE,
            $_passwordColumn TEXT NOT NULL
          )
        ''');
        db.execute('''
          CREATE TABLE $_teamsTable(
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $_nameColumn TEXT NOT NULL,
            $_userIdColumn INTEGER NOT NULL,
            FOREIGN KEY ($_userIdColumn) 
              REFERENCES $_usersTable ($_columnId)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )
        ''');
        db.execute('''
          CREATE TABLE $_teams_pokemonsTable(
            $_teamIdColumn INTEGER NOT NULL,
            $_pokemonIdColumn INTEGER NOT NULL,
            FOREIGN KEY ($_teamIdColumn) 
              REFERENCES $_teamsTable ($_columnId)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
            FOREIGN KEY ($_pokemonIdColumn) 
              REFERENCES $_pokemonTable ($_columnId)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )
        ''');
      },
      version: _databaseVersion,
    );
  }
}
