import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fthmobile/Common/error_box.dart';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Services/account_service.dart';
import 'package:fthmobile/Services/preference_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:fthmobile/Views/Login/forgot_password3_view.dart';

class ForgotPassword2View extends StatefulWidget {
  const ForgotPassword2View({Key key, this.email, this.otp}) : super(key: key);

  final String email;
  final String otp;

  @override
  _ForgotPassword2ViewState createState() => _ForgotPassword2ViewState();
}

class _ForgotPassword2ViewState extends State<ForgotPassword2View> {
  bool _busy = false;
  bool _obscureText = true;
  String _errorMessage = "";

  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Change Password",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please enter your new password below.  Passwords must be atleast six characters long.",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password1Controller,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "New Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
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
                  height: 10,
                ),
                TextField(
                  controller: password2Controller,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password Confirmation",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
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

                          setState(() {
                            _busy = true;
                            _errorMessage = "";
                          });

                          if (password1Controller.text !=
                              password2Controller.text) {
                            setState(() {
                              _errorMessage = "Passwords do not match.";
                              _busy = false;
                            });

                            return;
                          }

                          if (password1Controller.text.trim().length < 6) {
                            setState(() {
                              _errorMessage =
                                  "Password must be atleast 6 characters long.";
                              _busy = false;
                            });

                            return;
                          }

                          if (password1Controller.text.trim().length > 30) {
                            setState(() {
                              _errorMessage =
                                  "Password must be less than 30 characters long.";
                              _busy = false;
                            });

                            return;
                          }

                          bool passwordChanged =
                              await AccountService.changePassword(widget.email,
                                  widget.otp, password1Controller.text);

                          setState(() {
                            _busy = false;
                          });

                          if (passwordChanged) {

                            await PreferenceService.setPrefAsString("email", widget.email);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword3View()),
                            );
                          } else {
                            setState(() {
                              _errorMessage =
                                  "An error occurred while changing your password. Please try again.";
                            });
                          }
                        },
                        child: const Text(
                          "Submit",
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
                const SizedBox(height: 40),
                Visibility(
                  visible: _busy,
                  child: const SizedBox(
                    height: 35,
                    child: Spinner(),
                  ),
                ),
                Visibility(
                  visible: _errorMessage.isNotEmpty,
                  child: ErrorBox(errorMsg: _errorMessage),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
