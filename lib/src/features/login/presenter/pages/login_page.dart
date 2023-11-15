import 'package:flutter/material.dart';
import 'package:sleepsounds/core/const/messages.dart';
import 'package:sleepsounds/core/widgets/custom_snackbar_widget.dart';
import 'package:sleepsounds/src/features/home/presenter/pages/home_page.dart';
import 'package:sleepsounds/src/features/login/data/login_datasource.dart';
import 'package:sleepsounds/src/features/login/domain/repository/login_repository.dart';
import 'package:sleepsounds/src/features/login/presenter/controllers/login_controller.dart';
import 'package:sleepsounds/src/features/login/presenter/states/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.isLogin = true});
  final bool isLogin;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = LoginController(
    repository: LoginRepository(
      datasource: LoginDatasource(),
    ),
  );

  @override
  void initState() {
    super.initState();

    loginController.auth.authStateChanges().listen(
      (event) {
        loginController.user = event;
        if (loginController.user != null) {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        }
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isLogin ? "Login" : "Register"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null) {
                      return 'Campo Vazio';
                    } else if (value.isEmpty) {
                      return 'Campo Vazio';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null) {
                      return 'Campo Vazio';
                    } else if (value.isEmpty) {
                      return 'Campo vazio';
                    } else if (value.length < 6) {
                      return 'Senha deve ter 6 caracteres.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Senha"),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isLogin) {
                          await loginController
                              .doLoginWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                          )
                              .then((result) {
                            if (result is SuccessLoginState) {
                              const snackBar = SnackBar(
                                content: Text('Login Efetuado!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (result is FailureLoginState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnakbar(
                                  message: result.message,
                                ),
                              );
                            }
                          });
                        } else {
                          await loginController
                              .registerWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                          )
                              .then(
                            (result) {
                              if (result is SuccessLoginState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnakbar(
                                    message: AppMessages.SUCCESS_REGISTER,
                                  ),
                                );
                              } else if (result is FailureLoginState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnakbar(
                                    message: result.message,
                                  ),
                                );
                              }
                            },
                          );
                        }
                      }
                    },
                    child: Text(widget.isLogin ? "Login" : "Register"),
                  ),
                ),
                Visibility(
                  visible: widget.isLogin,
                  child: GestureDetector(
                    onTap: () async {
                      if (widget.isLogin) {
                        await loginController.doLoginWithGoogle().then(
                          (result) {
                            if (result is SuccessLoginState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnakbar(
                                  message: AppMessages.SUCCESS_LOGIN,
                                ),
                              );
                            } else if (result is FailureLoginState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnakbar(
                                  message: result.message,
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.g_mobiledata,
                          size: 48,
                          color: Colors.amber,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(loginController.user == null
                    ? 'EMAIKL'
                    : loginController.user!.email!),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await loginController.signOut();
        },
      ),
    );
  }
}
