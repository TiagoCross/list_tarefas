import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tarefas/views/homePage.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    )
  );
}

// void main() {
//   runApp(MaterialApp(
//     home: Home(),
//   ));
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
  

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   //final _toDoCrotroller = TextEditingController();

//   List _toDoList = [];

//   Map<String, dynamic> _lastRemoved;
//   int _lastRemovedPos;

//   @override
//   void initState() {
//     super.initState();
//     _readData().then((data) {
//       setState(() {
//         _toDoList = json.decode(data);
//       });
//     });
//   }

//   // void _addToDo() {
//   //   setState(() {
//   //     Map<String, dynamic> newToDo = Map();
//   //     newToDo["title"] = _toDoCrotroller.text;
//   //     _toDoCrotroller.text = "";
//   //     newToDo["ok"] = false;
//   //     _toDoList.add(newToDo);
//   //     _saveData();
//   //   });
//   // }

//   Future<Null> _refresh() async {
//     await Future.delayed(Duration(seconds: 1));
//     setState(() {
//       _toDoList.sort((a, b) {
//         if (a["ok"] && !b["ok"])
//           return 1;
//         else if (!a["ok"] && b["ok"])
//           return -1;
//         else
//           return 0;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Lista de tarefas"),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//               padding: EdgeInsets.fromLTRB(17.0, 2.0, 7.0, 1.0),
//               child: Form(
//                 key: _formKey,
//                 child: Row(
//                   children: <Widget>[
//                     // Expanded(
//                     //   child: TextFormField(
//                     //       controller: _toDoCrotroller,
//                     //       decoration: InputDecoration(
//                     //           labelText: "Nova tarefa",
//                     //           labelStyle: TextStyle(color: Colors.blue),
//                     //           hintText: "Criar uma tarefa..."),
//                     //       validator: (value) {
//                     //         if (value.isEmpty) return "Insira uma tarefa!!";
//                     //       }),
//                     // ),
//                     IconButton(
//                         icon: Icon(
//                           Icons.add,
//                           color: Colors.blue,
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       Conteudo()));
//                           // if(_formKey.currentState.validate()) _addToDo;
//                         })
//                   ],
//                 ),
//               )),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: _refresh,
//               child: ListView.builder(
//                   padding: EdgeInsets.only(top: 10.0),
//                   itemCount: _toDoList.length,
//                   itemBuilder: buildItem),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildItem(BuildContext context, int index) {
//     return Dismissible(
//       key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
//       background: Container(
//         color: Colors.red,
//         child: Align(
//           alignment: Alignment(-0.9, 0.0),
//           child: Icon(
//             Icons.delete,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       direction: DismissDirection.startToEnd,
//       child: CheckboxListTile(
//           title: Text(_toDoList[index]["title"]),
//           value: _toDoList[index]["ok"],
//           secondary: CircleAvatar(
//             child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
//           ),
//           onChanged: (c) {
//             setState(() {
//               _toDoList[index]["ok"] = c;
//               _saveData();
//             });
//           }),
//       onDismissed: (direction) {
//         setState(() {
//           _lastRemoved = Map.from(_toDoList[index]);
//           _lastRemovedPos = index;
//           _toDoList.removeAt(index);

//           _saveData();

//           final snack = SnackBar(
//             content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
//             action: SnackBarAction(
//               label: "Desfazer",
//               onPressed: () {
//                 setState(() {
//                   _toDoList.insert(_lastRemovedPos, _lastRemoved);
//                   _saveData();
//                 });
//               },
//             ),
//             duration: Duration(seconds: 3),
//           );

//           Scaffold.of(context).removeCurrentSnackBar();
//           Scaffold.of(context).showSnackBar(snack);
//         });
//       },
//     );
//   }

//   Future<File> _getFile() async {
//     final directory = await getApplicationDocumentsDirectory();
//     return File("${directory.path}/data.json");
//   }

//   Future<File> _saveData() async {
//     String data = json.encode(_toDoList);
//     final file = await _getFile();
//     return file.writeAsString(data);
//   }

//   Future<String> _readData() async {
//     try {
//       final file = await _getFile();

//       return file.readAsString();
//     } catch (e) {
//       return null;
//     }
//   }
// }

// class Conteudo extends StatefulWidget {
//   @override
//   _ConteudoState createState() => _ConteudoState();
// }

// class _ConteudoState extends State<Conteudo> {

//   TextEditingController titleController = TextEditingController();
//   TextEditingController contentController = TextEditingController();

//   GlobalKey<FormState> _formKeyTwo = GlobalKey<FormState>();

//   final _toDoCrotroller = TextEditingController();

//   get _toDoList => null;

//   get _addToDo => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Preencher os dados"),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30.0),
//           child: Form(
//               key: _formKeyTwo,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                     TextFormField(
//                         keyboardType: TextInputType.text,
//                         //controller: _toDoCrotroller,
//                         decoration: InputDecoration(
//                             labelText: "Titulo",
//                             labelStyle: TextStyle(color: Colors.blue),
//                             hintText: "Insira um titulo"
//                         ),
//                         controller: titleController,
//                         validator: (value) {
//                           if (value.isEmpty) return "Insira um titulo!!";
//                         }),
//                     TextFormField(
//                       keyboardType: TextInputType.text,
//                         // controller: _toDoCrotroller,
//                         decoration: InputDecoration(
//                             labelText: "Descrição",
//                             labelStyle: TextStyle(color: Colors.blue),
//                             hintText: "Insira uma descrição"
//                         ),
//                         controller: contentController,
//                         validator: (value) {
//                           if (value.isEmpty) return "Insira uma descrição";
//                         }),
//                   IconButton(
//                       icon: Icon(
//                         Icons.add,
//                         color: Colors.blue,
//                       ),
//                       onPressed: () {
//                         if (_formKeyTwo.currentState.validate()) {
//                           _addToDo;
//                           Navigator.pop(context, 
//                             MaterialPageRoute(
//                               builder: (context) => Home()));
//                         }
//                       })
//                 ],
//               )
//           )
//       ),
//     );
//   }
// }
