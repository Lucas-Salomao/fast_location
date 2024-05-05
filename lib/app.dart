import 'package:flutter/material.dart'; // Importa o pacote base do Flutter para criação de interfaces

import 'modules/Home/page/home_page.dart'; // Importa a página inicial do aplicativo

class MyApp extends StatefulWidget {
  const MyApp({super.key}); // Construtor padrão

  @override
  State<MyApp> createState() => _MyAppState(); // Cria o estado da aplicação
}

class _MyAppState extends State<MyApp> {
  // Esta classe representa o estado do widget MyApp

  // Este widget é a raiz da sua aplicação Flutter
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta o banner de debug do Flutter
      title: 'Fast Location', // Define o título do aplicativo
      theme: ThemeData(
        // Define o tema visual da aplicação
        colorScheme: ColorScheme.fromSeed( // Define o esquema de cores
          seedColor: Colors.green, // Cor base do tema
          brightness: Brightness.light, // Define o brilho do tema (claro)
        ),
        useMaterial3: true, // Habilita o Material Design 3
      ),
      home: const MyHomePage(title: 'Fast Location'), // Define a página inicial
    );
  }
}
