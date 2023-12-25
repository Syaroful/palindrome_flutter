import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> _users = [];
  int _page = 1;
  int _perPage = 10;
  bool _isLoading = false;
  bool _isEmpty = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$_page&per_page=$_perPage'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> usersData = data['data'];

      if (usersData.isNotEmpty) {
        final List<User> users = usersData
            .map(
              (userData) => User.fromJson(userData),
            )
            .toList();

        setState(
          () {
            _users.addAll(users);
            _page++;
            _isLoading = false;
          },
        );
      } else {
        setState(
          () {
            _isEmpty = true;
            _isLoading = false;
          },
        );
      }
    } else {
      setState(
        () {
          _isLoading = false;
        },
      );
      throw Exception('Failed to fetch users');
    }
  }

  Future<void> _refreshUsers() async {
    setState(() {
      _users.clear();
      _page = 1;
      _isEmpty = false;
    });

    await _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsers,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _isEmpty
                ? const Center(child: Text('No users found'))
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, user.firstName);
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text(user.email),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class User {
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
