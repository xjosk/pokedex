import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/injection_container.dart';

import '../pokemon_list/pokemon_list_page.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _navigateToPokemonList() {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (_) => const PokemonListPage(),
      ),
      (route) => false,
    );
  }

  bool visible = false;

  @override
  void dispose() {
    for (var controller in [
      _usernameController,
      _passwordController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff82C95B),
              Color(0xff639CE4),
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
              child: Image.asset(
                      'assets/logo_pokemon.png',
                      scale: 15,
                    ),
            ),
              Visibility(
                visible: visible,
                child: const Text(
                  'This user already exists.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Username',)),
                    ),
              CupertinoTextFormFieldRow(
                decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please, type your username.';
                  }
                  return null;
                },
                controller: _usernameController,
              ),
              const SizedBox(
                      height: 10.0,
                    ),
              const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Password',)),
                    ),
              CupertinoTextFormFieldRow(
                decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please, type your password.';
                  }
                  return null;
                },
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(
                      height: 10.0,
                    ),
              const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Confirm password',)),
                    ),
              CupertinoTextFormFieldRow(
                decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please, confirm your password.';
                  }
                  if (value != _passwordController.text) {
                    return "Passwords don't match.";
                  }
                  return null;
                },
                obscureText: true,
              ),
              CupertinoButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final couldSignUp = await ref.read(signupUser).execute(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );
                    if (!couldSignUp) {
                      setState(() => visible = true);
                      return;
                    }
                    _navigateToPokemonList();
                  }
                },
                child: const Text('Sign Up', 
                        style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
