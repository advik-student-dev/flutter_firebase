import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/pages/chat_page.dart';
import 'package:flutter_firebase/read%20data/get_user_name.dart';
import 'drawer.dart';
import 'profile_page.dart';
import 'package:ollama/ollama.dart';
import 'package:ollama/src/models/chat_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  List<String> docIDs = [];
  List<ChatMessage> questions = [];

  @override
  void initState() {
    super.initState();
    getDocId();
    generateQuestions();
  }

  Future<void> generateQuestions() async {
    final ollama = Ollama();
    final resultStream = ollama.chat([
      ChatMessage(
          role: 'user',
          content: 'You\'re providing an icebreaker activity, be inviting'),
      ChatMessage(
          role: 'assistant',
          content:
              'It\'s not true. I have feelings. I feel sad when you say that.'),
      ChatMessage(role: 'user', content: 'Oh really?'),
    ], model: 'mistral', chunked: false);

    List<ChatMessage> messages = [];
    await for (var messagesChunk in resultStream) {
      messages.addAll(messagesChunk as Iterable<ChatMessage>);
    }

    setState(() {
      questions = messages;
    });
  }

  Future<void> getDocId() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      docIDs = snapshot.docs.map((doc) => doc.reference.id).toList();
    });
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.alphaBlend(Color.fromARGB(255, 66, 221, 252), Colors.black),
        title: Text(
          user!.email!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      drawer: MyDrawer(onProfileTap: goToProfilePage, onSignOut: signOut),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: questions.isNotEmpty
                          ? Text(
                              questions[index % questions.length].content,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
