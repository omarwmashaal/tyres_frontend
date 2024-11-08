import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';

abstract class Sharedpreferencesdatasource {
  Future<NoParams> setValue(String key, value);
  dynamic getValue(String key);
}

class SharedPreferencesDatasourceImpl implements Sharedpreferencesdatasource {
  final Object sharedPreferences;

  SharedPreferencesDatasourceImpl({required this.sharedPreferences});
  @override
  dynamic getValue(String key) {
    // return sharedPreferences.get(key);
    return "";
  }

  @override
  Future<NoParams> setValue(String key, value) async {
    // if (value is String)
    //   await sharedPreferences.setString(key, value);
    // else if (value is bool)
    //   await sharedPreferences.setBool(key, value);
    // else if (value is double)
    //   await sharedPreferences.setDouble(key, value);
    // else if (value is int)
    //   await sharedPreferences.setInt(key, value);
    // else if (value is List<String>)
    //   await sharedPreferences.setStringList(key, value);
    // else
    //   throw Exception("Invalid value type");
    return NoParams();
  }
}
