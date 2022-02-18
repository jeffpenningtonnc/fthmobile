import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Widget/error_box.dart';
import 'signup1_view.dart';
import '../Services/account_service.dart';
import '../Services/preference_service.dart';
import 'application_view.dart';
import 'forgot_password1_view.dart';
import '../Widget/spinner.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _autoLoginBusy = true;
  bool _busy = false;
  bool _invalidLogin = false;
  bool _obscureText = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> getEmailFromPrefs() async {
    String email = await PreferenceService.getPrefAsString("email");
    String password = await PreferenceService.getPrefAsString("password");

    if (email.isNotEmpty && password.isNotEmpty) {

      setState(() {
        _busy = true;
      });

      bool valid = await AccountService.authenticate(email, password);
      if (valid) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ApplicationView()),
        );
      } else {
        setState(() {
          _invalidLogin = true;
        });
      }

      setState(() {
        _busy = false;
        _autoLoginBusy = false;
      });
    }
    else {
      setState(() {
        _autoLoginBusy = false;
      });
    }

    setState(() {
      emailController.text = email;
      passwordController.text = password;
    });
  }

  @override
  void initState() {
    getEmailFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: Visibility(
        visible: !_autoLoginBusy,
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://admin.feedthehungerapp.com/images/fthbackground.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Image.asset(
                      "images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: emailController,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: InkWell(
                        onTap: () async {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color.fromARGB(255, 142, 197, 95),
                        child: MaterialButton(
                          minWidth: (MediaQuery.of(context).size.width) / 2,
                          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          onPressed: () async {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            setState(() {
                              _busy = true;
                              _invalidLogin = false;
                            });

                            bool valid = await AccountService.authenticate(
                                emailController.text, passwordController.text);

                            if (!valid) {
                              setState(() {
                                _busy = false;
                                _invalidLogin = true;
                              });
                            } else {
                              _busy = false;

                              await PreferenceService.setPrefAsString(
                                  "email", emailController.text);
                              await PreferenceService.setPrefAsString(
                                  "password", passwordController.text);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ApplicationView()),
                              );
                            }
                          },
                          child: const Text(
                            "Sign in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword1View()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Forgot password?",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Visibility(
                    visible: _busy,
                    child: const SizedBox(
                      height: 35,
                      child: Spinner(),
                    ),
                  ),
                  Visibility(
                    visible: _invalidLogin,
                    child: const ErrorBox(errorMsg: "Invalid email or password."),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen && !_autoLoginBusy,
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Register'),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupView()),
            );
          },
        ),
      ),
    );
  }
}
