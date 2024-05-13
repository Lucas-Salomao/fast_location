import 'package:flutter/material.dart';

// Widget que exibe uma mensagem quando a busca não retorna resultados.
class SearchEmpty extends StatelessWidget {
  const SearchEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna uma coluna com um ícone e uma mensagem.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ícone de direções.
        Icon(
          Icons.directions,
          size: 80,
          // Cor do ícone definida com base no tema do aplicativo.
          color: Theme.of(context).colorScheme.primary,
        ),
        // Mensagem para o usuário.
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Faça uma busca para localizar seu destino",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}