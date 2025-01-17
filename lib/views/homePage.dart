import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:list_tarefas/helpers/task_helper.dart';
import 'package:list_tarefas/models/task.dart';
import 'package:list_tarefas/views/task_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Task> _taskList = [];
  TaskHelper _helper = TaskHelper();
  bool _loading = true;

  @override
  void initState()
  {
    super.initState();
    _helper.getAll().then((list)
    {
      setState(() {
        _taskList = list;
        _loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de tarefas")),
      floatingActionButton: 
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addNewTask),
      body: _buildTaskList(),
    );
  }
  Widget _buildTaskList()
  {
    if (_taskList.isEmpty) 
    {
      return Center(
        child: _loading ? CircularProgressIndicator() : Text("Sem Tarefas!"),
        );
    } else {
      return ListView.separated(
        itemBuilder: _buildTaskItemSlidable,
        separatorBuilder: (BuildContext context, index){
          return Divider();
        },
        itemCount: _taskList.length,
      );
    }
  }
  Widget _buildTaskItem(BuildContext context, int index)
  {
    final task = _taskList[index];
    return Flexible(child:  
      CheckboxListTile(
        value: task.idDone, 
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
          task.description,
          overflow: TextOverflow.ellipsis),
        onChanged: (bool isChecked)
        {
          setState(() {
            task.idDone = isChecked;
          });
          _helper.update(task);
        }
      ),
    );
  }
  Widget _buildTaskItemSlidable(BuildContext context, int index)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(), 
      actionExtentRatio: 0.25, 
      child: _buildTaskItem(context, index),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Editar',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: (){
            _addNewTask(editedTask: _taskList[index], index:index);
          },
        ),
      IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: (){
            _deleteTask(deletedTask: _taskList[index], index: index);
          },
        ),
      ],
    );
  }
  void _deleteTask({Task deletedTask, int index})
  {
    setState(() 
    {
      _taskList.removeAt(index);
    });

    _helper.delete(deletedTask.id);

    Flushbar(
      title: "Exclusão de tarefas",
      message: "Tarefa \"${deletedTask.title}\" removida.",
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      duration: Duration(seconds: 3),
      mainButton: FlatButton(
        child:Text(
          "Desfazer", 
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold),
        ),
        onPressed: (){
          setState(() {
            _taskList.insert(index, deletedTask);
            _helper.update(deletedTask);
          });
        }
      ),
    )..show(context);
  }
  Future _addNewTask({Task editedTask, int index}) async
  {
    final task = await showDialog<Task>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return TaskDialog(task: editedTask);
      },
    );
    if (task != null) 
    {
      setState(() {
        if (index == null) {
          _taskList.add(task);
          _helper.save(task);
        } else {
          _taskList[index] = task;
          _helper.update(task);
        }
      });  
    }
  }
}