import 'package:app_practice/edit_todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeSite extends StatefulWidget {
  const HomeSite({Key? key}) : super(key: key);

  @override
  State<HomeSite> createState() => _HomeSiteState();
}

class _HomeSiteState extends State<HomeSite> {
  List _todo = <dynamic>[];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }
  fetchTodo() async{
    final toFetch = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (toFetch.statusCode == 200){
      setState(() {
        _todo = convert.jsonDecode(toFetch.body) as List<dynamic>;
      });
    }
    else{
      throw Exception("Failed to fetch data");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal,
            Color(0xFFB2EBF2)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 2,
          leading: const Icon(Icons.notes, size: 27),
          title: const Text("My ToDo", style: TextStyle(color: Colors.white, fontSize: 27)),
          backgroundColor: Colors.teal.shade800,
          shape: const Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 2,
            )
          )
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _todo.length,
            itemBuilder: (context, index){
              return Card(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                elevation: 8,
                color: Colors.blue.shade50,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: ListTile(
                  visualDensity: const VisualDensity(
                    vertical: 3,
                    horizontal: 0,
                  ),
                  title: Text(_todo[index]["title"]),
                  trailing: const Text("Edit", style: TextStyle(color: Color(0xFF004D40), fontSize: 12),),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => EditForm(todo: _todo[index])),
                    );
                  },
                ),
              );
            }
          ),
        ),
      )
    );
  }
}
