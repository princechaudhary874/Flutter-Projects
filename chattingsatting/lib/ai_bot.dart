import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  ChatUser me = ChatUser(id: '1', firstName: 'Prince', lastName: 'Chaudhary');
  ChatUser bot = ChatUser(id: '2', firstName: 'Bro');
  List<ChatMessage> allmessage = [];
  List<ChatUser> typing = [];
  final myUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDWmQI6JAvDSeM3bw0rMIC-NvI3NowX7uE';
  final header = {'Content-Type': 'application/json'};

  // get message data from user
  getData(ChatMessage m) async {
    typing.add(bot);
    allmessage.insert(0, m);
    setState(() {});
    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    await http
        .post(Uri.parse(myUrl), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        ChatMessage m1 = ChatMessage(
          text: result['candidates'][0]['content']['parts'][0]['text'],
          user: bot,
          createdAt: DateTime.now(),
        );
        allmessage.insert(0, m1);
        setState(() {});
      } else {
        print('error occurred');
      }
    }).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '🤖 AI Bot',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.cyan,
          ),
        ),
        centerTitle: true,
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: me,
        onSend: (ChatMessage m) {
          getData(m);
        },
        messages: allmessage,
      ),
    );
  }
}
