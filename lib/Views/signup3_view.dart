import 'package:flutter/material.dart';
import '../Services/account_service.dart';
import '../Widget/spinner.dart';
import '/Views/signup4_view.dart';
import '/Services/preference_service.dart';

class Signup3View extends StatefulWidget {
  const Signup3View({Key key, this.email, this.otp}) : super(key: key);

  final String email;
  final String otp;

  @override
  _Signup3ViewState createState() => _Signup3ViewState();
}

class _Signup3ViewState extends State<Signup3View> {
  bool _busy = false;
  String _value = "NC";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'http://fth.jeffpenningtonnc.com/images/fthbackground.png',
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
                  height: 50,
                ),
                const Text(
                  'Account Details',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: firstNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "First Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lastNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Last Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: addressController,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: cityController,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        items: const [
                          DropdownMenuItem<String>(
                              child: Text('Alabama'), value: 'AL'),
                          DropdownMenuItem<String>(
                              child: Text('Alaska'), value: 'AK'),
                          DropdownMenuItem<String>(
                              child: Text('Arizona'), value: 'AR'),
                          DropdownMenuItem<String>(
                              child: Text('Arkansas'), value: 'AR'),
                          DropdownMenuItem<String>(
                              child: Text('California'), value: 'CA'),
                          DropdownMenuItem<String>(
                              child: Text('Colorado'), value: 'CO'),
                          DropdownMenuItem<String>(
                              child: Text('Connecticut'), value: 'CT'),
                          DropdownMenuItem<String>(
                              child: Text('Delaware'), value: 'DE'),
                          DropdownMenuItem<String>(
                              child: Text('Florida'), value: 'FL'),
                          DropdownMenuItem<String>(
                              child: Text('Georgia'), value: 'GA'),
                          DropdownMenuItem<String>(
                              child: Text('Hawaii'), value: 'HI'),
                          DropdownMenuItem<String>(
                              child: Text('Idaho'), value: 'ID'),
                          DropdownMenuItem<String>(
                              child: Text('Illinois'), value: 'IL'),
                          DropdownMenuItem<String>(
                              child: Text('Indiana'), value: 'IN'),
                          DropdownMenuItem<String>(
                              child: Text('Iowa'), value: 'IA'),
                          DropdownMenuItem<String>(
                              child: Text('Kansas'), value: 'KS'),
                          DropdownMenuItem<String>(
                              child: Text('Kentucky'), value: 'KY'),
                          DropdownMenuItem<String>(
                              child: Text('Louisiana'), value: 'LA'),
                          DropdownMenuItem<String>(
                              child: Text('Maine'), value: 'ME'),
                          DropdownMenuItem<String>(
                              child: Text('Maryland'), value: 'MD'),
                          DropdownMenuItem<String>(
                              child: Text('Massachusetts'), value: 'MA'),
                          DropdownMenuItem<String>(
                              child: Text('Michigan'), value: 'MI'),
                          DropdownMenuItem<String>(
                              child: Text('Minnesota'), value: 'MN'),
                          DropdownMenuItem<String>(
                              child: Text('Mississippi'), value: 'MS'),
                          DropdownMenuItem<String>(
                              child: Text('Missouri'), value: 'MO'),
                          DropdownMenuItem<String>(
                              child: Text('Montana'), value: 'MT'),
                          DropdownMenuItem<String>(
                              child: Text('Nebraska'), value: 'NE'),
                          DropdownMenuItem<String>(
                              child: Text('Nevada'), value: 'NV'),
                          DropdownMenuItem<String>(
                              child: Text('New Hampshire'), value: 'NH'),
                          DropdownMenuItem<String>(
                              child: Text('New Jersey'), value: 'NJ'),
                          DropdownMenuItem<String>(
                              child: Text('New Mexico'), value: 'NM'),
                          DropdownMenuItem<String>(
                              child: Text('New York'), value: 'NY'),
                          DropdownMenuItem<String>(
                              child: Text('North Carolina'), value: 'NC'),
                          DropdownMenuItem<String>(
                              child: Text('North Dakota'), value: 'ND'),
                          DropdownMenuItem<String>(
                              child: Text('Ohio'), value: 'OH'),
                          DropdownMenuItem<String>(
                              child: Text('Oklahoma'), value: 'OK'),
                          DropdownMenuItem<String>(
                              child: Text('Oregon'), value: 'OR'),
                          DropdownMenuItem<String>(
                              child: Text('Pennsylvania'), value: 'PA'),
                          DropdownMenuItem<String>(
                              child: Text('Rhode Island'), value: 'RI'),
                          DropdownMenuItem<String>(
                              child: Text('South Carolina'), value: 'SC'),
                          DropdownMenuItem<String>(
                              child: Text('South Dakota'), value: 'SD'),
                          DropdownMenuItem<String>(
                              child: Text('Tennessee'), value: 'TN'),
                          DropdownMenuItem<String>(
                              child: Text('Texas'), value: 'TX'),
                          DropdownMenuItem<String>(
                              child: Text('Utah'), value: 'UT'),
                          DropdownMenuItem<String>(
                              child: Text('Vermont'), value: 'VT'),
                          DropdownMenuItem<String>(
                              child: Text('Virginia'), value: 'VA'),
                          DropdownMenuItem<String>(
                              child: Text('Washington'), value: 'WA'),
                          DropdownMenuItem<String>(
                              child: Text('West Virginia'), value: 'WV'),
                          DropdownMenuItem<String>(
                              child: Text('Wisconsin'), value: 'WI'),
                          DropdownMenuItem<String>(
                              child: Text('Wyoming'), value: 'WY'),
                        ],
                        onChanged: (String value) {
                          setState(() {
                            _value = value;
                          });
                        },
                        hint: const Text('Select State'),
                        value: _value,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                          hintText: "Postal Code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: zipController,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Postal Code",
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: mobileController,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Mobile Phone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
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

                          setState(() {
                            _busy = true;
                          });

                          await PreferenceService.setPrefAsString("email", widget.email);

                          bool accountUpdated =
                          await AccountService.updateAccount(widget.otp, firstNameController.text, lastNameController.text);

                          setState(() {
                            _busy = false;
                          });

                          if(accountUpdated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup4View()),
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
                const SizedBox(height: 40),
                Visibility(
                  visible: _busy,
                  child: const SizedBox(
                    height: 35,
                    child: Spinner(),
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
