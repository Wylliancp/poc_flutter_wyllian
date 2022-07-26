import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.purple),
    initialRoute: "/login",
    routes: {
      "/login": (context) => const LoginPage(),
      "/home": (context) => const HomePage()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Usuario logado com sucesso!!!")),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username;
  late String password;
  var isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Username"),
                  validator: (value) => validateUserName(username: value),
                  onSaved: (value) => username = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "password"),
                  obscureText: true,
                  validator: (value) => validatePassword(password: value),
                  onSaved: (value) => password = value!,
                ),
                const SizedBox(
                  height: 32,
                ),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple)),
                      onPressed: () async {
                        if (validate()) {
                          await Login(username: username, password: password);
                        }
                      },
                      child: const Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ))
              ],
            ),
          ),
        ));
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  String? validateUserName({String? username}) {
    return username != null && username.isNotEmpty
        ? null
        : "O nome do usuario deve ser diferente de nulo ou vazio";
  }

  String? validatePassword({String? password}) {
    return password!.length > 6 && password.isNotEmpty
        ? null
        : "A senha tem que ter mais de 6 caracteres";
  }

  Future<void> Login(
      {required String username, required String password}) async {
    final response = validateLogin(username: username, password: password);
    isLoading = true;
    setState(() {});
    final responseApi = await apiLogin(username: username, password: password);
    isLoading = false;
    setState(() {});
    if (response && responseApi) {
      Navigator.pushNamed(context, "/home");
      print("abrindo a home page");
    }
  }

  Future<bool> apiLogin(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  bool validateLogin({required String username, required String password}) {
    print("conectado com servidor!");
    print("Login realizado com Sucesso!");
    print("username $username | password $password");
    return true;
  }
}


// //CRIAR UMA FUNCAO DE LOGIN
// //VALIDAR O EMAIL
// //VALIDAR A SENHA
// //VALIDAR NO BACKEND, API SE OS DADOS ESTÃO CERTOS
// //DIRECIONAR PARA A TELA DE HOME

// void main() {
//   final isValid = validate(username: "wyllian", password: "senhaboa");
//   if (isValid == null) {
//     Login(username: "username", password: "password");
//     print("valido");
//   } else {
//     print("invalido");
//   }
// }