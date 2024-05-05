import 'package:flutter/material.dart'; // Importa a biblioteca Material Design para widgets e temas
import 'package:flutter/services.dart'; // Importa serviços para controlar a entrada de texto
import 'package:fast_location/http/dio.dart'; // Importa biblioteca para fazer requisições HTTP

class MyHomePage extends StatefulWidget { // Define um widget de página inicial com estado
  const MyHomePage({super.key, required this.title});

  final String title; // Título da página recebido como parâmetro

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Cria o estado da página
}

class _MyHomePageState extends State<MyHomePage> {
  void onPressed_Localizar() { // Função chamada ao pressionar o botão "Localizar Endereço"
    showDialog( // Exibe um diálogo modal
      context: context,
      builder: (BuildContext context) { // Constrói o conteúdo do diálogo
        final cepController = TextEditingController(); // Controlador de texto para o campo de CEP
        return AlertDialog( // Widget para o diálogo de alerta
          title: Text('Digite o CEP'), // Título do diálogo
          content: TextField( // Campo de texto para digitar o CEP
            controller: cepController, // Vincula o controlador ao campo de texto
            keyboardType: TextInputType.number, // Define o teclado numérico
            inputFormatters: [ // Formatadores de entrada
              FilteringTextInputFormatter.digitsOnly, // Permite apenas dígitos
            ],
          ),
          actions: [ // Botões de ação do diálogo
            FilledButton( // Botão "Buscar"
              onPressed: () async { // Função assíncrona para buscar o endereço
                String cep = cepController.text; // Obtém o CEP digitado
                final cepData = await CepLookup.getEnderecoPorCep(cep); // Busca o endereço usando o CEP
                if (cepData != null) { // Verifica se a busca foi bem-sucedida
                  // Processa os dados do endereço (cepData)
                  print(cepData); // Exemplo: imprime os dados no console
                } else {
                  // Lida com erros (exibe mensagem de erro)
                  print('Erro ao buscar o CEP');
                }
                Navigator.pop(context); // Fecha o diálogo modal
              },
              child: Text('Buscar'), // Texto do botão
            ),
          ],
        );
      },
    );
  }

  void onPressed() {} // Função vazia (provavelmente para o botão "Histórico")

  @override
  Widget build(BuildContext context) { // Constrói a interface da página
    return Scaffold( // Estrutura básica da página
      appBar: AppBar( // Barra superior da página
        // Configuração da AppBar (título, cor, etc.)
      ),
      body: Center( // Centraliza o conteúdo da página
        child: Container( // Container para organizar os elementos
          color: Theme.of(context).colorScheme.background, // Cor de fundo
          child: Column( // Coluna para organizar os elementos verticalmente
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaçamento entre elementos
            children: <Widget>[
              Row( // Linha para organizar o ícone e texto do título
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos horizontalmente
                children: [
                  Icon(Icons.swap_horiz, // Ícone de troca horizontal
                      size: 50, color: Theme.of(context).colorScheme.primary), // Estilo do ícone
                  Text( // Texto "Fast Location"
                    'Fast Location',
                    style: TextStyle( // Estilo do texto
                        fontStyle: FontStyle.italic,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              Container( // Container para o ícone e texto de instrução
                color: Theme.of(context).colorScheme.surfaceVariant, // Cor de fundo
                height: 200, // Altura do container
                width: 350, // Largura do container
                child: Column( // Coluna para organizar o ícone e texto
                  children: [
                    Icon( // Ícone de direções
                      Icons.directions,
                      color: Theme.of(context).colorScheme.primary,
                      size: 100,
                    ),
                    const Text( // Texto de instrução
                      'Faça uma busca para localizar seu destino',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Spacer(), // Espaçador flexível
              SizedBox( // Container com largura definida para o botão
                width: 350.0,
                child: FilledButton( // Botão "Localizar Endereço"
                  onPressed: onPressed_Localizar, // Chama a função de busca
                  child: const Text('Localizar Endereço'),
                ),
              ),
              Spacer(), // Espaçador flexível
              SizedBox( // Container com largura definida para o texto
                width: 350.0,
                child: Row( // Linha para o ícone e texto de endereços recentes
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text('Últimos endereços localizados', // Texto de endereços recentes
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Spacer(), // Espaçador flexível
              Container( // Container para a mensagem de "Não há locais recentes"
                color: Colors.white,
                height: 200,
                width: 350,
                child: Column(
                  children: [
                    Icon(
                      Icons.location_off,
                      color: Theme.of(context).colorScheme.primary,
                      size: 50,
                    ),
                    Text("Não há locais recentes", // Mensagem de locais recentes
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Spacer(), // Espaçador flexível
              SizedBox( // Container com largura definida para o botão
                width: 350.0,
                child: FilledButton( // Botão "Histórico de Endereços"
                  onPressed: onPressed, // Chama a função onPressed (ainda vazia)
                  child: const Text('Histórico de Endereços'),
                ),
              ),
              Spacer(), // Espaçador flexível
              IconButton.filled( // Botão com ícone de bifurcação
                onPressed: onPressed, // Chama a função onPressed (ainda vazia)
                icon: Icon(Icons.fork_right),
                iconSize: 50,
              ),
              Spacer(), // Espaçador flexível
            ],
          ),
        ),
      ),
    );
  }
}
