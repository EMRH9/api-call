import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:profile/widget/profile_display.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<dynamic> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Call"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final profileImage = user['picture']['thumbnail'];
          final firstName = user['name']['first'];
          final lastName = user['name']['last'];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDisplay(
                    item: user,
                    users: users,
                  ),
                ),
              );
            },
            child: ListTile(
              leading: ClipRRect(
                child: Image.network(profileImage),
                borderRadius: BorderRadius.circular(100),
              ),
              title: Text("$firstName $lastName"),
            ),
          );
        },
      ),
    );
  }

  void fetchData() async {
    final url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("Data Fetched");
  }
}
