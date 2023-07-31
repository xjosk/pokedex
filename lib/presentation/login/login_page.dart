import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/injection_container.dart';
import 'package:pokedex/presentation/pokemon_list/pokemon_list_page.dart';
import 'package:pokedex/presentation/signup/signup_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _checkForSessionId() {
    final sessionId = ref.read(getSessionId).call();
    if (sessionId > 0) {
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (_) => const PokemonListPage(),
        ),
        (route) => false,
      );
      return;
    }
    setState(() => hasSession = false);
  }

  bool hasSession = true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkForSessionId();
    });
  }

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

  void _pokemonListPage() => Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (_) => const PokemonListPage(),
        ),
        (route) => false,
      );

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff82C95B),
            Color(0xff639CE4),
          ],
        ),),
        child: hasSession
            ? Center(
              child: Image.asset(
                      'assets/pokedex.png',
                      scale: 10,
                    ),
            )
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pokedex.png',
                      scale: 10,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Visibility(
                      visible: visible,
                      child: const Text(
                        'Incorrect username or password.',
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
                    CupertinoButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final couldLogin = await ref.read(loginUser).execute(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              );
                          if (!couldLogin) {
                            setState(() => visible = true);
                            return;
                          }
                          _pokemonListPage();
                        }
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => const SignupPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Not a user? Sign up!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
