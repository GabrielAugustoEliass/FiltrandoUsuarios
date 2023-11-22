import 'package:filtrando_usuarios/controller/user_controller.dart';
import 'package:filtrando_usuarios/model/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = UserController();

  List<UserModel> usuarios = [];

  void pesquisarPorUsuario(String value) {
    if (value.isEmpty) {
      setState(() {
        usuarios.addAll(controller.listaUsuarios);
      });
    } else {
      setState(() {
        final usuariosFiltrados = controller.listaUsuarios
            .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
        controller.listaUsuarios = usuariosFiltrados;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                size: 20,
              ),
            ),
          ),
        ],
        title: const Text(
          'Contatos',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 10,
              bottom: 7,
            ),
            child: TextFormField(
              onChanged: pesquisarPorUsuario,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outlined),
                labelText: 'Pesquisar um usuário',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 7,
              ),
              child: ListView.builder(
                itemCount: controller.listaUsuarios.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      title: Text(
                        controller.listaUsuarios[index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
