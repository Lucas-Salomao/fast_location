// Modelo que representa um endereço.
class AddressModel {
  // CEP do endereço.
  late String cep;
  // Logradouro do endereço.
  late String publicPlace;
  // Complemento do endereço (opcional).
  late String? complement;
  // Bairro do endereço.
  late String neighborhood;
  // Cidade do endereço.
  late String city;
  // Estado do endereço.
  late String state;

  // Construtor da classe.
  AddressModel({
    required this.cep,
    required this.publicPlace,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  // Construtor que cria um objeto AddressModel a partir de um mapa JSON.
  AddressModel.fromJson(Map<String, dynamic> json)
      : cep = json["cep"],
        publicPlace = json["logradouro"],
        complement = json["complemento"] ?? '', // Define como vazio se não houver complemento
        neighborhood = json["bairro"],
        city = json["localidade"],
        state = json["uf"];

  // Construtor que cria um objeto AddressModel a partir de um mapa JSON com nomes de chaves em inglês.
  AddressModel.fromJsonLocal(Map<String, dynamic> json)
      : cep = json["cep"],
        publicPlace = json["publicPlace"],
        complement = json["complement"] ?? '', // Define como vazio se não houver complemento
        neighborhood = json["neighborhood"],
        city = json["city"],
        state = json["state"];

  // Converte um objeto AddressModel para um mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      "cep": cep,
      "publicPlace": publicPlace,
      "complement": complement,
      "neighborhood": neighborhood,
      "city": city,
      "state": state,
    };
  }
}
