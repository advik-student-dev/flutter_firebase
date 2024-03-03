import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final List<String> _interests = [];

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> editField(String field) async {
    if (field == 'username') {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit Preferred Name'),
          content: TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Preferred Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _nameController.text = _nameController.text;
                });
                // Implement logic to save preferred name
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      );
    } else if (field == 'bio') {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit Bio'),
          content: TextFormField(
            controller: _bioController,
            decoration: InputDecoration(labelText: 'Bio'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Implement logic to save bio
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> addInterest() async {
    final newInterest = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? newInterest;
        return AlertDialog(
          title: const Text('Add New Interest'),
          content: TextField(
            onChanged: (value) => newInterest = value,
            decoration: const InputDecoration(labelText: 'Interest'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(newInterest);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (newInterest != null) {
      setState(() {
        _interests.add(newInterest!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("ProfilePage"),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          const Icon(
            Icons.person,
            size: 72,
          ),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          MyTextBox(
            text: _nameController.text,
            sectionName: 'Preferred Name',
            onPressed: () => editField('username'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Interests',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
          ),
          Column(
            children: _interests
                .map((interest) => ListTile(title: Text(interest)))
                .toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addInterest,
        child: Icon(Icons.add),
      ),
    );
  }
}
