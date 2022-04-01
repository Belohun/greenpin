import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    final greenPinData = data as Map<String, dynamic>;
    response.data = greenPinData['response'];
    handler.resolve(response);
  }
}
