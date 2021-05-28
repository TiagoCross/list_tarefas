import 'package:flutter/material.dart';
import 'package:list_tarefas/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Task _currentTask = Task();

  @override
  void initState()
  {
    super.initState();
    if(widget.task != null)
    {
      _currentTask = Task.fromMap(widget.task.toMap());
    }

    _titleController.text = _currentTask.title;
    _descriptionController.text = _currentTask.description;
  }
  @override
  void dispose()
  {
    super.dispose();
    _titleController.clear();
    _descriptionController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Nova Tarefa' : 'Editar tarefas'),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Titulo"),
              autofocus: true,
              validator: (value){
                if (value.isEmpty) {
                  return "Insira um titulo";
                }
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Descrição"),
              autofocus: true,
              validator: (value){
                if (value.isEmpty) {
                  return "Inira uma descrição";
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 60.0, bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FlatButton(
                    child: Text("Cancelar"),
                      onPressed: ()
                      {
                        Navigator.of(context).pop();
                      }
                  ),
                  FlatButton(
                    child: Text("Salvar"),
                      onPressed: ()
                      {
                        if (_formKey.currentState.validate()) {
                          _currentTask.title = _titleController.value.text;
                          _currentTask.description = _descriptionController.value.text;
                          Navigator.of(context).pop(_currentTask);
                        }
                      }
                  ),
                ],
              ), 
            ),
          ], 
        ), 
      ), 
    );
  }
}