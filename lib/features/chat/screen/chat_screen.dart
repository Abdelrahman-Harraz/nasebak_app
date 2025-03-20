import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/chat/bloc/chat_bloc.dart';
import 'package:nasebak_app/features/chat/bloc/chat_repository.dart';
import 'package:nasebak_app/features/chat/model/chat_ui_model.dart';
import 'package:nasebak_app/features/chat/screen/conversation_screen.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/cached_network_image/app_cached_network_image.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/format/app_date_format.dart';
import 'package:nasebak_app/utils/status_bar/statusbar_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(chatRepository: ChatRepository()),
      child: const ChatScreenWithBloc(),
    );
  }
}

class ChatScreenWithBloc extends BaseStatefulScreenWidget {
  const ChatScreenWithBloc({super.key});

  @override
  BaseScreenState<ChatScreenWithBloc> baseScreenCreateState() =>
      _ChatScreenWithBlocState();
}

class _ChatScreenWithBlocState extends BaseScreenState<ChatScreenWithBloc> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getChatDataEvent);
    setStatusBarColor(color: Colors.transparent);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        scrolledUnderElevation: .1,

        actions: [
          IconButton(
            onPressed: _openNotificationsScreen,
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
        ],
      ),
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

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildPageContent() {
    return _pageContent();
  }

  Widget _pageContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: 100), _buildChatList()],
      ),
    );
  }

  Widget _buildChatList() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.userInfoCardBorder.withValues(alpha: 0.2),
              ),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.chatUiModel.length,
              itemBuilder: (context, index) {
                final conversation = state.chatUiModel[index];
                return Column(
                  children: [
                    _buildChatItem(conversation),
                    if (index < state.chatUiModel.length - 1)
                      Divider(color: AppColors.chatScreenBorder),
                  ],
                );
              },
            ),
          );
        } else {
          return EmptyWidget();
        }
      },
    );
  }

  Widget _buildChatItem(ChatUiModel conversation) {
    return GestureDetector(
      onTap: _openConversationScreen,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      conversation.profileImageUrl.isEmpty
                          ? AssetImage(
                            AppAssetPaths.personalInfoDummyProfileImage,
                          )
                          : AppCachedNetworkImage(
                                imageUrl: conversation.profileImageUrl,
                              )
                              as ImageProvider,
                ),
                if (conversation.unreadCount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.messageBadgeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${conversation.unreadCount}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.name,
                    style: context.bodyLarge?.copyWith(
                      color: AppColors.chatWhiteText,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    conversation.lastMessage,
                    style: context.bodyLarge?.copyWith(
                      color: AppColors.chatWhiteText.withValues(alpha: 0.70),
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppDateFormat.formattingDisplayDate(
                    conversation.time,
                    Localizations.localeOf(context).languageCode,
                  ),
                  style: context.bodyLarge?.copyWith(
                    color: AppColors.chatWhiteText.withValues(alpha: 0.70),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                Text(
                  AppDateFormat.formattingTime(
                    conversation.time,
                    Localizations.localeOf(context).languageCode,
                  ),
                  style: context.bodyLarge?.copyWith(
                    color: AppColors.chatWhiteText.withValues(alpha: 0.70),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  ChatBloc get currentBloc => context.read<ChatBloc>();

  void _getChatDataEvent() {
    currentBloc.add(FetchChatConversationsEvent());
  }

  void _openConversationScreen() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ConversationScreen()));
  }

  void _openNotificationsScreen() {
    context.push(AppRouter.notificationsScreen);
  }
}
