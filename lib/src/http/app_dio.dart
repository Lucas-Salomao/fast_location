import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Define uma classe mixin chamada AppDio.
// Mixins permitem adicionar funcionalidades a uma classe sem usar herança.
mixin AppDio {
  // Define uma função estática assíncrona chamada getConnection que retorna uma instância Dio.
  static Future<Dio> getConnection() async {
    // Cria uma instância do Dio.
    final dio = Dio();

    // Configura as opções básicas do Dio, incluindo tempo limite de conexão e recebimento.
    dio.options = BaseOptions(
      connectTimeout: 15000, // Tempo limite de conexão de 15 segundos
      receiveTimeout: 30000, // Tempo limite de recebimento de 30 segundos
      headers: {
        // Define cabeçalhos padrão para todas as requisições
        "Accept": "application/json", // Define o tipo de conteúdo aceito como JSON
        "Content-Type": "application/json", // Define o tipo de conteúdo enviado como JSON
      },
    );

    // Adiciona um interceptador ao Dio para registrar as requisições, respostas e erros.
    dio.interceptors.add(
      InterceptorsWrapper(
        // Define uma função para interceptar as requisições.
        onRequest: (options, handler) {
          // Imprime o log da requisição.
          _printRequestLog(options);
          // Passa a requisição para o próximo interceptador ou para o manipulador final.
          return handler.next(options);
        },
        // Define uma função para interceptar as respostas.
        onResponse: (response, handler) {
          // Imprime o log da resposta.
          _printResponseLog(response);
          // Passa a resposta para o próximo interceptador ou para o manipulador final.
          return handler.next(response);
        },
        // Define uma função para interceptar os erros.
        onError: (error, handler) {
          // Imprime o log do erro.
          _printErrorLog(error);
          // Passa o erro para o próximo interceptador ou para o manipulador final.
          return handler.next(error);
        },
      ),
    );

    // Retorna a instância do Dio configurada.
    return dio;
  }

  // Define uma função estática para imprimir o log da requisição.
  static void _printRequestLog(RequestOptions options) {
    debugPrint('-----------| Request log |-----------');
    debugPrint('${options.uri}');
  }

  // Define uma função estática para imprimir o log da resposta.
  static void _printResponseLog(Response response) {
    debugPrint('-----------| Response log |-----------');
    debugPrint(response.data.toString());
  }

  // Define uma função estática para imprimir o log do erro.
  static void _printErrorLog(DioError error) {
    debugPrint('-----------| Error log |-----------');
    debugPrint('${error.response}');
  }
}
