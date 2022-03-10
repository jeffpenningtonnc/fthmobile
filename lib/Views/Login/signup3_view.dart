import 'package:flutter/material.dart';
import 'package:fthmobile/Common/error_box.dart';
import 'package:fthmobile/Common/spinner.dart';
import 'package:fthmobile/Services/account_service.dart';
import 'package:fthmobile/Services/preference_service.dart';
import 'package:fthmobile/Util/Globals.dart';
import 'package:fthmobile/Views/Login/signup4_view.dart';

class Signup3View extends StatefulWidget {
  const Signup3View({Key key, this.email, this.otp}) : super(key: key);

  final String email;
  final String otp;

  @override
  _Signup3ViewState createState() => _Signup3ViewState();
}

class _Signup3ViewState extends State<Signup3View> {
  bool _busy = false;
  String _selectedState = "";
  String _errorMessage = "";

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
                              child: Text('Select State'), value: ''),
                          DropdownMenuItem<String>(
                              child: Text('Alabama'), value: 'Alabama'),
                          DropdownMenuItem<String>(
                              child: Text('Alaska'), value: 'Alaska'),
                          DropdownMenuItem<String>(
                              child: Text('Arizona'), value: 'Arizona'),
                          DropdownMenuItem<String>(
                              child: Text('Arkansas'), value: 'Arkansas'),
                          DropdownMenuItem<String>(
                              child: Text('California'), value: 'California'),
                          DropdownMenuItem<String>(
                              child: Text('Colorado'), value: 'Colorado'),
                          DropdownMenuItem<String>(
                              child: Text('Connecticut'), value: 'Connecticut'),
                          DropdownMenuItem<String>(
                              child: Text('Delaware'), value: 'Delaware'),
                          DropdownMenuItem<String>(
                              child: Text('Florida'), value: 'Florida'),
                          DropdownMenuItem<String>(
                              child: Text('Georgia'), value: 'Georgia'),
                          DropdownMenuItem<String>(
                              child: Text('Hawaii'), value: 'Hawaii'),
                          DropdownMenuItem<String>(
                              child: Text('Idaho'), value: 'Idaho'),
                          DropdownMenuItem<String>(
                              child: Text('Illinois'), value: 'Illinois'),
                          DropdownMenuItem<String>(
                              child: Text('Indiana'), value: 'Indiana'),
                          DropdownMenuItem<String>(
                              child: Text('Iowa'), value: 'Iowa'),
                          DropdownMenuItem<String>(
                              child: Text('Kansas'), value: 'Kansas'),
                          DropdownMenuItem<String>(
                              child: Text('Kentucky'), value: 'Kentucky'),
                          DropdownMenuItem<String>(
                              child: Text('Louisiana'), value: 'Louisiana'),
                          DropdownMenuItem<String>(
                              child: Text('Maine'), value: 'Maine'),
                          DropdownMenuItem<String>(
                              child: Text('Maryland'), value: 'Maryland'),
                          DropdownMenuItem<String>(
                              child: Text('Massachusetts'), value: 'Massachusetts'),
                          DropdownMenuItem<String>(
                              child: Text('Michigan'), value: 'Michigan'),
                          DropdownMenuItem<String>(
                              child: Text('Minnesota'), value: 'Minnesota'),
                          DropdownMenuItem<String>(
                              child: Text('Mississippi'), value: 'Mississippi'),
                          DropdownMenuItem<String>(
                              child: Text('Missouri'), value: 'Missouri'),
                          DropdownMenuItem<String>(
                              child: Text('Montana'), value: 'Montana'),
                          DropdownMenuItem<String>(
                              child: Text('Nebraska'), value: 'Nebraska'),
                          DropdownMenuItem<String>(
                              child: Text('Nevada'), value: 'Nevada'),
                          DropdownMenuItem<String>(
                              child: Text('New Hampshire'), value: 'New Hampshire'),
                          DropdownMenuItem<String>(
                              child: Text('New Jersey'), value: 'New Jersey'),
                          DropdownMenuItem<String>(
                              child: Text('New Mexico'), value: 'New Mexico'),
                          DropdownMenuItem<String>(
                              child: Text('New York'), value: 'New York'),
                          DropdownMenuItem<String>(
                              child: Text('North Carolina'), value: 'North Carolina'),
                          DropdownMenuItem<String>(
                              child: Text('North Dakota'), value: 'North Dakota'),
                          DropdownMenuItem<String>(
                              child: Text('Ohio'), value: 'Ohio'),
                          DropdownMenuItem<String>(
                              child: Text('Oklahoma'), value: 'Oklahoma'),
                          DropdownMenuItem<String>(
                              child: Text('Oregon'), value: 'Oregon'),
                          DropdownMenuItem<String>(
                              child: Text('Pennsylvania'), value: 'Pennsylvania'),
                          DropdownMenuItem<String>(
                              child: Text('Rhode Island'), value: 'Rhode Island'),
                          DropdownMenuItem<String>(
                              child: Text('South Carolina'), value: 'South Carolina'),
                          DropdownMenuItem<String>(
                              child: Text('South Dakota'), value: 'South Dakota'),
                          DropdownMenuItem<String>(
                              child: Text('Tennessee'), value: 'Tennessee'),
                          DropdownMenuItem<String>(
                              child: Text('Texas'), value: 'Texas'),
                          DropdownMenuItem<String>(
                              child: Text('Utah'), value: 'Utah'),
                          DropdownMenuItem<String>(
                              child: Text('Vermont'), value: 'Vermont'),
                          DropdownMenuItem<String>(
                              child: Text('Virginia'), value: 'Virginia'),
                          DropdownMenuItem<String>(
                              child: Text('Washington'), value: 'Washington'),
                          DropdownMenuItem<String>(
                              child: Text('West Virginia'), value: 'West Virginia'),
                          DropdownMenuItem<String>(
                              child: Text('Wisconsin'), value: 'Wisconsin'),
                          DropdownMenuItem<String>(
                              child: Text('Wyoming'), value: 'Wyoming'),
                        ],
                        onChanged: (String value) {
                          setState(() {
                            _selectedState = value;
                          });
                        },
                        value: _selectedState,
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
                  height: 10,
                ),
                Visibility(
                  visible: !_busy && _errorMessage.isNotEmpty,
                  child: SizedBox(
                    height: 40,
                    child: ErrorBox(errorMsg: _errorMessage),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                            _errorMessage = "";
                          });

                          String firstName = firstNameController.text;
                          String lastName = lastNameController.text;
                          String address =  addressController.text;
                          String city =  cityController.text;
                          String state =  _selectedState;
                          String zip =  zipController.text;
                          String mobile =  mobileController.text;

                          if (firstName.isEmpty || lastName.isEmpty
                              || address.isEmpty || city.isEmpty
                              || state.isEmpty || zip.isEmpty || mobile.isEmpty ) {
                            setState(() {
                              _errorMessage = "Please complete all fields above.";
                            });
                            return;
                          }

                          setState(() {
                            _busy = true;
                            _errorMessage = "";
                          });

                          await PreferenceService.setPrefAsString("email", widget.email);

                          bool accountUpdated =
                          await AccountService.updateAccount(widget.otp,
                              firstName, lastName, address, city, state, zip,
                              mobile);

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
