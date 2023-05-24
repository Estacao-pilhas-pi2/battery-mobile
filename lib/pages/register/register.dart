import 'package:flutter/material.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:estacao_pilhas/globals/colors.dart';

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
  TextEditingController cnpjController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Widget> userTypes = <Widget>[
    const Text('Reciclador'),
    const Text('Empresa'),
  ];
  final List<bool> _selectedUserType = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Cadastro'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                child: Column(
                  children: [
                    Image.asset('assets/images/logo_text.png'),
                  ],
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ToggleButtons(
                  isSelected: _selectedUserType,
                  borderRadius: BorderRadius.circular(100),
                  selectedBorderColor: AppColors.appTheme.primaryColor,
                  selectedColor: Colors.white,
                  fillColor: AppColors.appTheme.primaryColor,
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 100.0,
                  ),
                  children: userTypes,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _selectedUserType.length; i++) {
                        _selectedUserType[i] = i == index;
                      }
                    });
                  },
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
              child: _selectedUserType[0]
                  ? TextFormField(
                      controller: cpfController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo não preenchido';
                        }
                        if (!CPFValidator.isValid(text)) {
                          return 'CPF inválido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'CPF',
                      ),
                    )
                  : TextFormField(
                      controller: cnpjController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Campo não preenchido';
                        }
                        if (!CNPJValidator.isValid(text)) {
                          return 'CNPJ inválido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'CNPJ',
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
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
              child: TextFormField(
                obscureText: true,
                controller: confPassController,
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'Campo não preenchido';
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
                height: 50,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 58),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  child: const Text('Cadastrar'),
                  onPressed: () {
                    _formKey.currentState?.validate();
                  },
                )),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40))
          ],
        ),
      ),
    );
  }
}
