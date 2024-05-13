import 'package:flutter/cupertino.dart'; // Importa o pacote Cupertino para widgets iOS.
import 'package:flutter/material.dart'; // Importa o pacote Material Design para widgets Android.
import 'package:flutter_mobx/flutter_mobx.dart'; // Importa o pacote para conectar o MobX ao Flutter.
import 'package:fast_location/src/modules/home/components/address_list.dart'; // Importa o componente da lista de endereços.
import 'package:fast_location/src/modules/home/components/search_address.dart'; // Importa o componente de pesquisa de endereços.
import 'package:fast_location/src/modules/home/components/search_empty.dart'; // Importa o componente para quando a pesquisa estiver vazia.
import 'package:fast_location/src/modules/home/controller/home_controller.dart'; // Importa o controlador da tela inicial.
import 'package:fast_location/src/routes/app_router.dart'; // Importa o roteador do aplicativo.
import 'package:fast_location/src/shared/components/app_button.dart'; // Importa o componente do botão do app.
import 'package:fast_location/src/shared/components/app_loading.dart'; // Importa o componente de carregamento do app.
import 'package:mobx/mobx.dart'; // Importa o MobX para gerenciamento de estado.
import 'package:provider/provider.dart'; // Importa o Provider para gerenciamento de estado.
import '../../../shared/colors/change_theme.dart'; // Importa o tamanho da barra de navegação
import '../../../shared/metrics/app_metrics.dart'; // Importa o gerenciador de temas.

class HomePage extends StatefulWidget { // Define a tela inicial como um widget com estado.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState(); // Cria o estado da tela inicial.
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController(); // Instancia o controlador da tela inicial.
  TextEditingController searchController = TextEditingController(); // Controlador para o campo de texto de pesquisa.
  late ReactionDisposer errorReactionDiposer; // Gerencia a reação a erros de endereço.
  late ReactionDisposer errorRouteReactionDiposer; // Gerencia a reação a erros de rota.

  @override
  void initState() {
    super.initState();
    _controller.loadData(); // Carrega os dados iniciais ao iniciar a tela.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reactsToError(); // Configura a reação a erros de endereço.
    reactsToRouteError(); // Configura a reação a erros de rota.
  }

  @override
  void dispose() {
    searchController.dispose(); // Libera o controlador do campo de texto ao descartar a tela.
    errorReactionDiposer(); // Libera a reação a erros de endereço.
    errorRouteReactionDiposer(); // Libera a reação a erros de rota.
    super.dispose();
  }

  void reactsToError() {
    errorReactionDiposer = reaction((_) => _controller.hasError, (
        bool error,
        ) {
      if (error) openDialog("Endereço não localizado"); // Abre um diálogo se houver um erro de endereço.
      _controller.hasError = false; // Reseta o estado de erro.
    });
  }

  void reactsToRouteError() {
    errorRouteReactionDiposer = reaction((_) => _controller.hasRouteError, (
        bool routeError,
        ) {
      if (routeError) {
        openDialog(
          "Busque um endereço para traçar sua rota", // Abre um diálogo se houver um erro de rota.
          height: 120,
        );
      }
      _controller.hasRouteError = false; // Reseta o estado de erro de rota.
    });
  }

  void openDialog(String message, {double? height}) {
    showDialog( // Abre um diálogo de alerta.
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: height ?? 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    message, // Exibe a mensagem de erro.
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppButton(
                  label: "Fechar",
                  action: () {
                    Navigator.of(context).pop(); // Fecha o diálogo.
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) { // Observa as mudanças no estado.
      return _controller.isLoading
          ? const AppLoading() // Exibe um indicador de carregamento enquanto os dados estão sendo carregados.
          : Scaffold( // Define a estrutura da tela.
        backgroundColor: Theme.of(context).colorScheme.background, // Define a cor de fundo da tela.
        body: SingleChildScrollView( // Permite rolagem do conteúdo.
          child: SafeArea( // Define a área segura para o conteúdo, evitando sobreposição com a barra de status.
            child: Center( // Centraliza o conteúdo horizontalmente.
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25), // Define o espaçamento horizontal.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Alinha os elementos ao centro horizontalmente.
                  children: [
                    const SizedBox(height: 30), // Espaçamento vertical.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Alinha os elementos ao centro horizontalmente.
                      children: [
                        Icon(
                          Icons.swap_horiz, // Ícone de troca.
                          size: 35,
                        ),
                        SizedBox(width: 10), // Espaçamento horizontal.
                        Text(
                          "Fast Location", // Título do aplicativo.
                          style: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Espaçamento vertical.
                    Container(
                      width: double.infinity, // Define a largura como infinita para ocupar todo o espaço disponível.
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onInverseSurface, // Define a cor de fundo do container.
                        borderRadius: BorderRadius.circular(10), // Define o raio das bordas do container.
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0), // Define o espaçamento interno do container.
                        child: _controller.hasAddress
                            ? SearchAddress(
                          address: _controller.lastAddress!,
                        ) // Exibe o componente de pesquisa de endereços se houver um endereço.
                            : const SearchEmpty(), // Exibe o componente de pesquisa vazia se não houver um endereço.
                      ),
                    ),
                    const SizedBox(height: 20), // Espaçamento vertical.
                    AppButton(
                      label: "Localizar endereço",
                      action: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: searchController,
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: "Digite o CEP",
                                      ),
                                    ),
                                    AppButton(
                                      label: "Buscar",
                                      action: () {
                                        _controller.getAddress(
                                          searchController.text,
                                        ); // Busca o endereço a partir do CEP digitado.
                                        Navigator.of(context).pop(); // Fecha o diálogo.
                                        searchController.clear(); // Limpa o campo de texto.
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20), // Espaçamento vertical.
                    Row(
                      children: [
                        Icon(Icons.place,
                            color: Theme.of(context).colorScheme.primary), // Ícone de local.
                        SizedBox(width: 5), // Espaçamento horizontal.
                        Text(
                          "Últimos endereços localizados",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                              Theme.of(context).colorScheme.primary), // Define o estilo do texto.
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Espaçamento vertical.
                    AddressList(
                      addressList: _controller.addressRecentList, // Exibe a lista de endereços recentes.
                    ),
                    const SizedBox(height: 20), // Espaçamento vertical.
                    AppButton(
                      label: "Histórico de endereços",
                      action: () {
                        Navigator.of(context)
                            .pushNamed(AppRouter.history); // Navega para a tela de histórico de endereços.
                      },
                    ),
                    const SizedBox(height: 40), // Espaçamento vertical.
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar( // Define a barra de navegação inferior.
          shape: const CircularNotchedRectangle(), // Define o formato da barra de navegação.
          child: Container(
            height: AppMetrics.barHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribui os elementos com espaçamento uniforme.
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<ThemeModel>(context, listen: false)
                        .setLightTheme(); // Define o tema claro.
                  },
                  icon: Icon(Icons.light_mode), // Ícone de tema claro.
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ThemeModel>(context, listen: false)
                        .setDarkTheme(); // Define o tema escuro.
                  },
                  icon: Icon(Icons.dark_mode), // Ícone de tema escuro.
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked, // Define a posição do botão flutuante.
        floatingActionButton: FloatingActionButton(
          onPressed: () => _controller.route(context), // Define a ação do botão flutuante, que é traçar uma rota.
          tooltip: 'Traçar rota',
          child: const Icon(
            Icons.fork_right, // Ícone de rota.
            size: 45,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary, // Define a cor de fundo do botão flutuante.
        ),
      );
    });
  }
}