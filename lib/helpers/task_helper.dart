import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:list_tarefas/models/task.dart';

class TaskHelper
{
  static final TaskHelper _instance = TaskHelper.internal();

  factory TaskHelper() => _instance;

  TaskHelper.internal();

  Database _bd;
  
  Future<Database> get bd async
  {
    if(_bd != null)
    {
      return _bd;
    }
    else
    { 
      _bd = await initBd();
      return _bd;
    }
  }
  Future<Database> initBd() async 
  {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "list_tarefas.bd");
    
        return openDatabase(path, version: 1,
          onCreate: (Database bd, int newerVersion) async 
          {
            await bd.execute("CREATE TABLE task("
              "id INTEGER PRIMARY KEY, "
              "title TEXT, "
              "description TEXT, "
              "idDone INTEGER)");
          }
        );
  }
  Future<Task> save(Task task) async
  {
    Database database = await bd;
    task.id = await database.insert('task', task.toMap());
    return task;
  }
  Future<Task> getById(int id) async
  {
    Database database = await bd;

    List<Map> maps = await database.query('task',
    columns: ['id', 'title', 'description', 'isDone'],
    where: 'id =?',
    whereArgs: [id]);

    if(maps.length > 0)
    {
      return Task.fromMap(maps.first);
    }  
    else
    {
      return null;
    } 
  }
  Future<List<Task>> getAll() async
  {
    Database database = await bd;
    List listMap = await database.rawQuery("SELECT * FROM task");
    List<Task> stuffList = listMap.map((x) => Task.fromMap(x)).toList();
    return stuffList;
  }
  Future<int> update(Task task) async
  {
    Database database = await bd;
    return await database.update('task', 
      task.toMap(), 
      where: 'id = ?',
      whereArgs: [task.id]);
  }
  Future<int> delete(int id) async
  {
    Database database = await bd;
    return await database.delete('task', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> deleteAll() async
  {
    Database database = await bd;
    return await database.rawDelete("DELETE * from task");
  }
}