import 'package:fast_location/src/app.dart';
import 'package:fast_location/src/shared/colors/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:fast_location/src/shared/storage/hive_configuration.dart';
import 'package:provider/provider.dart';

// Função principal que inicia a aplicação
void main() {
  // Garante que o Flutter esteja inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o banco de dados Hive e, em seguida, executa o aplicativo
  HiveConfiguration.initHiveDatabase().then((_) {
    const myApp = MyApp(); // Cria a instância do aplicativo
    runApp( // Executa o aplicativo fornecido como argumento
      ChangeNotifierProvider( // Fornece o modelo de tema para todo o aplicativo
        create: (context) => ThemeModel(), // Cria uma instância do modelo de tema
        child: myApp, // Define o aplicativo como filho do ChangeNotifierProvider
      ),
    );
  });
}