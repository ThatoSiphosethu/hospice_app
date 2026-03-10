import 'package:flutter/material.dart';
import 'package:hospice_app/shared/widgets/body_card.dart';
//import 'package:image_picker/image_picker.dart';

// This screen is a simplified staff messaging interface for communication between relatives and caregivers.
class StaffMessagingScreen extends StatefulWidget {
  const StaffMessagingScreen({super.key});

// image picker example for future media sharing feature
  @override
  State<StaffMessagingScreen> createState() => _StaffMessagingScreenState();
}

class _StaffMessagingScreenState extends State<StaffMessagingScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sarah Johnson, CNA", style: TextStyle(fontSize: 16)),
            Text("Online • On Shift", style: TextStyle(fontSize: 12, color: Colors.greenAccent)),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. Chat History Area
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24), // Consistent edge padding
              children: [
                _buildMessageBubble("Hello! How is my mother doing this afternoon?", true),
                _buildMessageBubble("She is doing great. We just finished a short walk in the garden. She's resting now.", false),
                _buildMessageBubble("That's wonderful to hear. Thank you, Sarah!", true),
              ],
            ),
          ),

          // 2. Input Area using BodyCard for professional elevation
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: BodyCard(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.add_a_photo_outlined, color: Colors.blue), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      // Add logic to send message
                      _messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}