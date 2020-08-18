import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    bool _togglevisibility = true;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 70.0),
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
            margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            width: deviceSize.width,
            height: 320.0,
           //  color: Colors.blue,
            child: Form(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: FormInputs(
                        input: 'FirstName',
                        inputType: TextInputType.text,
                      )),
                      SizedBox(width: 10.0),
                      Flexible(
                        child: FormInputs(
                          input: 'LastName',
                          inputType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  FormInputs(
                    input: 'Email Address',
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(width: 10.0),
                  TextFormField(
                    textAlign: TextAlign.start,
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
                  FormInputs(input: 'Mobile Number',inputType: TextInputType.phone,),
                  SizedBox(width: 10.0),
                  FormInputs(input: 'Address',inputType: TextInputType.text,),
                  FormInputs(input: 'Account Number',inputType: TextInputType.number,),
                ],
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
                Navigator.of(context).pushNamed('/main-screen');
              },
            ),
          ),
          SizedBox(height:15.0),
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

class FormInputs extends StatelessWidget {
  final String input;
  final TextInputType inputType;

  FormInputs({this.input,this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       keyboardType: inputType,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14.0),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 0.0, top: 20.0),
        // isDense: true,
        hintText: input,

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // border: InputBorder.none,
      ),
    );
  }
}
