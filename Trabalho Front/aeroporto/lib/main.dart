import 'package:aeroporto/aeroporto_app.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

void main() async {
  Get.put(ApiServiceFuncionario());

  runApp(
    const AeroportoApp(),
  );
}
