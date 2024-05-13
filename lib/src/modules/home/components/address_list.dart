import 'package:fast_location/src/modules/home/model/address_model.dart'; // Importa o modelo de endereço.
import 'package:flutter/material.dart'; // Importa o pacote Flutter para desenvolvimento de interface.

// Define o Widget com estado para a lista de endereços.
class AddressList extends StatefulWidget {
  final List<AddressModel> addressList; // Define a lista de endereços como uma propriedade.

  const AddressList({
    super.key,
    required this.addressList, // Define a lista de endereços como um parâmetro obrigatório.
  });

  @override
  State<AddressList> createState() => _AddressListState(); // Cria o estado do Widget.
}

// Define a classe de estado do Widget AddressList.
class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    return Column( // Retorna uma coluna como o Widget principal.
      crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos da coluna à esquerda.
      children: [ // Define os elementos da coluna.
        DecoratedBox( // Define um Widget decorado.
          decoration: BoxDecoration( // Define a decoração do Widget.
            color: Theme.of(context).colorScheme.onInverseSurface, // Define a cor de fundo do Widget.
            borderRadius: BorderRadius.all(Radius.circular(10)), // Define o raio das bordas do Widget.
          ),
          child: widget.addressList.isEmpty // Verifica se a lista de endereços está vazia.
              ? _addressListEmpty() // Se estiver vazia, exibe o Widget _addressListEmpty().
              : ListView.separated( // Se não estiver vazia, exibe o Widget ListView.separated().
            shrinkWrap: true, // Define se o ListView deve se ajustar ao conteúdo.
            physics: const NeverScrollableScrollPhysics(), // Define a física de rolagem do ListView.
            itemBuilder: (context, index) { // Define o construtor de cada item da lista.
              return _addressItem(widget.addressList[index]); // Exibe o Widget _addressItem() para cada endereço da lista.
            },
            separatorBuilder: (BuildContext context, int index) => // Define o construtor de separadores entre os itens da lista.
            const Divider(height: 1), // Define um divisor com altura 1 como separador.
            itemCount: widget.addressList.length, // Define o número de itens da lista.
          ),
        ),
      ],
    );
  }

  // Define um Widget para exibir quando a lista de endereços estiver vazia.
  Widget _addressListEmpty() {
    return Padding( // Define o espaçamento interno do Widget.
      padding: const EdgeInsets.all(30.0), // Define o espaçamento interno em todos os lados.
      child: SizedBox( // Define um Widget com tamanho fixo.
        width: MediaQuery.of(context).size.width, // Define a largura do Widget como a largura da tela.
        child: Column( // Define uma coluna dentro do SizedBox.
          crossAxisAlignment: CrossAxisAlignment.center, // Alinha os elementos da coluna no centro horizontalmente.
          children: [ // Define os elementos da coluna.
            Icon( // Define um ícone.
              Icons.location_off, // Define o ícone de localização desativada.
              size: 40, // Define o tamanho do ícone.
              color: Theme.of(context).colorScheme.primary, // Define a cor do ícone.
            ),
            Padding( // Define o espaçamento interno do texto.
              padding: EdgeInsets.all(10.0), // Define o espaçamento interno em todos os lados.
              child: Text( // Define um texto.
                "Não há locais recentes", // Define o texto a ser exibido.
                textAlign: TextAlign.center, // Define o alinhamento do texto como centralizado.
                style: TextStyle( // Define o estilo do texto.
                  fontSize: 18, // Define o tamanho da fonte.
                  fontWeight: FontWeight.bold, // Define a espessura da fonte como negrito.
                  color: Theme.of(context).colorScheme.onSurface, // Define a cor do texto.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Define um Widget para exibir cada item da lista de endereços.
  Widget _addressItem(AddressModel address) { // Recebe um objeto AddressModel como parâmetro.
    return Padding( // Define o espaçamento interno do Widget.
      padding: const EdgeInsets.all(10.0), // Define o espaçamento interno em todos os lados.
      child: Row( // Define uma linha para exibir as informações do endereço.
        mainAxisSize: MainAxisSize.max, // Define o tamanho da linha como o máximo possível.
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Define o alinhamento dos elementos da linha como espaçado igualmente.
        children: [ // Define os elementos da linha.
          Row( // Define uma linha para o ícone e as informações do endereço.
            children: [ // Define os elementos da linha.
              Icon( // Define um ícone.
                Icons.place, // Define o ícone de local.
                color: Theme.of(context).colorScheme.primary, // Define a cor do ícone.
                size: 30, // Define o tamanho do ícone.
              ),
              Padding( // Define o espaçamento interno das informações do endereço.
                padding: const EdgeInsets.only(left: 5), // Define o espaçamento interno à esquerda.
                child: Column( // Define uma coluna para as informações do endereço.
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos da coluna à esquerda.
                  children: [ // Define os elementos da coluna.
                    Text( // Define um texto para o bairro.
                      address.neighborhood, // Define o texto como o bairro do endereço.
                      style: const TextStyle( // Define o estilo do texto.
                        fontSize: 15, // Define o tamanho da fonte.
                        fontWeight: FontWeight.bold, // Define a espessura da fonte como negrito.
                      ),
                    ),
                    Text( // Define um texto para o logradouro.
                      address.publicPlace, // Define o texto como o logradouro do endereço.
                      style: const TextStyle( // Define o estilo do texto.
                        fontSize: 12, // Define o tamanho da fonte.
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Column( // Define uma coluna para a cidade, estado e CEP.
            crossAxisAlignment: CrossAxisAlignment.end, // Alinha os elementos da coluna à direita.
            children: [ // Define os elementos da coluna.
              Text( // Define um texto para a cidade e estado.
                '${address.city}, ${address.state}', // Define o texto como a cidade e estado do endereço.
                style: const TextStyle( // Define o estilo do texto.
                  fontSize: 15, // Define o tamanho da fonte.
                  fontWeight: FontWeight.bold, // Define a espessura da fonte como negrito.
                ),
              ),
              const SizedBox( // Define um espaçamento vertical.
                height: 5, // Define a altura do espaçamento.
              ),
              Text( // Define um texto para o CEP.
                address.cep, // Define o texto como o CEP do endereço.
                style: const TextStyle( // Define o estilo do texto.
                  fontSize: 12, // Define o tamanho da fonte.
                  fontWeight: FontWeight.bold, // Define a espessura da fonte como negrito.
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}