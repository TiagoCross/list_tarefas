class Task
{
  int id;
  String title;
  String description;
  bool idDone;

  Task(
    {
      this.id,
      this.title,
      this.description,
      this.idDone = false
    });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    idDone: json["idDone"] == 1,
  );
  Map<String, dynamic> toMap() 
  {
    Map<String, dynamic> map = 
    {
      "id": id,
      "title": title,
      "description": description,
      "idDone": idDone ? 1 : 0
    };
    if (id != null)
    {
      map["id"] = id; 
    }
    return map;
  }
  
}