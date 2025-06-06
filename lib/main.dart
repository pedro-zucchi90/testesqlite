import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InicialShow(),
    ),
  );
}

class InicialShow extends StatefulWidget {
  @override
  State<InicialShow> createState() => _InicialShowState();
  // Cria o estado associado a InicialShow
}


class _InicialShowState extends State<InicialShow> {
  List<DogModel> produtos = [DogModel(Nome: "Heitor Scalco Neto", Idade: 20)];
  // Lista que armazena os produtos


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura da tela principal
      appBar: AppBar(
        backgroundColor: Colors.indigo, // Cor da barra superior
        actions: [
          IconButton(
            onPressed: () {}, // Botão sem função no momento
            icon: Icon(Icons.youtube_searched_for), // Ícone do botão
            color: Colors.white, // Cor do ícone
          ),
        ],
        title: Text(
          "Bem vindo, Pedro Zucchi", // Título da AppBar
          style: TextStyle(color: Colors.white), // Estilo do título
        ),
        leading: Icon(Icons.bathtub_outlined, color: Colors.white, size: 50.0),
        // Ícone à esquerda da AppBar
      ),
      body: ListView.builder(
        // Cria uma lista rolável de widgets com base em produtos
        itemCount: produtos.length, // Quantidade de itens na lista
        itemBuilder: (context, index) {
          // Função que define como cada item da lista será exibido
          // Index representa a posição


          return Card(
            // Cartão com elevação para destacar visualmente
            child: ListTile(
              // Item de lista com ícones, título e subtítulo
              title: Text(
                produtos[index].Nome, // Nome do produto
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "R\$ ${produtos[index].Idade} - ${produtos[index].Idade}", // Preço e quantidade
                style: TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red), // Ícone de apagar
                onPressed: () {
                  setState(() {
                    produtos.removeAt(index); // Remove o produto da lista
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Botão flutuante no canto inferior direito
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaCadastroShow()),
            // Abre a tela de cadastro
          ).then((p) {
            // Quando retornar da tela, adiciona o novo produto
            setState(() {
              produtos.add(p);
            });
          });
        },
        backgroundColor: Colors.indigo.shade600, // Cor do botão
        child: Icon(Icons.add, color: Colors.white, size: 30), // Ícone "+"
      ),
    );
  }
} //InicialShow


//-------------------------------------------------Segunda Tela---------------------------------------------


class TelaCadastroShow extends StatelessWidget {
  final TextEditingController _controllernome =
      TextEditingController(); // Controlador de texto para o nome
  final TextEditingController _controlleridade =
      TextEditingController(); // Controlador de texto para a idade


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-------------------------------APPBAR----------------------------------
      appBar: AppBar(
        backgroundColor:
            Colors.indigo, // Define a cor de fundo da barra de aplicativos
        actions: [
          IconButton(
            onPressed:
                () {}, // Função a ser executada quando o botão é pressionado
            icon: Icon(Icons.abc, size: 40), // Ícone do botão
            color: Colors.white, // Cor do ícone
          ),
        ],
        title: Text(
          "Cadastro de Produtos", // Título da barra de aplicativos
          style: TextStyle(color: Colors.white), // Estilo do texto do título
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40,
          ), // Ícone do botão de voltar
          tooltip: 'Voltar', // Texto que aparece ao passar o mouse
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),


      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20), // Espaçamento vertical
            Padding(
              padding: EdgeInsets.all(10), // Adiciona uma margem em todos os lados
              child: SizedBox(
                width: 250, // Largura do campo
                child: TextField(
                  controller:
                      _controllernome, // Controlador para pegar o texto digitado
                  decoration: InputDecoration(
                    labelText: 'Nome Produto', // Rótulo do campo
                    border: OutlineInputBorder(), // Borda do campo
                    prefixIcon: Icon(Icons.label), // Ícone dentro do campo
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Espaçamento vertical
            Padding(
              padding: EdgeInsets.all(10), // Adiciona uma margem em todos os lados
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: _controlleridade, // Controlador do campo idade
                  decoration: InputDecoration(
                    labelText: 'Idade', // Rótulo
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers), // Ícone numérico
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //-----------------------------------Limpar-----------------------------------
                  ElevatedButton(
                    onPressed: () {
                      _controllernome.text = ""; // Limpa o campo nome
                      _controlleridade.text = ""; // Limpa o campo idade
                    },
                    child: Text("Limpar"), // Texto do botão
                  ),


                  //-------------------------------SALVAR------------------------
                  ElevatedButton(
                    onPressed: () {
                      DogModel p = DogModel(
                        Nome: _controllernome.text, // Coleta o texto do nome
                        Idade: int.parse(_controlleridade.text), // Coleta o texto da idade
                      );

                      if (_controllernome.text != "" &&
                          _controlleridade.text != "") {
                        DogModel p = DogModel(
                          Nome: _controllernome.text, // Coleta o texto do nome
                          Idade: int.parse(_controlleridade.text), // Coleta o texto da idade
                        );
                        Navigator.pop(
                          context,
                          p,
                        ); // Retorna o produto à tela anterior
                      }
                    },
                    child: Text("Salvar"), // Texto do botão
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DogModel {
  String Nome;
  int Idade;

  DogModel({
    required this.Nome,
    required this.Idade,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': Nome,
      'idade': Idade,
    };
  }

  @override
  String toString() {
    return 'DogModel: {nome: $Nome, idade: $Idade}';
  }
}

