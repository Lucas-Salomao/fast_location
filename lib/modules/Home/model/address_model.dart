class AddressModel {
  // CEP do endereço (CEP = Código de Endereçamento Postal)
  late String cep;

  // Nome do logradouro (rua, avenida, etc.)
  late String publicPlace;

  // Complemento do endereço (opcional)
  late String? complement;

  // Bairro do endereço
  late String neighborhood;

  // Cidade do endereço
  late String city;

  // Estado do endereço
  late String state;

  // Construtor principal que recebe todos os dados obrigatórios
  AddressModel({
    required this.cep,
    required this.publicPlace,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  // Construtor que converte um Map<String, dynamic> para um AddressModel
  // Esperando chaves específicas para dados do endereço
  AddressModel.fromJson(Map<String, dynamic> json) {
    cep = json["cep"];
    publicPlace = json["logradouro"];
    complement = json["complemento"] ?? ''; // Atribui vazio se "complemento" não existir
    neighborhood = json["bairro"];
    city = json["localidade"];
    state = json["uf"];
  }

  // Construtor alternativo que converte um Map<String, dynamic> para um AddressModel
  // Esperando chaves possivelmente diferentes para dados do endereço
  AddressModel.fromJsonLocal(Map<String, dynamic> json) {
    cep = json["cep"];
    publicPlace = json["publicPlace"]; // "publicPlace" ao invés de "logradouro"
    complement = json["complement"] ?? ''; // Atribui vazio se "complemento" não existir
    neighborhood = json["neighborhood"]; // "neighborhood" ao invés de "bairro"
    city = json["city"]; // "city" ao invés de "localidade"
    state = json["state"]; // "state" ao invés de "uf"
  }

  // Converte o AddressModel para um Map<String, dynamic>
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["cep"] = cep;
    json["publicPlace"] = publicPlace;
    json["complement"] = complement;
    json["neighborhood"] = neighborhood;
    json["city"] = city;
    json["state"] = state;

    return json;
  }
}
