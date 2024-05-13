import 'package:flutter/material.dart'; // Importa o pacote Flutter para desenvolvimento de interface.
import 'package:flutter_mobx/flutter_mobx.dart'; // Importa o pacote para integração com MobX para gerenciamento de estado.
import 'package:fast_location/src/modules/history/controller/history_controller.dart'; // Importa o controlador da página de histórico.
import 'package:fast_location/src/modules/home/components/address_list.dart'; // Importa o componente da lista de endereços.
import 'package:fast_location/src/shared/components/app_loading.dart'; // Importa o componente de carregamento.

// Define o Widget com estado da página de histórico.
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState(); // Cria o estado da página.
}

// Define a classe do estado da página de histórico.
class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _controller = HistoryController(); // Instancia o controlador.

  @override
  void initState() {
    super.initState();
    _controller.loadData(); // Carrega os dados do histórico ao iniciar a página.
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) { // Observa o estado do controlador.
      return _controller.isLoading // Verifica se está carregando.
          ? const AppLoading() // Exibe o componente de carregamento se estiver carregando.
          : Scaffold( // Caso contrário, exibe a estrutura da página.
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.background, // Define a cor de fundo da AppBar.
          elevation: 0, // Define a elevação da AppBar como 0.
          leading: IconButton( // Define o botão de voltar na AppBar.
            icon: const Icon(
              Icons.arrow_back, // Define o ícone de seta para trás.
            ),
            onPressed: () => Navigator.pop(context), // Define a ação de voltar à página anterior.
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background, // Define a cor de fundo da página.
        body: SingleChildScrollView( // Permite rolagem na página.
          child: SafeArea( // Define uma área segura para o conteúdo.
            child: Center( // Centraliza o conteúdo horizontalmente.
              child: Padding( // Define o espaçamento interno.
                padding: const EdgeInsets.symmetric(
                  horizontal: 25, // Define o espaçamento horizontal.
                  vertical: 20, // Define o espaçamento vertical.
                ),
                child: Column( // Organiza o conteúdo em uma coluna.
                  crossAxisAlignment: CrossAxisAlignment.center, // Alinha o conteúdo no centro horizontalmente.
                  children: [ // Define os elementos da coluna.
                    const Row( // Define uma linha para o título.
                      mainAxisAlignment: MainAxisAlignment.center, // Alinha os elementos da linha no centro horizontalmente.
                      children: [ // Define os elementos da linha.
                        Icon( // Define o ícone de localização.
                          Icons.share_location, // Define o ícone de compartilhamento de localização.
                          size: 30, // Define o tamanho do ícone.
                        ),
                        SizedBox(width: 10), // Define um espaçamento horizontal.
                        Text( // Define o texto do título.
                          "Endereços Localizados", // Define o texto do título.
                          style: TextStyle( // Define o estilo do texto.
                            fontSize: 25, // Define o tamanho da fonte.
                            fontStyle: FontStyle.italic, // Define o estilo da fonte como itálico.
                            fontWeight: FontWeight.bold, // Define a espessura da fonte como negrito.
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Define um espaçamento vertical.
                    AddressList( // Exibe a lista de endereços.
                      addressList: _controller.addressHistoryList, // Define a lista de endereços do histórico.
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
