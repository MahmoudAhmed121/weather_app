import 'package:dio/dio.dart';

abstract class ApiError {
  final String errMessages;

  const ApiError(this.errMessages);
}

class ServerFailure extends ApiError {
  ServerFailure(super.errMessages);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with Api Server');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return ServerFailure("Dad Certificate with api server");

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');

      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');

      case DioExceptionType.unknown:
        return ServerFailure('unknown');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']["message"]);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure(
          'There is the problem with server, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
