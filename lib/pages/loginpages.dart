import 'package:citizens/pages/mainMenu.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatefulWidget {
  @override
  State < StatefulWidget > createState() => LoginPagesState();

}

class LoginPagesState extends State < LoginPages > {
  final _scaffoldKey = GlobalKey < ScaffoldState > ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue[900],
                Colors.blue[900],
                Colors.blue[700],
              ])
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: < Widget > [
              SizedBox(height: 40, ),
              Padding(
                padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: < Widget > [
                      Text('Login', style: TextStyle(color: Colors.white, fontSize: 40), ),
                      SizedBox(height: 20, ),
                      Text('Citizen Mobile Apps', style: TextStyle(color: Colors.white, fontSize: 20), ),
                    ],
                  ),
              ),
              SizedBox(height: 20, ),
              Container(
                child: Container(
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: < Widget > [
                            SizedBox(height: 40, ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue[900],
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                  )
                                ]
                              ),
                              child: Column(
                                children: < Widget > [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20, ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.blue[900]
                                ),
                                child: Center(child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white), )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}