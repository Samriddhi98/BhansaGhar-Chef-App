import 'package:BhansaGharChef/models/registerModel.dart';
import 'package:BhansaGharChef/services/authservice.dart';
import 'package:BhansaGharChef/widgets/forminput.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegisterModel registerModel;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController(),
      lastName = TextEditingController(),
      username = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      location = TextEditingController(),
      contact = TextEditingController(),
      account = TextEditingController();

  saveTopref(String token) async {
    var preference = await SharedPreferences.getInstance();
    preference.setString("token", token);
    String a = preference.getString("token");
    print(a);
  }

  savedetailsTopref(
      {String id,
      String name,
      String username,
      String location,
      int account,
      int contact,
      bool verified}) async {
    var preference = await SharedPreferences.getInstance();
    preference.setString("cid", id);
    String chefid = preference.getString("cid");
    preference.setString("name", name);
    String chefname = preference.getString("name");
    preference.setString("username", username);
    String chefusername = preference.getString("username");
    preference.setString("location", location);
    String cheflocation = preference.getString("location");
    preference.setString("account", account.toString());
    String chefaccount = preference.getString("account");
    preference.setString("contact", contact.toString());
    String chefcontact = preference.getString("contact");
    preference.setBool("verified", verified);
    print('chef id$chefid');
  }

  bool _togglevisibility = true;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              width: 100.0,
              height: 50.0,
              //   color: Colors.amber,
              child: FittedBox(
                  child: Image.asset(
                'assets/images/logo.PNG',
                height: 50.0,
                width: 100.0,
              )),
            ),
          ),
          Text('Food that feels like home'),
          SizedBox(height: 10.0),
          Text(
            'SignUp as Chef and Start your food journey',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            width: deviceSize.width,
            height: 340.0,
            // color: Colors.blue,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: FormInputs(
                          input: 'FirstName',
                          controller: firstName,
                          inputType: TextInputType.text,
                        )),
                        SizedBox(width: 10.0),
                        Flexible(
                          child: FormInputs(
                            input: 'LastName',
                            controller: lastName,
                            inputType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    FormInputs(
                      input: 'Username',
                      controller: username,
                      inputType: TextInputType.text,
                    ),
                    FormInputs(
                      input: 'Email Address',
                      controller: email,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(width: 10.0),
                    TextFormField(
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(password))
                          return '     Invalid password';
                        else
                          return null;
                      },
                      textAlign: TextAlign.start,
                      controller: password,
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 0.0, top: 20.0),
                        // isDense: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Password",

                        // border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _togglevisibility = !_togglevisibility;
                            });
                          },
                          icon: _togglevisibility
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _togglevisibility,
                    ),
                    SizedBox(width: 10.0),
                    FormInputs(
                      input: 'Mobile Number',
                      inputType: TextInputType.phone,
                      controller: contact,
                    ),
                    SizedBox(width: 10.0),
                    FormInputs(
                        input: 'Address',
                        inputType: TextInputType.text,
                        controller: location),
                    FormInputs(
                      input: 'Account Number',
                      inputType: TextInputType.number,
                      controller: account,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 40.0,
            width: 350.0,
            child: GestureDetector(
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.black87,
                color: Colors.black,
                elevation: 7.0,
                child: Center(
                    child: Text('Create an Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
              onTap: () {
                print(password.text);
                // Navigator.of(context).pushNamed('/main-screen');
                if (_formkey.currentState.validate()) {
                  registerModel = RegisterModel(
                    firstName: firstName.text,
                    lastName: lastName.text,
                    username: username.text,
                    email: email.text,
                    password: password.text,
                    location: location.text,
                    contact: contact.text,
                    account: account.text,
                  );
                  AuthService().postUser(registerModel).then((value) {
                    if (value.statusCode == 200) {
                      saveTopref(value.data['token']);

                      AuthService()
                          .getChefDetails(value.data['token'])
                          .then((value) {
                        print(value.id);
                        savedetailsTopref(
                            id: value.id,
                            name: value.name,
                            verified: value.verified,
                            username: value.username,
                            location: value.location,
                            account: value.account,
                            contact: value.contact);
                      });
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'SignUp complete',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 10.0,
                      );
                      Navigator.of(context).pushNamed('/main-screen');
                    } else if (value.statusCode == 400) {
                      print("eereafsdfasdfadsf");
                      print(value.data['error']);
                      Fluttertoast.showToast(
                        msg: 'SignUp failed',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    }
                  });
                } else {
                  print("not validated");
                }
              },
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Already have an account?'),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed('/sign-up');
                  Navigator.of(context).pushReplacementNamed('/log-in');
                },
                child: Text(
                  'LogIn',
                  style: TextStyle(
                      color: Colors.yellow[700],
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
