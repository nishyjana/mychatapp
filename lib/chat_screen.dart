import 'dart:async';

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

  StreamSubscription? _streamSubscription;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    var apiKey = dotenv.get('API_URL', fallback: 'API_URL not found');
    
    chatGPT = ChatGPT.instance.builder(apiKey);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(text: _controller.text, sender: "user");

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    final request = CompleteReq(
        prompt: message.text, model: kTranslateModelV3, max_tokens: 300); var apiKey = dotenv.get('API_URL', fallback: 'API_URL not found');

    _streamSubscription = await chatGPT!
        .onCompleteStream(request: request)
        .listen((response) {
      ChatMessage botMessage =
          ChatMessage(text: response!.choices[0].text, sender: 'Bestie');

      setState(() {
        _messages.insert(0, botMessage);
        _isTyping = false;
      });
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        // ignore: unnecessary_const
        Expanded(
            child: TextField(
          onSubmitted: (value) => _sendMessage(),
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
      body: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
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
