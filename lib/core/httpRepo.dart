import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:tyres_frontend/core/Widgets/globalAuthBloc.dart';
import 'package:tyres_frontend/core/remoteConstats.dart';
import 'package:tyres_frontend/core/sharedPreferencesDatasource.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_bloc.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocStates.dart';

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
  final Globalauthbloc authenticationBloc;
  final Sharedpreferencesdatasource sharedPreferences;

  HttpClientImpl({
    required this.authenticationBloc,
    required this.sharedPreferences,
  });
  _getHeaders() {
    var token = sharedPreferences.getValue("token");
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
      "Authorization": "Bearer $token",
    };
    return headers;
  }

  @override
  Future<StandardHttpResponse> get({required String host}) async {
    late http.Response result;

    result = await http.get(Uri.parse("http://localhost:5205/$host"), headers: _getHeaders()).catchError((e) {
      return http.Response(e.toString(), 500);
    });
    if (result.statusCode == 401) {
      authenticationBloc.emit(AuthenticationUnAuthorizedState());
      return StandardHttpResponse(statusCode: 401, data: "", errorMessage: "UnAuthorized", isSuccess: false);
    }

    return StandardHttpResponse.fromHttpResponse(result);
  }

  @override
  Future<StandardHttpResponse> post({required String host, dynamic? body}) async {
    late http.Response result;

    result = await http.post(Uri.parse("http://localhost:5205/$host"), headers: _getHeaders(), body: json.encode(body)).catchError((e) {
      return http.Response(e.toString(), 500);
    });
    if (result.statusCode == 401) authenticationBloc.emit(AuthenticationUnAuthorizedState());

    return StandardHttpResponse.fromHttpResponse(result);
  }

  @override
  Future<StandardHttpResponse> put({required String host, dynamic? body}) async {
    late http.Response result;

    result = await http.put(Uri.parse("http://localhost:5205/$host"), headers: _getHeaders(), body: json.encode(body)).catchError((e) {
      return http.Response(e.toString(), 500);
    });
    if (result.statusCode == 401) authenticationBloc.emit(AuthenticationUnAuthorizedState());

    return StandardHttpResponse.fromHttpResponse(result);
  }

  @override
  Future<StandardHttpResponse> delete({required String host, body}) async {
    late http.Response result;

    result = await http.delete(Uri.parse("http://localhost:5205/$host"), headers: _getHeaders()).catchError((e) {
      return http.Response(e.toString(), 500);
    });
    if (result.statusCode == 401) authenticationBloc.emit(AuthenticationUnAuthorizedState());

    return StandardHttpResponse.fromHttpResponse(result);
  }
}
