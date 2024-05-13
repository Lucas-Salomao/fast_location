import 'package:dio/dio.dart'; // Importa o pacote Dio para realizar requisições HTTP.
import 'package:fast_location/src/http/app_dio.dart'; // Importa a classe AppDio para configurar a conexão HTTP.

class HomeRepository with AppDio { // Define o repositório para a tela inicial, utilizando a classe AppDio.
  Future<Response> getAddressViaCep(String cep) async { // Função para obter um endereço a partir do CEP usando a API ViaCEP.
    String baseURL = "https://viacep.com.br/ws"; // Define a URL base da API ViaCEP.

    Dio clientHTTP = await AppDio.getConnection(); // Obtém a instância configurada do Dio da classe AppDio.

    return clientHTTP.get('$baseURL/$cep/json/'); // Realiza uma requisição GET para a API ViaCEP com o CEP fornecido e retorna a resposta.
  }
}