import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ApiPage()));
}

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  List users = [];
  bool loading = true;
  String error = '';

  Future<void> fetchUsers() async {
    HttpClient? client;
    try {
      client = HttpClient();
      final request = await client.getUrl(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );
      final response = await request.close();

      if (response.statusCode == 200) {
        final body = await response.transform(utf8.decoder).join();
        setState(() {
          users = json.decode(body);
          loading = false;
          error = '';
        });
      } else {
        setState(() {
          loading = false;
          error = 'Request failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = 'Error fetching data: $e';
      });
    } finally {
      client?.close();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('REST API Data')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(user['id'].toString()),
                      ),
                      title: Text(user['name']),
                      subtitle: Text(user['email']),
                    );
                  },
                ),
    );
  }
}
