import 'dart:async';
import 'dart:developer';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mychatapp/ChatMessage.dart';
import 'package:mychatapp/threedots.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  ChatGPT? chatGPT;
  var apiKey = dotenv.get('API_URL', fallback: 'API_URL not found');

  StreamSubscription? _streamSubscription;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    

    chatGPT = ChatGPT.instance.builder(
        apiKey,
        baseOption: HttpSetup(receiveTimeout: 10000));
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(text: _controller.text, sender: "user");

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    void _handleMessage(response) {
      ChatMessage botMessage =
          ChatMessage(text: response!.choices[0].text, sender: 'Bestie');
      setState(() {
        _messages.insert(0, botMessage);
        _isTyping = false;
      });
    }

    final request = CompleteReq(
        prompt: message.text, model: kTranslateModelV3, max_tokens: 300);

    _streamSubscription = chatGPT!
        .builder(apiKey)
        .onCompleteStream(request: request)
        .asBroadcastStream()
        .listen((response) {
      _handleMessage(response);
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        // ignore: unnecessary_const
        Expanded(
            child: TextField(
          controller: _controller,
          decoration:
              const InputDecoration.collapsed(hintText: "Send a message"),
        )),
        IconButton(
            onPressed: () => _sendMessage(), icon: const Icon(Icons.send))
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bosom Buddy")),
      backgroundColor: Color.fromARGB(255, 119, 144, 235),
      body: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                      reverse: true,
                      padding: Vx.m8,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _messages[index];
                      })),
              if (_isTyping) const ThreeDots(),
              const Divider(
                height: 1.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
