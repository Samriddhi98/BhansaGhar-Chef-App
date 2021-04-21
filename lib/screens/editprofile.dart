import 'package:BhansaGharChef/models/registerModel.dart';
import 'package:BhansaGharChef/services/authservice.dart';
import 'package:BhansaGharChef/widgets/forminput.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditChefDetails extends StatefulWidget {
  final RegisterModel chefData;

  const EditChefDetails({
    Key key,
    this.chefData,
  }) : super(key: key);
  @override
  _EditChefDetailsState createState() => _EditChefDetailsState();
}

class _EditChefDetailsState extends State<EditChefDetails> {
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
      int contact}) async {
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
    print('chef id$chefid');
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    bool _togglevisibility = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Chef Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
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
                    // TextFormField(
                    //   textAlign: TextAlign.start,
                    //   controller: password,
                    //   style: TextStyle(fontSize: 14.0),
                    //   decoration: InputDecoration(
                    //     contentPadding: EdgeInsets.only(bottom: 0.0, top: 20.0),
                    //     // isDense: true,
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //     hintText: "Password",

                    //     // border: InputBorder.none,
                    //     suffixIcon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           _togglevisibility = !_togglevisibility;
                    //         });
                    //       },
                    //       icon: _togglevisibility
                    //           ? Icon(Icons.visibility_off)
                    //           : Icon(Icons.visibility),
                    //     ),
                    //   ),
                    //   obscureText: _togglevisibility,
                    // ),
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
                    child: Text('Edit Details',
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
                            username: value.username,
                            location: value.location,
                            account: value.account,
                            contact: value.contact);
                      });
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'Edit complete',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 10.0,
                      );
                      Navigator.of(context).pushNamed('/profile-page');
                    } else if (value.statusCode == 400) {
                      print("eereafsdfasdfadsf");
                      print(value.data['error']);
                      Fluttertoast.showToast(
                        msg: 'Edit failed',
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
        ],
      ),
    );
  }
}
