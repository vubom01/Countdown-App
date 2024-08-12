import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/di/app_injector.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tekflat_design/tekflat_design.dart';

abstract class IsarDB {
  static IsarDB get to => AppInjector.injector<IsarDB>();

  Isar get isar;

  Future<IsarDB> init();

  Future clearDB();

  Future<T?> getById<T>(int id);

  T? getByIdSync<T>(int id);

  Future<List<T>> getAll<T>();

  Future<T?> upsert<T>(T model);

  Future<List<T>> upsertAll<T>(List<T> models);

  Future<bool> delete<T>(Id id);

  Future<bool> deleteAll<T>(List<Id> ids);

  Stream<T> watch<T>(Id key);

  Stream<void> lazyWatch<T>();

  Future<bool> clearCollection<T>();
}

class IsarDBImpl implements IsarDB {
  late final Isar _isar;

  @override
  Isar get isar => _isar;

  @override
  Future<IsarDB> init() async {
    final dir = await getApplicationSupportDirectory();

    _isar = await Isar.open(
      [EventLocalSchema],
      directory: dir.path,
    );

    return this;
  }

  @override
  Future clearDB() => _isar.writeTxn(_isar.clear);

  @override
  Future<T?> getById<T>(int id) async {
    try {
      final recipes = _isar.collection<T>();

      final result = await recipes.get(id);

      return result;
    } catch (e) {
      TekLogger.errorLog("IsarDBImpl getById: $e");
      return null;
    }
  }

  @override
  T? getByIdSync<T>(int id) {
    final recipes = _isar.collection<T>();
    return recipes.getSync(id);
  }

  @override
  Future<List<T>> getAll<T>() async {
    try {
      final recipes = _isar.collection<T>();

      final result = await recipes.where().findAll();

      return result;
    } catch (e) {
      TekLogger.errorLog("IsarDBImpl getAll: $e");
      return [];
    }
  }

  @override
  Future<T?> upsert<T>(T model) async {
    try {
      final recipes = _isar.collection<T>();

      await _isar.writeTxn(() => recipes.put(model));
      return model;
    } catch (e) {
      TekLogger.errorLog("IsarDBImpl upsert: $e");
      return null;
    }
  }

  @override
  Future<List<T>> upsertAll<T>(List<T> models) async {
    try {
      final recipes = _isar.collection<T>();

      await _isar.writeTxn(() => Future.wait(models.map(recipes.put)));
      return models;
    } catch (e) {
      TekLogger.errorLog("IsarDBImpl upsertAll: $e");
      return [];
    }
  }

  @override
  Future<bool> delete<T>(Id id) async {
    try {
      final recipes = _isar.collection<T>();

      await _isar.writeTxn(() => recipes.delete(id));

      return true;
    } catch (e) {
      TekLogger.errorLog("IsarDBImpl delete: $e");
      return false;
    }
  }

  @override
  Future<bool> deleteAll<T>(List<Id> ids) async {
    try {
      final recipes = _isar.collection<T>();

      await _isar.writeTxn(() => recipes.deleteAll(ids));

      return true;
    } catch (e) {
      TekLogger.errorLog("IsarDBImpl deleteAll: $e");
      return false;
    }
  }

  @override
  Stream<T> watch<T>(Id key) {
    final recipes = _isar.collection<T>();

    return recipes.watchObject(key).cast<T>();
  }

  @override
  Stream<void> lazyWatch<T>() {
    final recipes = _isar.collection<T>();

    return recipes.watchLazy();
  }

  @override
  Future<bool> clearCollection<T>() async {
    try {
      final recipes = _isar.collection<T>();

      await _isar.writeTxn(() => recipes.clear());

      return true;
    } catch (e) {
      TekLogger.errorLog("IsarDBImpl clearAll: $e");
      return false;
    }
  }
}
