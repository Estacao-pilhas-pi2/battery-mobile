import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
  TextEditingController confPassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          AppBar(
            leading: const BackButton(),
            title: const Text('Cadastro'),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
              child: Column(
                children: [
                  Image.asset('assets/images/test_logo.png'),
                ],
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextFormField(
              controller: nameController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Campo não preenchido';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextFormField(
              controller: emailController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Campo não preenchido';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextFormField(
              controller: cpfController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Campo não preenchido';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'CPF',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Campo não preenchido';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: TextFormField(
              obscureText: true,
              controller: confPassController,
              validator: (text) {
                if (text == null || text.isEmpty) return 'Campo não preenchido';
                if (text != passwordController.text) {
                  return 'Senha incorreta';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Confirmar senha',
              ),
            ),
          ),
          Container(
              height: 70,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ElevatedButton(
                child: const Text('Cadastrar'),
                onPressed: () {
                  _formKey.currentState?.validate();
                  // nameController.text
                  // passwordController.text
                },
              )),
        ],
      ),
    );
  }
}
