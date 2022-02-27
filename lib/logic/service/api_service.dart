import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:elemovie/logic/helper/utility.dart';

enum MethodRequest { POST, GET, PUT, DELETE, PATCH }

class ApiService {
  final Dio _dio = Dio();

  ApiService(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 60000; //90s
    _dio.options.receiveTimeout = 10000;
    _dio.options.headers = {'Accept': 'application/json'};
  }

  Response onReturnResponse(Response? response, String url) {
    return Response(
        requestOptions: response?.requestOptions ?? RequestOptions(path: url),
        data: response?.data,
        headers: response?.headers ?? Headers(),
        isRedirect: response?.isRedirect ?? false,
        statusCode: response?.statusCode ?? 500,
        statusMessage: response?.statusMessage ?? '',
        redirects: response?.redirects ?? <RedirectRecord>[]);
  }

  Future<Response> call(String url,
      {MethodRequest method = MethodRequest.GET,
      Map<String, dynamic>? request,
      Map<String, String>? header,
      bool useFormData = false}) async {
    if (header != null) {
      _dio.options.headers = header;
    }

    print('URL : ${_dio.options.baseUrl}$url');
    print('Method : $method');
    print("Header : ${_dio.options.headers}");
    print("Request : $request");

    if (!(await Utility.isConnectedInternet())) {
      return onReturnResponse(null, url);
    }

    var selectedMethod;
    try {
      Response response;
      var options = Options(
        followRedirects: false,
        validateStatus: (status) => true,
      );
      switch (method) {
        case MethodRequest.GET:
          selectedMethod = method;
          response =
              await _dio.get(url, queryParameters: request, options: options);
          break;
        case MethodRequest.PUT:
          selectedMethod = method;
          response = await _dio.put(url,
              data: useFormData ? FormData.fromMap(request ?? {}) : request,
              options: options);
          break;
        case MethodRequest.DELETE:
          selectedMethod = method;
          response = await _dio.delete(url,
              data: useFormData ? FormData.fromMap(request ?? {}) : request,
              options: options);
          break;
        case MethodRequest.POST:
          selectedMethod = MethodRequest.POST;
          response = await _dio.post(url,
              data: useFormData ? FormData.fromMap(request ?? {}) : request,
              options: options);
          break;
        default:
          selectedMethod = MethodRequest.PATCH;
          response = await _dio.patch(url,
              data: useFormData ? FormData.fromMap(request ?? {}) : request,
              options: options);
      }

      print(
          'Success $selectedMethod $url: \nResponse : ${response.data} \nStatus Code : ${response.statusCode}');

      return onReturnResponse(response, url);
    } on DioError catch (e) {
      print(
          'Error $selectedMethod $url: $e\nData: ${e.response?.data} \nStatus Code : ${e.response?.statusCode}');

      return onReturnResponse(e.response, url);
    }
  }
}
