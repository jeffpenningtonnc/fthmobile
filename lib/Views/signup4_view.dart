import 'package:flutter/material.dart';
import 'login_view.dart';
import '../Util/globals.dart';

class Signup4View extends StatefulWidget {
  const Signup4View({Key key}) : super(key: key);

  @override
  _Signup4ViewState createState() => _Signup4ViewState();
}

class _Signup4ViewState extends State<Signup4View> {

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
                  "Registration",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "You are registered!",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45),
                ),
                const SizedBox(
                  height: 20,
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

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginView()),
                          );

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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
