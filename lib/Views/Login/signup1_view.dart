import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fthmobile/Common/error_box.dart';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Services/account_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:fthmobile/Views/Login/otp_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool _busy = false;
  bool _invalidEmailAddress = false;

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: const Color.fromARGB(192, 50, 50, 50),
        centerTitle: true,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundLocation),
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
                  'Registration',
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
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color.fromARGB(255, 142, 197, 95),
                      child: MaterialButton(
                        minWidth: (MediaQuery.of(context).size.width) / 2,
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        onPressed: () async {
                          if (_busy) return;

                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          bool isValid = EmailValidator.validate(
                              emailController.text.trim());
                          if (!isValid) {
                            setState(() {
                              _invalidEmailAddress = true;
                            });

                            return;
                          }

                          setState(() {
                            _busy = true;
                            _invalidEmailAddress = false;
                          });

                          int result = await AccountService.registerUsingOTP(
                              emailController.text);

                          setState(() {
                            _busy = false;
                          });

                          if (result == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPView(
                                      email: emailController.text,
                                      action: "register")),
                            );
                          }
                        },
                        child: const Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Visibility(
                  visible: _busy,
                  child: const SizedBox(
                    height: 35,
                    child: Spinner(),
                  ),
                ),
                Visibility(
                  visible: _invalidEmailAddress,
                  child: const ErrorBox(errorMsg: "The email address provided in not valid"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
