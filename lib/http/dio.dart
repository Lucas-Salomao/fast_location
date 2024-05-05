import 'package:flutter/material.dart'; // Importa o pacote base do Flutter para criação de interfaces
import 'package:dio/dio.dart';         // Importa o pacote Dio para realizar requisições HTTP

class CepLookup {
  static Future<Map<String, dynamic>?> getEnderecoPorCep(String cep) async {
    // Define a URL base para a consulta de CEP na ViaCep
    String url = 'https://viacep.com.br/ws/$cep/json';

    try {
      // Cria uma instância do Dio para realizar a requisição
      final dio = Dio();

      // Realiza uma requisição GET para a URL informada
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        // Verifica se o código de status da resposta é 200 (Sucesso)
        // Se for sucesso, retorna os dados da resposta convertidos em um Map
        return response.data;
      } else {
        // Caso o código de status seja diferente de 200 (Erro)
        // Imprime uma mensagem de erro com o código de status da resposta
        print('Erro: ${response.statusCode}');
        // Retorna null para indicar que houve um erro
        return null;
      }
    } catch (error) {
      // Captura qualquer erro que possa ocorrer durante a requisição
      // Imprime a mensagem de erro
      print('Erro: $error');
      // Retorna null para indicar que houve um erro
      return null;
    }
  }
}