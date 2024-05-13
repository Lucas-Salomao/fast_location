import 'package:fast_location/src/modules/history/page/history_page.dart';
import 'package:fast_location/src/modules/home/page/home_page.dart';
import 'package:fast_location/src/modules/initial/page/initial_page.dart';
import 'package:fast_location/src/routes/app_router.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/colors/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Location',
      theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(
            // Define o esquema de cores
            seedColor: AppColors.appThemeColor, // Cor base do tema
            brightness: Brightness.light,
          ) // Define o brilho do tema (claro)
          ),
      home: const InitialPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRouter.home: (_) => const HomePage(),
        AppRouter.history: (_) => const HistoryPage(),
      },
    );
  }
}*/

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Fornece o modelo de tema para todo o aplicativo
    return ChangeNotifierProvider(
      create: (context) => ThemeModel(), // Cria uma instância do modelo de tema
      child: Consumer<ThemeModel>( // Permite que widgets acessem o modelo de tema
        builder: (context, themeModel, child) {
          // Constrói o MaterialApp com o tema atual
          return MaterialApp(
            title: 'Fast Location', // Título do aplicativo
            // Tema claro
            theme: ThemeData(
              useMaterial3: false, // Desativa o Material Design 3
              colorScheme: ColorScheme.fromSeed( // Define o esquema de cores
                seedColor: AppColors.appThemeColor, // Cor base do tema
                brightness: Brightness.light, // Brilho claro
              ),
            ),
            // Tema escuro
            darkTheme: ThemeData(
              useMaterial3: false, // Desativa o Material Design 3
              colorScheme: ColorScheme.fromSeed( // Define o esquema de cores
                seedColor: AppColors.appThemeColor, // Cor base do tema
                brightness: Brightness.dark, // Brilho escuro
              ),
            ),
            themeMode: themeModel.currentTheme, // Define o modo de tema atual (claro/escuro)
            home: const InitialPage(), // Tela inicial do aplicativo
            debugShowCheckedModeBanner: false, // Oculta a faixa de modo de depuração
            // Rotas nomeadas para navegação
            routes: {
              AppRouter.home: (_) => const HomePage(), // Rota para a tela inicial
              AppRouter.history: (_) => const HistoryPage(), // Rota para a tela de histórico
            },
          );
        },
      ),
    );
  }
}