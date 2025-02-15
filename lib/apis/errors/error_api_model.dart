import 'package:nasebak_app/apis/errors/error_api_helper.dart';
import 'package:nasebak_app/apis/errors/locale_dio_exceptions.dart';
import 'package:nasebak_app/apis/models/_base/details_model.dart';
import 'package:dio/dio.dart';

class ErrorApiModel {
  final bool isMessageLocalizationKey;
  final String message;
  final List<String> messageList;
  final int code;
  ErrorApiModel({
    required this.isMessageLocalizationKey,
    required this.message,
    required this.code,
    this.messageList = const [],
  });

  factory ErrorApiModel.fromDioException(DioException dioError) {
    late int codeError;
    switch (dioError.type) {
      case DioExceptionType.cancel:
        codeError = 1001;
        break;
      case DioExceptionType.connectionTimeout:
        codeError = 1002;
        break;
      case DioExceptionType.receiveTimeout:
        codeError = 1003;
        break;
      case DioExceptionType.badResponse:
        // use code from 1004 - 1010
        codeError = ErrorApiHelper.handleResponseErrorCode(
          dioError.response?.statusCode,
        );
        break;
      case DioExceptionType.sendTimeout:
        codeError = 1011;
        break;
      case DioExceptionType.unknown:
        if (dioError.message?.contains("SocketException") ?? false) {
          codeError = 1012;
          break;
        }
        codeError = 1013;
        break;
      default:
        codeError = 1014;
        break;
    }
    return ErrorApiModel(
      code: codeError,
      isMessageLocalizationKey: true,
      message: LocaleDioExceptions.getLocaleMessage(codeError),
    );
  }

  factory ErrorApiModel.identifyError({dynamic error}) {
    ErrorApiModel errorApiModel;
    String? stackTrace = "";
    if (error is TypeError) {
      stackTrace = error.stackTrace.toString();
      errorApiModel = ErrorApiModel(
        code: 1015,
        message: ErrorApiHelper.formErrorMessage(error.toString(), stackTrace),
        isMessageLocalizationKey: false,
      );
    } else {
      errorApiModel = ErrorApiModel(
        code: 1015,
        message: LocaleDioExceptions.getLocaleMessage(1015),
        isMessageLocalizationKey: true,
      );
    }
    return errorApiModel;
  }

  factory ErrorApiModel.fromLoginJson(DioException error) {
    final Map<String, dynamic> extractedData =
        error.response?.data as Map<String, dynamic>;
    return ErrorApiModel(
      code: error.response?.statusCode ?? 1007,
      message: extractedData["message"],
      isMessageLocalizationKey: false,
    );
  }

  factory ErrorApiModel.fromDetailsModel(DetailsModel detailsModel) =>
      ErrorApiModel(
        code: 0,
        message: detailsModel.message ?? "NO MESSAGE",
        isMessageLocalizationKey: false,
      );

  factory ErrorApiModel.fromJsonMultiError(DetailsModel detailsModel) =>
      ErrorApiModel(
        code: 0,
        message: detailsModel.message ?? "NO MESSAGE",
        isMessageLocalizationKey: false,
      );
}
