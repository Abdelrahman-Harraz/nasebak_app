import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/features/chat/bloc/chat_bloc.dart';
import 'package:nasebak_app/features/chat/bloc/chat_repository.dart';
import 'package:nasebak_app/features/chat/model/message_model.dart';
import 'package:nasebak_app/features/chat/widget/chat_bubble_widget.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';
import 'package:nasebak_app/utils/status_bar/statusbar_controller.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(chatRepository: ChatRepository()),
      child: const ConversationScreenWithBloc(),
    );
  }
}

class ConversationScreenWithBloc extends BaseStatefulScreenWidget {
  const ConversationScreenWithBloc({super.key});

  @override
  BaseScreenState<ConversationScreenWithBloc> baseScreenCreateState() =>
      _ConversationScreenWithBlocState();
}

class _ConversationScreenWithBlocState
    extends BaseScreenState<ConversationScreenWithBloc> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setStatusBarColor(color: Colors.transparent);
    });
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssetPaths.homeBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: _buildPageContent(),
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return Column(
      children: [
        _conversationScreenHeader(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.userInfoCardBorder.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [_chatBubbleWidgetBuilder(), _buildMessageInputField()],
          ),
        ),
      ],
    );
  }

  Widget _chatBubbleWidgetBuilder() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: MessageModel.messages.length,
      itemBuilder: (context, index) {
        final message = MessageModel.messages[index];
        return ChatBubble(message: message);
      },
    );
  }

  Widget _conversationScreenHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(AppAssetPaths.reportIcon),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _messageController,
        decoration: InputDecoration(
          hintText: "${context.translate(LocalizationKeys.enterMessage)}...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.26),
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              AppAssetPaths.sendIcon,
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.57),
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              final message = _messageController.text;
              if (message.isNotEmpty) {
                _messageController.clear();
              }
            },
          ),
        ),
      ),
    );
  }
}
