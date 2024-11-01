import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:tyres_frontend/core/remoteConstats.dart';

class StandardHttpResponse {
  final Object? data;
  final int statusCode;
  final String? errorMessage;
  final bool? isSuccess;

  StandardHttpResponse({
    this.data,
    required this.statusCode,
    this.errorMessage,
    this.isSuccess,
  });

  factory StandardHttpResponse.fromHttpResponse(http.Response response) {
    try {
      final map = json.decode(response.body);
      return StandardHttpResponse(
        data: map['Data'],
        statusCode: map['StatusCode'],
        errorMessage: map['ErrorMessage'],
        isSuccess: map['isSuccess'],
      );
    } on Exception {
      return StandardHttpResponse(
        statusCode: response.statusCode,
        errorMessage: response.body,
        isSuccess: false,
      );
    }
  }

  factory StandardHttpResponse.fromDIOResponse(dio.Response response) {
    final map = (response.data);
    return StandardHttpResponse(
      data: () {
        try {
          return map['result'] != null ? json.encode(map['result']) : null;
        } catch (e) {
          return map['result'].toString();
        }
      }(),
      statusCode: response.statusCode ?? 400,
      errorMessage: response.statusCode != 200 ? map['errorMessage'] : "",
    );
  }
}

abstract class HttpRepo {
  Future<StandardHttpResponse> get({required String host});

  Future<StandardHttpResponse> post({required String host, dynamic? body});

  Future<StandardHttpResponse> put({required String host, dynamic? body});
  Future<StandardHttpResponse> delete({required String host, dynamic? body});
}

class HttpClientImpl implements HttpRepo {
  @override
  Future<StandardHttpResponse> get({required String host}) async {
    late http.Response result;

    result = await http.get(Uri.parse("http://localhost:5205/$host"), headers: headers()).catchError((e) {
      return http.Response(e.toString(), 500);
    });

    return StandardHttpResponse.fromHttpResponse(result);
  }

  @override
  Future<StandardHttpResponse> post({required String host, dynamic? body}) async {
    late http.Response result;
    try {
      result = await http.post(Uri.parse(host), headers: headers(), body: json.encode(body));

      return StandardHttpResponse.fromHttpResponse(result);
    } catch (e) {
      return StandardHttpResponse(statusCode: result!.statusCode, errorMessage: result.reasonPhrase);
    }
  }

  @override
  Future<StandardHttpResponse> put({required String host, dynamic? body}) async {
    late http.Response result;
    print("put");
    try {
      result = await http.put(Uri.parse(host), headers: headers(), body: json.encode(body));
      print(result);

      return StandardHttpResponse.fromHttpResponse(result);
    } catch (e) {
      return StandardHttpResponse(statusCode: result!.statusCode, errorMessage: result.reasonPhrase);
    }
  }

  @override
  Future<StandardHttpResponse> delete({required String host, body}) async {
    late http.Response result;
    try {
      result = await http.delete(Uri.parse(host), headers: headers(), body: json.encode(body));
      print(result);

      return StandardHttpResponse.fromHttpResponse(result);
    } catch (e) {
      return StandardHttpResponse(statusCode: result!.statusCode, errorMessage: result.reasonPhrase);
    }
  }
}
