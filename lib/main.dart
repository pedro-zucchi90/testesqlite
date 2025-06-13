import 'package:flutter/material.dart';
import 'dart:io';
import 'package:testesqlite/dao/dogdao.dart';
import 'package:testesqlite/model/dogmodel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();

//Imprime as ocorrências do banco de dados
  debugPrint('Buscando todos os dogs...');
  findAll().then((dados) {
    for (Map<dynamic, dynamic> item in dados) {
      debugPrint('Item: $dados');
    }
  });

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InicialShow(),
    ),
  );
}

class InicialShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo, // Cor da barra superior
        leading: Icon(Icons.pets, color: Colors.white, size: 40.0), 
        title: Text('Lista dos Dog', style: TextStyle(color: Colors.white)), 
      ),
      body: FutureBuilder(
        future: findAll(), 
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());

            case ConnectionState.none:
              return Text('Nenhuma conexão estabelecida');

            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao carregar dogs'));
              }
              List<Map> dogs = snapshot.data as List<Map>;
              if (dogs.isEmpty) {
                return Center(child: Text('Nenhum dog encontrado'));
              }
              return ListView.builder(
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  DogModel dog = DogModel.fromMap(dogs[index]);
                
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Center(
                        child: Card(
                          color: Colors.indigo.shade50,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            title: Text(dog.Nome),
                            subtitle: Text('Idade: ${dog.Idade.toString()}'),
                          ),
                        ),
                      ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}


// class InicialShow extends StatefulWidget {
//   @override
//   State<InicialShow> createState() => _InicialShowState();
//   // Cria o estado associado a InicialShow
// }

// class _InicialShowState extends State<InicialShow> {
//   List<DogModel> dogs = [];
//   // Lista que armazena os dogs

//   @override
//   void initState() {
//     super.initState();
//     _carregarDogs();
//   }

//   _carregarDogs() async {
//     final listaDogs = await findAll().toString();
//     setState(() {
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo, // Cor da barra superior
//         actions: [
//           IconButton(
//             onPressed: () {}, // Botão sem função no momento
//             icon: Icon(Icons.youtube_searched_for), // Ícone do botão
//             color: Colors.white, // Cor do ícone
//           ),
//         ],
//         title: Text(
//           "Bem vindo, Pedro Zucchi", // Título da AppBar
//           style: TextStyle(color: Colors.white), // Estilo do título
//         ),
//         leading: Icon(Icons.bathtub_outlined, color: Colors.white, size: 50.0),
//         // Ícone à esquerda da AppBar
//       ),
//       body: ListView.builder(
//         itemCount: dogs.length, // Quantidade de itens na lista
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text(
//                 dogs[index].Nome, // Nome do dog
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 "Idade: ${dogs[index].Idade}", // Idade do dog
//                 style: TextStyle(fontSize: 16),
//               ),
//               trailing: IconButton(
//                 icon: Icon(Icons.delete, color: Colors.red), // Ícone de apagar
//                 onPressed: () async {
//                   await removeDog(dogs[index].id!); // Apaga o dog do banco de dados
//                   setState(() {
//                     dogs.removeAt(index); // Remove o dog da lista
//                   });
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TelaCadastroShow()),
//             // Abre a tela de cadastro
//           ).then((p) async {
//             // Quando retornar da tela, adiciona o novo dog ao banco de dados
//             await insertDog(p);
//             setState(() {
//               dogs.add(p); // Adiciona o dog à lista
//             });
//           });
//         },
//         backgroundColor: Colors.indigo.shade600, // Cor do botão
//         child: Icon(Icons.add, color: Colors.white, size: 30), // Ícone "+"
//       ),
//     );
//   }
// } //InicialShow

// //-------------------------------------------------Segunda Tela---------------------------------------------

// class TelaCadastroShow extends StatelessWidget {
//   final TextEditingController _controllernome = TextEditingController(); // Controlador de texto para o nome
//   final TextEditingController _controlleridade = TextEditingController(); // Controlador de texto para a idade

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo, // Define a cor de fundo da barra de aplicativos
//         actions: [
//           IconButton(
//             onPressed: () {}, // Função a ser executada quando o botão é pressionado
//             icon: Icon(Icons.abc, size: 40), // Ícone do botão
//             color: Colors.white, // Cor do ícone
//           ),
//         ],
//         title: Text(
//           "Cadastro de Dogs", // Título da barra de aplicativos
//           style: TextStyle(color: Colors.white), // Estilo do texto do título
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//             size: 40,
//           ), // Ícone do botão de voltar
//           tooltip: 'Voltar', // Texto que aparece ao passar o mouse
//           onPressed: () {
//             Navigator.pop(context); // Volta para a tela anterior
//           },
//         ),
//       ),
//       body: Center(
//         child: ListView(
//           children: <Widget>[
//             SizedBox(height: 20), // Espaçamento vertical
//             Padding(
//               padding: EdgeInsets.all(10), // Adiciona uma margem em todos os lados
//               child: SizedBox(
//                 width: 250, // Largura do campo
//                 child: TextField(
//                   controller: _controllernome, // Controlador para pegar o texto digitado
//                   decoration: InputDecoration(
//                     labelText: 'Nome do Dog', // Rótulo do campo
//                     border: OutlineInputBorder(), // Borda do campo
//                     prefixIcon: Icon(Icons.label), // Ícone dentro do campo
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20), // Espaçamento vertical
//             Padding(
//               padding: EdgeInsets.all(10), // Adiciona uma margem em todos os lados
//               child: SizedBox(
//                 width: 250,
//                 child: TextField(
//                   controller: _controlleridade, // Controlador do campo idade
//                   decoration: InputDecoration(
//                     labelText: 'Idade do Dog', // Rótulo
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.numbers), // Ícone numérico
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   //-----------------------------------Limpar-----------------------------------
//                   ElevatedButton(
//                     onPressed: () {
//                       _controllernome.text = ""; // Limpa o campo nome
//                       _controlleridade.text = ""; // Limpa o campo idade
//                     },
//                     child: Text("Limpar"), // Texto do botão
//                   ),
//                   SizedBox(width: 20), // Espaço entre os botões
//                   //-------------------------------SALVAR------------------------
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_controllernome.text != "" &&
//                           _controlleridade.text != "") {
//                         DogModel p = DogModel(
//                           Nome: _controllernome.text, // Coleta o texto do nome
//                           Idade: int.parse(_controlleridade.text), // Coleta o texto da idade
//                         );

//                         await insertDog(p); // Salva o dog no banco de dados
//                         Navigator.pop(context, p); // Retorna o dog à tela anterior
//                       }
//                     },
//                     child: Text("Salvar"), // Texto do botão
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

