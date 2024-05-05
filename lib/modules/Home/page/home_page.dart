import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onPressed_Localizar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final cepController = TextEditingController();
        return AlertDialog(
          title: Text('Digite o CEP'),
          content: TextField(
            controller: cepController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () async {
                String cep = cepController.text;
                String url = 'https://viacep.com.br/ws/$cep/json';

                try {
                  final dio = Dio(); // Create a Dio instance
                  final response = await dio.get(url); // Make a GET request using Dio
                  if (response.statusCode == 200) {
                    // Process the successful response here
                    Map<String, dynamic> data =
                        response.data; // Access the JSON data directly
                    // You can use the extracted data for further processing or display
                    print(data); // For debugging purposes, print the response data
                  } else {
                    // Handle unsuccessful response (e.g., display error message)
                    print('Error: ${response.statusCode}');
                  }
                } catch (error) {
                  // Handle exceptions (e.g., network errors)
                  print('Error: $error');
                }
                Navigator.pop(context); // Close the modal after processing
              },
              child: Text('Buscar'),
            ),
          ],
        );
      },
    );
  }

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          //backgroundColor: Theme.of(context).colorScheme.primary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.swap_horiz,
                      size: 50, color: Theme.of(context).colorScheme.primary),
                  Text(
                    'Fast Location',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                height: 200,
                width: 350,
                child: Column(
                  children: [
                    Icon(
                      Icons.directions,
                      color: Theme.of(context).colorScheme.primary,
                      size: 100,
                    ),
                    const Text(
                      'Faça uma busca para localizar seu destino',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 350.0, // Define a largura do SizedBox
                child: FilledButton(
                  onPressed: onPressed_Localizar,
                  child: const Text('Localizar Endereço'),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 350.0,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text('Últimos endereços localizados',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Spacer(),
              Container(
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
                    Text("Não há locais recentes",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 350.0, // Define a largura do SizedBox
                child: FilledButton(
                  onPressed: onPressed,
                  child: const Text('Histórico de Endereços'),
                ),
              ),
              Spacer(),
              IconButton.filled(
                onPressed: onPressed,
                icon: Icon(Icons.fork_right),
                iconSize: 50,
              ),
              Spacer(),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
