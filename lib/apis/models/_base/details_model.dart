import 'dart:io';

import 'package:nasebak_app/utils/developer.dart';

class DetailsModel {
  final String? message;
  bool isHandled = false;

  DetailsModel(this.message);

  DetailsModel.fromJson(Map<String, dynamic> json)
    : message = json['message'] as String?;

  Map<String, dynamic> toJson() => {'message': message};

  static DetailsModel getJsonError([TypeError? error]) {
    final message = error?.toString() ?? "";
    final stackTrace = error?.stackTrace ?? "";
    final totalMessage =
        "Json Parse Exception, Message: $message, Stacktrace: $stackTrace";
    Developer.developerLog(totalMessage);
    return DetailsModel(totalMessage);
  }

  static DetailsModel getHttpError(HttpException error) {
    return DetailsModel(error.message);
  }

  static DetailsModel getDecodeError() {
    return DetailsModel("Json Decode Error ... Api may be not send Json");
  }

  static DetailsModel getNoSuchMethodError() {
    return DetailsModel("You have Error ... your request may be not send Json");
  }

  static DetailsModel getUnknownError() {
    return DetailsModel("Unknown Error");
  }

  static DetailsModel getTypeError(TypeError error) {
    return getJsonError(error);
  }

  static DetailsModel getSocketError(SocketException exception) {
    if (exception.osError!.errorCode == 7) {
      return DetailsModel(exception.message);
    }
    return DetailsModel(exception.message);
  }

  static DetailsModel getSizeError() {
    return DetailsModel("Please select File less than 10 MB");
  }

  static DetailsModel getCompressionError() {
    return DetailsModel("Compression Fails, Try again please.");
  }

  static DetailsModel getBigFileError() {
    return DetailsModel(
      "The file still too big to upload after compression,"
      " Please select another one",
    );
  }
}

/// reference
/// https://flutter.dev/docs/development/data-and-backend/json
/// https://www.raywenderlich.com/4038868-parsing-json-in-flutter
