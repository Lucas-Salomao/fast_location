import 'dart:async'; // Importa a biblioteca para trabalhar com temporizadores.
import 'package:fast_location/src/routes/app_router.dart'; // Importa o roteador da aplicação.
import 'package:flutter/material.dart'; // Importa o framework Flutter para desenvolvimento de interface.

// Define o widget da página inicial.
class InitialPage extends StatefulWidget {
  const InitialPage({super.key}); // Construtor da classe.

  @override
  State<InitialPage> createState() => _InitialPageState(); // Cria o estado da página.
}

// Define o estado da página inicial.
class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin { // Usa o mixin para animações.

  // Define o controlador da animação.
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2), // Define a duração da animação para 2 segundos.
    vsync: this, // Define o sincronizador para a animação.
  )..repeat(reverse: true); // Inicia a animação com repetição e reversão.

  // Define a animação com base no controlador e curva de animação.
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller, // Define o controlador da animação.
    curve: Curves.elasticInOut, // Define a curva de animação para elasticInOut.
  );

  @override
  void initState() {
    super.initState(); // Chama o método initState da classe pai.
    redirect(); // Chama o método para redirecionar após 3 segundos.
  }

  // Define o método para redirecionar para a página home após 3 segundos.
  void redirect() {
    Timer(const Duration(seconds: 3), () {
      // Navega para a rota 'home' definida no AppRouter, substituindo a página atual.
      Navigator.of(context).pushReplacementNamed(AppRouter.home);
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controlador da animação quando o widget é descartado.
    super.dispose(); // Chama o método dispose da classe pai.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Define o widget Scaffold para a estrutura básica da página.
      backgroundColor: Theme.of(context).colorScheme.primary, // Define a cor de fundo da página.
      body: SafeArea( // Define a área segura para o conteúdo da página.
        child: Center( // Centraliza o conteúdo da página.
          child: Column( // Define uma coluna para organizar os widgets.
            mainAxisSize: MainAxisSize.max, // Define o tamanho da coluna para o máximo possível.
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza os widgets verticalmente.
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os widgets horizontalmente.
            children: [ // Define a lista de widgets dentro da coluna.
              Padding( // Define o espaçamento interno em torno do texto.
                padding: EdgeInsets.only(bottom: 10), // Define o espaçamento inferior de 10 pixels.
                child: Text( // Define o widget de texto.
                  "Fast Location", // Define o texto a ser exibido.
                  style: TextStyle( // Define o estilo do texto.
                    color: Theme.of(context).colorScheme.onPrimary, // Define a cor do texto.
                    fontSize: 40, // Define o tamanho da fonte do texto.
                    fontWeight: FontWeight.bold, // Define o peso da fonte do texto como negrito.
                  ),
                ),
              ),
              RotationTransition( // Define o widget para animar a rotação do ícone.
                turns: _animation, // Define a animação de rotação.
                child: Padding( // Define o espaçamento interno em torno do ícone.
                  padding: EdgeInsets.all(8), // Define o espaçamento de 8 pixels em todos os lados.
                  child: Icon( // Define o widget de ícone.
                    size: 150, // Define o tamanho do ícone.
                    color: Theme.of(context).colorScheme.onPrimary, // Define a cor do ícone.
                    Icons.swap_horiz, // Define o ícone a ser exibido.
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}