import 'dart:convert';

import 'package:flutter/material.dart';

import '../help/api_caller.dart';
import '../help/dialog_utils.dart';
import '../modelss/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _urlController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  List<TodoItem> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _loadTodoItems();
  }

  Future<void> _loadTodoItems() async {
    try {
      final data = await ApiCaller().get("todos");
      List list = jsonDecode(data);
      setState(() {
        _todoItems = list.map((e) => TodoItem.fromJson(e)).toList();
      });
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Webby Fondue'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
            children: [
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'URL *',
                filled: true, // เพิ่มการเติมสีพื้นหลังให้กับช่องกรอกข้อความ
                fillColor: Color.fromARGB(255, 246, 247, 248), // กำหนดสีพื้นหลังให้กับช่องกรอกข้อความ
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // ไม่มีเส้นขอบ
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none, // ไม่มีเส้นขอบ
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none, // ไม่มีเส้นขอบ
                ),
                          ),
            ),
          ),
        ],
      ),
      SizedBox(height: 16.0),
      // เพิ่ม TextField สำหรับรายละเอียด
      TextField(
        controller: _detailController,
        decoration: InputDecoration(
          hintText: 'รายละเอียด',
          filled: true, // เพิ่มการเติมสีพื้นหลังให้กับช่องกรอกข้อความ
          fillColor: Color.fromARGB(255, 247, 248, 249), // กำหนดสีพื้นหลังให้กับช่องกรอกข้อความ
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // ไม่มีเส้นขอบ
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none, // ไม่มีเส้นขอบ
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none, // ไม่มีเส้นขอบ
          ),
              ),
      ),
      SizedBox(height: 16.0),
            Text(
              'ระบุประเภทเว็ปเลว*',
              style: TextStyle(
                fontSize: 14,),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  final item = _todoItems[index];
                  return Card(
                    key: ValueKey(item.id), // Adding a key
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text('User ID: ${item.userId}'),
                      trailing: Icon(item.completed ? Icons.check : null),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _handleApiPost,
              child: const Text('ส่งข้อมูล'),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Future<void> _handleApiPost() async {
    try {
      final data = await ApiCaller().post(
        "todos",
        params: {
          "userId": 1,
          "title": "ทดสอบๆๆๆๆๆๆๆๆๆๆๆๆๆๆ",
          "completed": true,
        },
      );
      Map map = jsonDecode(data);
      String text =
          'ส่งข้อมูลสำเร็จ\n\n - id: ${map['id']} \n - userId: ${map['userId']} \n - title: ${map['title']} \n - completed: ${map['completed']}';
      showOkDialog(context: context, title: "Success", message: text);
    } on Exception catch (e) {
      showOkDialog(context: context, title: "Error", message: e.toString());
    }
  }
}
