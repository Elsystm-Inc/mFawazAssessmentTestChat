import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'local.database.g.dart';

@UseMoor(tables: [])
class AppDataBase extends _$AppDataBase {
  // we tell the database where to store the data with this constructor
  AppDataBase() : super(_openConnection());

  static FlutterQueryExecutor _openConnection() {
    return FlutterQueryExecutor.inDatabaseFolder(path: "db.ralph", logStatements: true);
  }

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 4) {}
      }, beforeOpen: (details) async {
        if (details.wasCreated) {
          //If you want to add seeders to the DB
        }
      });
}
