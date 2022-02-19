import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Util/globals.dart';
import 'signup3_view.dart';
import '../Widget/error_box.dart';
import '../Widget/spinner.dart';
import '../Services/account_service.dart';

class Signup2View extends StatefulWidget {
  const Signup2View({Key key, this.email, this.otp}) : super(key: key);

  final String email;
  final String otp;

  @override
  _Signup2ViewState createState() => _Signup2ViewState();
}

class _Signup2ViewState extends State<Signup2View> {
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
                  "Create Password",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please create your password below.  Passwords must be atleast six characters long.",
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
                  height: 30,
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
                                  "Password must be at least 6 characters long.";
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup3View(
                                      email: widget.email, otp: widget.otp)),
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
                  visible: _busy && _errorMessage.isNotEmpty,
                  child: SizedBox(
                    height: 40,
                    child: ErrorBox(errorMsg: _errorMessage),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
