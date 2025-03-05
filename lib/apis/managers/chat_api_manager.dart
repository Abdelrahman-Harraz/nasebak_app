import 'package:nasebak_app/apis/_base/dio_api_manager.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/apis/errors/error_api_model.dart';
import 'package:nasebak_app/apis/models/chat/chat_send_model.dart';
import 'package:nasebak_app/apis/models/chat/chat_wrapper.dart';
import 'package:nasebak_app/apis/models/chat/send_chat_wrapper.dart';

class ChatApiManager {
  final DioApiManager dioApiManager;
  const ChatApiManager(this.dioApiManager);

  Future<void> fetchChatConversations(
    void Function(ChatWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getChatUrl)
        .then((response) {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          ChatWrapper wrapper = ChatWrapper.fromJson(extractedData);
          success(wrapper);
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> sendMessage(
    ChatSendModel chatSendModel,
    void Function(SendChatWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .post(ApiKeys.sendChatUrl, data: chatSendModel.toMap())
        .then((response) {
          Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          SendChatWrapper wrapper = SendChatWrapper.fromJson(extractedData);
          success(wrapper);
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }
}
