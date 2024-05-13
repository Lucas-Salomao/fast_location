import 'package:flutter/material.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

// Widget que exibe as informações de um endereço.
class SearchAddress extends StatefulWidget {
  // O endereço a ser exibido.
  final AddressModel address;

  // Construtor da classe.
  const SearchAddress({
    super.key,
    required this.address,
  });

  @override
  State<SearchAddress> createState() => _SearchAddressState();
}

// Estado do Widget SearchAddress.
class _SearchAddressState extends State<SearchAddress> {
  @override
  Widget build(BuildContext context) {
    // Retorna um Padding que contém uma coluna com as informações do endereço.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título da seção.
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dados da Localização",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
          const SizedBox(height: 15),
          // Exibe o logradouro/rua.
          _buildRow("Logradouro/Rua:", widget.address.publicPlace),
          // Exibe o bairro/distrito.
          _buildRow("Bairro/Distrito:", widget.address.neighborhood),
          // Exibe o complemento, se houver.
          if (widget.address.complement != null && widget.address.complement!.isNotEmpty) // Adicionando um null check
            _buildRow("Complemento:", widget.address.complement!),
          // Exibe a cidade/UF.
          _buildRow("Cidade/UF:", '${widget.address.city}/${widget.address.state}'),
          // Exibe o CEP.
          _buildRow("CEP:", widget.address.cep),
        ],
      ),
    );
  }

  // Widget que cria uma linha com um label e um valor.
  Widget _buildRow(String label, String value) {
    // Retorna um Padding que contém uma linha com o label e o valor.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Label da linha.
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          // Valor da linha.
          Text(value),
        ],
      ),
    );
  }
}