import 'dart:convert'; // Importa a biblioteca para conversão de dados JSON.
import 'package:fast_location/src/modules/home/model/address_model.dart'; // Importa o modelo de endereço.
import 'package:hive/hive.dart'; // Importa o Hive para armazenamento local de dados.

class HomeLocalRepository { // Define o repositório local para a tela inicial.
  final String boxAddressHistory = 'addressHistory'; // Define o nome da caixa para histórico de endereços.
  final String boxAddressRecent = 'addressRecent'; // Define o nome da caixa para endereços recentes.
  late Box<String> addressBox; // Define a caixa para armazenar endereços.

  Future<void> addAddressHistory(AddressModel address) async { // Função para adicionar um endereço ao histórico.
    addressBox = await Hive.openBox(boxAddressHistory); // Abre a caixa de histórico de endereços.

    List<AddressModel> addressList = await getAddressHistory() ?? []; // Obtém a lista de histórico de endereços existente ou cria uma lista vazia.

    addressList.add(address); // Adiciona o endereço à lista.

    final localAddressList = jsonEncode(addressList.reversed.toList()); // Converte a lista de endereços para JSON e inverte a ordem.
    await addressBox.put(boxAddressHistory, localAddressList); // Salva a lista de endereços na caixa de histórico.
  }

  Future<void> addAddressRecent(AddressModel address) async { // Função para adicionar um endereço aos recentes.
    addressBox = await Hive.openBox(boxAddressRecent); // Abre a caixa de endereços recentes.

    List<AddressModel> addressList = await getAddressRecent() ?? []; // Obtém a lista de endereços recentes existente ou cria uma lista vazia.

    if (addressList.length >= 3) { // Limita a lista de recentes a 3 endereços.
      addressList.removeAt(0); // Remove o endereço mais antigo se a lista tiver mais de 3 endereços.
    }
    addressList.add(address); // Adiciona o endereço à lista.

    final localAddressList = jsonEncode(addressList.reversed.toList()); // Converte a lista de endereços para JSON e inverte a ordem.
    await addressBox.put(boxAddressRecent, localAddressList); // Salva a lista de endereços na caixa de recentes.
  }

  Future<List<AddressModel>?> getAddressHistory() async { // Função para obter o histórico de endereços.
    addressBox = await Hive.openBox(boxAddressHistory); // Abre a caixa de histórico de endereços.
    final localData = addressBox.get(boxAddressHistory); // Obtém os dados da caixa de histórico.

    if (localData != null) { // Verifica se existem dados na caixa.
      List<dynamic> localList = jsonDecode(localData); // Converte os dados JSON para uma lista.
      List<AddressModel> addressList =
      localList.map((data) => AddressModel.fromJsonLocal(data)).toList(); // Converte a lista de dados em uma lista de objetos AddressModel.
      return addressList; // Retorna a lista de endereços.
    } else {
      return null; // Retorna nulo se não houver dados na caixa.
    }
  }

  Future<List<AddressModel>?> getAddressRecent() async { // Função para obter os endereços recentes.
    addressBox = await Hive.openBox(boxAddressRecent); // Abre a caixa de endereços recentes.
    final localData = addressBox.get(boxAddressRecent); // Obtém os dados da caixa de recentes.

    if (localData != null) { // Verifica se existem dados na caixa.
      List<dynamic> localList = jsonDecode(localData); // Converte os dados JSON para uma lista.
      List<AddressModel> addressList =
      localList.map((data) => AddressModel.fromJsonLocal(data)).toList(); // Converte a lista de dados em uma lista de objetos AddressModel.
      return addressList; // Retorna a lista de endereços.
    } else {
      return null; // Retorna nulo se não houver dados na caixa.
    }
  }
}