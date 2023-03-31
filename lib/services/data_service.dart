import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_client/models/device_model.dart';
import 'package:flutter_client/models/service_model.dart';

import "package:http/http.dart" as http;

import '../constants/constants.dart';
import 'auth_interceptor.dart';

class DataService {
  static Future getAllDevices(TokenResponse? tokenResponse) async {
    final dio = Dio();
    // dio.interceptors.addAll([
    //   AuthInterceptor(dio),
    // ]);

    List<DeviceModel> devices = [];
    String url = API_BASE_URL + "/device";

    Response response = await dio.get(
      url,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Authorization": "Bearer ${tokenResponse?.accessToken}",
        },
      ),
    );

    // final response = await http.get(
    //   Uri.parse(API_BASE_URL + "/device"),
    //   headers: {"Authorization": "Bearer ${tokenResponse?.accessToken}"},
    // );

    if (response.statusCode == 200) {
      print(response.data.length);
      for (var i = 0; i < response.data.length; i++) {
        devices.add(DeviceModel(
          id: response.data[i]["id"],
          name: response.data[i]["name"],
          description: response.data[i]["description"],
          manufacturer: response.data[i]["manufacturer"],
          imageUrl: response.data[i]["imageUrl"],
          price: double.parse(response.data[i]["price"].toString()),
        ));
      }
    }
    return devices;
  }

  static Future getAllServices() async {
    final dio = Dio();
    // dio.interceptors.addAll([
    //   AuthInterceptor(dio),
    // ]);

    List<ServiceModel> services = [];
    String url = API_BASE_URL + "/service";

    Response response = await dio.get(
      url,
      options: Options(
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      ),
    );

    if (response.statusCode == 200) {
      print(response.data.length);
      for (var i = 0; i < response.data.length; i++) {
        services.add(ServiceModel(
          id: response.data[i]["id"],
          name: response.data[i]["name"],
          description: response.data[i]["description"],
        ));
      }
    }
    return services;
  }

  static Future getCartDevices(TokenResponse? tokenResponse) async {
    final dio = Dio();
    // dio.interceptors.addAll([
    //   AuthInterceptor(dio),
    // ]);

    List<DeviceModel> devices = [];
    String url = API_BASE_URL + "/cart/devices";

    Response response = await dio.get(
      url,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Authorization": "Bearer ${tokenResponse?.accessToken}",
        },
      ),
    );

    // final response = await http.get(
    //   Uri.parse(API_BASE_URL + "/device"),
    //   headers: {"Authorization": "Bearer ${tokenResponse?.accessToken}"},
    // );

    if (response.statusCode == 200) {
      inspect(response.data);
      for (var i = 0; i < response.data.length; i++) {
        devices.add(DeviceModel(
          id: response.data[0]['devices'][i]["_id"],
          name: response.data[0]['devices'][i]["name"],
          description: response.data[0]['devices'][i]["description"],
          manufacturer: response.data[0]['devices'][i]["manufacturer"],
          imageUrl: response.data[0]['devices'][i]["imageUrl"],
          price: double.parse(response.data[0]['devices'][i]["price"].toString()),
        ));
      }
    }
    return devices;
  }
}
