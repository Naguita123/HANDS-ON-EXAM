import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '2.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List items = [];

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('EDIT and PUT'),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              final item = items[index] as Map;
              return Card(
                child: ListTile(
                  leading: SizedBox(
                    height: 50,
                    child: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                  ),
                  title: Text(item['title']),
                  subtitle: Text(item['body']),
                  trailing: PopupMenuButton(
                      onSelected: (value) {
                        updateTodo(item);
                        if (value == 'edit') {
                        } else if (value == 'delete') {}
                      },
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                            value: 'delete', child: Text('Delete'))
                      ]),
                ),
              );
            })));
  }

  Future<void> getTodo() async {
    final url = 'https://jsonplaceholder.typicode.com/posts';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = convert.jsonDecode(response.body) as List;

    setState(() {
      items = json;
    });
  }

  Future<void> updateTodo(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => updatePage(todo: item),
    );
    await Navigator.push(context, route);
    getTodo();
  }
}