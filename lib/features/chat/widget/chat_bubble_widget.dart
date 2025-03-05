import 'package:flutter/material.dart';
import 'package:nasebak_app/features/chat/model/message_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = message.isCurrentUser;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  message.imageUrl.isEmpty
                      ? AssetImage(AppAssetPaths.personalInfoDummyProfileImage)
                      : NetworkImage(message.imageUrl) as ImageProvider,
            ),
          SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isCurrentUser ? Radius.circular(12) : Radius.zero,
                bottomRight: isCurrentUser ? Radius.zero : Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          if (isCurrentUser) SizedBox(width: 8),
          if (isCurrentUser)
            Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      message.imageUrl.isEmpty
                          ? AssetImage(
                            AppAssetPaths.personalInfoDummyProfileImage,
                          )
                          : NetworkImage(message.imageUrl) as ImageProvider,
                ),
                SizedBox(height: 2),
                Text(
                  message.senderName,
                  style: context.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
