import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  ScrollController _hideButtonController;

var _isVisible;
  @override
  initState(){
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener((){
      if(_hideButtonController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible == true) {
            /* only set when the previous state is false
             * Less widget rebuilds 
             */
            print("**** ${_isVisible} up"); //Move IO away from setState
            setState((){
              _isVisible = false;
            });
        }
      } else {
        if(_hideButtonController.position.userScrollDirection == ScrollDirection.forward){
          if(_isVisible == false) {
              /* only set when the previous state is false
               * Less widget rebuilds 
               */
               print("**** ${_isVisible} down"); //Move IO away from setState
               setState((){
                 _isVisible = true;
               });
           }
        }
    }});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      /*  floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow[700],
          onPressed: () {
            Navigator.of(context).pushNamed('/add-food');
          },
        ), */
          floatingActionButton: new Visibility( 
        visible: _isVisible,
        child: new FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/add-food');
          },
          backgroundColor: Colors.yellow[700],
          child: new Icon(Icons.add),
        ),     
      ),
        appBar: AppBar(
          title: Text(
            'My Menu',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: ListView.builder(
          controller: _hideButtonController,
            itemCount: 4,
            itemBuilder: (ctx, i) => Card(
                  elevation: 5.0,
                  child: Stack(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      height: 130.0,
                      width: deviceSize.width,
                      //  color: Colors.red
                    ),
                    Positioned(
                      left: 10.0,
                      top: 10.0,
                      bottom: 10.0,
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        height: 130.0,
                        width: 110.0,
                        //   width:deviceSize.width/3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55.0),
                          //  color: Colors.blue
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55.0),
                            child: Image.asset(
                              'assets/images/bara.jpg',
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Positioned(
                      left: 140.0,
                      top: 10.0,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        height: 130.0,
                        width: 210.0,
                        //  color: Colors.yellow,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Bara',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  Text(
                                    'Rs. 50',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Container(
                                height: 65.0,
                                //  color: Colors.blue,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                      'Plain bara made with maas comes with tomato chatney.'),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                    onTap: () {},
                                  ),
                                  SizedBox(width:5),
                                  InkWell(
                                      onTap: () {}, 
                                      child: Icon(
                                        Icons.delete
                                        )
                                        ),
                                ],
                              ),
                            ]),
                      ),
                    )
                  ]),
                )));
  }
}
