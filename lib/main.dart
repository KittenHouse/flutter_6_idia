import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Home(),
        '/idea': (context) => const Idea(),
      },
      initialRoute: '/',
    ),
  );
}

class InformationIdea {
  String valueIdea;
  int indexIdea;
  Function editedIdea;

  InformationIdea({
    required this.valueIdea,
    required this.indexIdea,
    required this.editedIdea,
  });
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> listIdeas = [];
  final _inputController = TextEditingController();

  void addIdea(String idea) {
    setState(() {
      if (!listIdeas.contains(_inputController.text)) {
        listIdeas.add(_inputController.text);
        _inputController.clear();
      }
    });
  }

  void editedIdea(String newIdea, int indexIdea) {
    setState(() {
      listIdeas[indexIdea] = newIdea;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список гениальных идей'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _inputController,
              decoration: const InputDecoration(
                hintText: 'Ваша идея',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onSubmitted: ((value) {
                addIdea(value);
              }),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: listIdeas.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.orangeAccent,
                        title: Text(listIdeas.elementAt(index)),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/idea',
                            arguments: InformationIdea(
                              valueIdea: listIdeas.elementAt(index),
                              indexIdea: index,
                              editedIdea: editedIdea,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Idea extends StatelessWidget {
  const Idea({super.key});

  @override
  Widget build(BuildContext context) {
    var argument =
        ModalRoute.of(context)?.settings.arguments as InformationIdea;

    return Scaffold(
      appBar: AppBar(
        title: Text(argument.valueIdea),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: TextField(
            controller: TextEditingController(text: argument.valueIdea),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            textAlign: TextAlign.center,
            onSubmitted: ((value) {
              argument.editedIdea(value, argument.indexIdea);
              Navigator.of(context).pop();
            }),
          ),
        ),
      ),
    );
  }
}
