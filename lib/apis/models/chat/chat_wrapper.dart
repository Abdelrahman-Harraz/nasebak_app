import 'package:nasebak_app/apis/models/_base/base_wrapper.dart';
import 'package:nasebak_app/apis/models/chat/chat_api_model.dart';

class ChatWrapper extends BaseWrapper {
  final List<ChatApiModel>? data;
  ChatWrapper(this.data, super.isSuccess, super.details, super.message);

  ChatWrapper.fromJson(super.json)
    : data =
          json["data"] != null
              ? (json["data"] as List)
                  .map((item) => ChatApiModel.fromJson(item))
                  .toList()
              : null,
      super.fromJson();
}
