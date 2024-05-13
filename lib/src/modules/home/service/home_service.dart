import 'package:dio/dio.dart'; // Importa o pacote Dio para lidar com requisições HTTP.
import 'package:fast_location/src/modules/home/model/address_model.dart'; // Importa o modelo de endereço.
import 'package:fast_location/src/modules/home/repositories/home_local_repository.dart'; // Importa o repositório local para a tela inicial.
import 'package:fast_location/src/modules/home/repositories/home_repository.dart'; // Importa o repositório remoto para a tela inicial.
import 'package:flutter/material.dart'; // Importa o Flutter para desenvolvimento de interface.
import 'package:geocoding/geocoding.dart'; // Importa o pacote Geocoding para converter endereços em coordenadas geográficas.
import 'package:map_launcher/map_launcher.dart'; // Importa o pacote Map Launcher para abrir aplicativos de mapas.

class HomeService { // Define a classe HomeService, que atua como intermediária entre a tela inicial e os repositórios.
  final HomeRepository _repository = HomeRepository(); // Cria uma instância do repositório remoto.
  final HomeLocalRepository _localRepository = HomeLocalRepository(); // Cria uma instância do repositório local.

  Future<AddressModel> getAddress(String cep) async { // Função para obter um endereço a partir de um CEP.
    try {
      Response response = await _repository.getAddressViaCep(cep); // Faz a requisição à API ViaCEP usando o repositório remoto.
      return AddressModel.fromJson(response.data); // Converte a resposta em um objeto AddressModel.
    } catch (ex) {
      debugPrint('HomeService.getAddress -> ${ex.toString()}'); // Imprime o erro no console em caso de falha.
      rethrow; // Propaga o erro.
    }
  }

  Future<List<AddressModel>> getAddressRecentList() async { // Função para obter a lista de endereços recentes.
    try {
      final addressRecentList = await _localRepository.getAddressRecent(); // Obtém a lista de recentes do repositório local.
      return addressRecentList ?? []; // Retorna a lista ou uma lista vazia se não houver endereços recentes.
    } catch (ex) {
      debugPrint('HomeService.getAddressRecentList -> ${ex.toString()}'); // Imprime o erro no console em caso de falha.
      rethrow; // Propaga o erro.
    }
  }

  Future<void> updateAddressRecentList(AddressModel address) async { // Função para atualizar a lista de endereços recentes.
    await _localRepository.addAddressRecent(address); // Adiciona o endereço à lista de recentes no repositório local.
  }

  Future<List<AddressModel>> getAddressHistoryList() async { // Função para obter a lista de histórico de endereços.
    try {
      final addressHistoryList = await _localRepository.getAddressHistory(); // Obtém a lista de histórico do repositório local.
      return addressHistoryList ?? []; // Retorna a lista ou uma lista vazia se não houver histórico de endereços.
    } catch (ex) {
      debugPrint('HomeService.getAddressHistoryList -> ${ex.toString()}'); // Imprime o erro no console em caso de falha.
      rethrow; // Propaga o erro.
    }
  }

  Future<void> incrementAddressHistoryList(AddressModel address) async { // Função para adicionar um endereço ao histórico.
    await _localRepository.addAddressHistory(address); // Adiciona o endereço à lista de histórico no repositório local.
  }

  Future<void> openMap(BuildContext context, String address) async { // Função para abrir o aplicativo de mapas com um endereço específico.
    try {
      final location = await getGeoLocation(address); // Obtém as coordenadas geográficas do endereço.

      final latitude = location?["latitude"] ?? 0; // Extrai a latitude das coordenadas.
      final longitude = location?["longitude"] ?? 0; // Extrai a longitude das coordenadas.

      final availableMaps = await MapLauncher.installedMaps; // Obtém a lista de aplicativos de mapas instalados.

      if (availableMaps.isNotEmpty) { // Verifica se há algum aplicativo de mapas instalado.
        await availableMaps.first.showDirections(
          destinationTitle: 'Destino', // Define o título do destino.
          destination: Coords(latitude, longitude), // Define as coordenadas do destino.
        ); // Abre o primeiro aplicativo de mapas da lista com as direções para o endereço.
      }
    } catch (ex) {
      rethrow; // Propaga o erro.
    }
  }

  Future<Map<String, double>?> getGeoLocation(String address) async { // Função para obter as coordenadas geográficas de um endereço.
    final locations = await locationFromAddress(address); // Converte o endereço em coordenadas usando o pacote Geocoding.

    return {
      "latitude": locations.first.latitude, // Retorna a latitude da primeira localização encontrada.
      "longitude": locations.first.longitude, // Retorna a longitude da primeira localização encontrada.
    }; // Retorna um mapa contendo a latitude e longitude do endereço.
  }
}