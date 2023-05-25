import 'package:estacao_pilhas/models/usuario.dart';
import 'package:estacao_pilhas/pages/recycler_page/recycler_page.dart';
import 'package:estacao_pilhas/pages/register/register.dart';
import 'package:flutter/material.dart';
import '../../components/simple_dialog.dart';
import '../credits_received/credits_received.dart';
import 'controllers/login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future submitLogin() async {
    setState(() => isLoading = true);

    var response = await LoginController()
        .login(nameController.text, passwordController.text);

    setState(() => isLoading = false);

    if (mounted && response is Usuario) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext qrCodeContext) {
          return response.estabelecimento!
              ? const CreditsReceived(paymentId: "")
              : const RecyclerPage();
        },
      ), (Route<dynamic> route) => false);
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return BasicDialog(title: 'Falha no login', message: response);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                child: Image.asset('assets/images/logo_text.png'),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Campo não preenchido';
                              }
                              return null;
                            },
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Usuário',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Campo não preenchido';
                              }
                              return null;
                            },
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                            ),
                          ),
                        ),
                      ],
                    ),

              // TextButton(
              //   onPressed: () {
              //     //forgot password screen
              //   },
              //   child: const Text(
              //     'Esqueci minha senha',
              //   ),
              // ),
              const SizedBox(height: 30),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(216, 58),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    child: const Text('Entrar'),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == false) return;
                      await submitLogin();
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Novo usuário?'),
                  TextButton(
                    child: const Text(
                      'Cadastre-se aqui!',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
