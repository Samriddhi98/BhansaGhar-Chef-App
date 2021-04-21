import 'package:BhansaGharChef/models/chefModel.dart';
import 'package:BhansaGharChef/models/registerModel.dart';
import 'package:BhansaGharChef/screens/editprofile.dart';
import 'package:BhansaGharChef/screens/signup.dart';
import 'package:BhansaGharChef/services/authservice.dart';
import 'package:BhansaGharChef/services/foodservice.dart';
import 'package:BhansaGharChef/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String id;
  String chefname;
  String chefUsername;
  String location;
  String account;
  String contact;
  String password;

  setChefDetailValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    id = prefs.getString("id");
    chefname = prefs.getString("name");
    chefUsername = prefs.getString("username");

    location = prefs.getString("location");
    account = prefs.getString("account");
    contact = prefs.getString("contact");
    print("this is the $chefname");
    setState(() {});
    // print('add food token$token');
  }

  @override
  void initState() {
    super.initState();
    setChefDetailValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    return // FutureBuilder<dynamic>(
        //     future: setChefDetailValuesSF(), //AuthService().getChefDetails(token),
        //     builder: (context, chefSnap) {
        //       if (chefSnap.connectionState == ConnectionState.done &&
        //           chefSnap.data != null) {
        //         Chef chefData = chefSnap.data;

        //         return
        WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushNamed('/main-screen');
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              // color: Colors.lightBlue,
              padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 150,
                          height: 150,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                        // Container(
                        //   height: 120.0,
                        //   width: 120.0,
                        //   decoration: BoxDecoration(
                        //     color: Colors.red,
                        //     borderRadius: BorderRadius.circular(60.0),
                        //     boxShadow: [
                        //       BoxShadow(
                        //           blurRadius: 3.0,
                        //           offset: Offset(0, 4.0),
                        //           color: Colors.black38)
                        //     ],
                        //     image: DecorationImage(
                        //       image: AssetImage('assets/images/food1.jpg'),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: 20.0,
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              // 'Sammy',
                              chefname ?? "name",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              //'1234657',
                              //(chefData.contact).toString(),
                              contact ?? "lolala",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditChefDetails(
                                        chefData: RegisterModel(
                                            firstName: chefname,
                                            //lastName: ,
                                            username: chefUsername,
                                            //   email: chefmail,
                                            password: password,
                                            contact: contact,
                                            account: account),
                                      ),
                                    ));
                              },
                              child: Container(
                                  height: 25.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context).accentColor),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Center(
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 16.0),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      //'sam123',
                      chefUsername ?? "username",
                      // chefData.username,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            CustomListTile(
                              icon: Icons.location_on,
                              title: 'Location',
                              text: //'Location',
                                  location ?? "lol",
                            ),
                            Divider(
                              height: 5.0,
                              color: Colors.grey,
                            ),
                            CustomListTile(
                              icon: Icons.visibility,
                              title: 'Change Password',
                              text: 'Change Password',
                            ),
                            Divider(
                              height: 5.0,
                              color: Colors.grey,
                            ),
                            CustomListTile(
                                icon: Icons.payment,
                                title: 'Account No.',
                                text: //'account',
                                    'Ac. NO. ${account ?? "account"}'
                                //'AC.no. ${chefData.account}',
                                ),
                          ],
                        ),
                      ),
                    ),
                    /*  Container(
                        color: Colors.red,
                        alignment: Alignment.bottomRight,
                        child: FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.exit_to_app),
                            label: Text('Log Out')),
                      ) */
                  ]),
            ),
            Container(
              height: 60.0,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              // color:Colors.yellow,
              alignment: Alignment.bottomRight,
              child: FlatButton.icon(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    //Return String
                    Future<bool> token = prefs.setString("token", null);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => LogIn()));
                  },
                  icon: Icon(Icons.exit_to_app),
                  label: Text('Log Out')),
            ),
          ]),
        ),
      ),
      // child: Scaffold(
      //   body: Container(
      //       color: Colors.lightBlue,
      //       padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Text(
      //             'Profile',
      //             style: TextStyle(
      //               fontSize: 32.0,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           Container(
      //             height: 120.0,
      //             width: 120.0,
      //             decoration: BoxDecoration(
      //               color: Colors.red,
      //               borderRadius: BorderRadius.circular(60.0),
      //               boxShadow: [
      //                 BoxShadow(
      //                     blurRadius: 3.0,
      //                     offset: Offset(0, 4.0),
      //                     color: Colors.black38)
      //               ],
      //             ),
      //             child: Icon(
      //               Icons.person,
      //               size: 60.0,
      //             ),
      //           ),
      //           Container(
      //             height: 102.0,
      //             padding: EdgeInsets.only(left: 20.0, right: 20.0),
      //             // color:Colors.yellow,
      //             alignment: Alignment.bottomRight,
      //             child: FlatButton.icon(
      //                 onPressed: () async {
      //                   SharedPreferences prefs =
      //                       await SharedPreferences.getInstance();
      //                   //Return String
      //                   Future<bool> token = prefs.setString("token", null);
      //                   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (BuildContext context) => LogIn()));
      //                 },
      //                 icon: Icon(Icons.exit_to_app),
      //                 label: Text('Log Out')),
      //           ),
      //         ],
      //       )),
      // )
    );
    // } else {
    //   return Container(
    //     child: Center(
    //       child: Text('no chef logged in'),
    //     ),
    //   );
    // }
  }
// futurebuilder end );
}
