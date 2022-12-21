import 'package:app_practice/todo_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EditForm extends StatefulWidget {
  final dynamic todo;
  const EditForm({Key? key, this.todo}) : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  TextEditingController title = TextEditingController();
  var id = "";
  var uniqueKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    id = widget.todo["id"].toString();
    title.text = widget.todo["title"];
  }

  updateTODO(String title) async {
    final response = await http.put(Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      body: convert.jsonEncode(<String, String>{
        'title': title,
      }));
    if (response.statusCode == 200) {
      return TODO.fromJson(convert.jsonDecode(response.body));
    } else {
      print("Failed to update.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Edit Todo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Form(
        key: uniqueKey,
        child: Container(
          height: 200,
          width: 470,
          margin: const EdgeInsets.all(20),
          child: Card(
            elevation: 15,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFormField(
                  controller: title,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "e.g Go to barber shop",
                    labelText: "Title"
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    return (value == "") ?
                        "Required field" : null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26A69A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    )
                  ),
                  child: const Text("Submit", style: TextStyle(color: Colors.white),),
                  onPressed: () async{
                    if (uniqueKey.currentState!.validate()){
                        await updateTODO(title.text);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Todo Updated!')));
                        Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
