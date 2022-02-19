import 'package:flutter/material.dart';
import '../Util/globals.dart';
import '../Views/forgot_password2_view.dart';
import '../Views/signup2_view.dart';
import '../Widget/error_box.dart';
import '../Widget/spinner.dart';
import '../Services/account_service.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key key, this.email, this.action}) : super(key: key);

  final String email;
  final String action;

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  bool _busy = false;
  bool _invalidOTP = false;

  TextEditingController otpController = TextEditingController();

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
                  "Check your email...",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "An email was sent to you that contains a one-time password.  Please enter the password below.",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: otpController,
                  obscureText: false,
                    keyboardType: TextInputType.number,
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

                          setState(() {
                            _busy = true;
                            _invalidOTP = false;
                          });

                          int result = await AccountService.validateOTP(
                              widget.email, otpController.text);

                          setState(() {
                            _busy = false;
                          });

                          if (result == 0) {
                            if (widget.action == "forgotPassword") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword2View(
                                        email: widget.email,
                                        otp: otpController.text)),
                              );
                            } else if (widget.action == "register") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup2View(
                                        email: widget.email,
                                        otp: otpController.text)),
                              );
                            }
                          } else {
                            _invalidOTP = true;
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
                const SizedBox(height: 50),
                Visibility(
                  visible: _busy,
                  child: const SizedBox(
                    height: 35,
                    child: Spinner(),
                  ),
                ),
                Visibility(
                  visible: _invalidOTP,
                  child: const ErrorBox(errorMsg: "Invalid one-time password."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
