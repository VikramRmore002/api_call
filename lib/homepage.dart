import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


class Homepage extends StatefulWidget {
  final  String title ;
  const Homepage({Key? key, required this.title}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String url = "https://randomuser.me/api/?results=50";
  late List  data ;
  bool isLoading = true;



  Future? getResponce () async {
    var responce = await http.get(Uri.parse(url));
    // print( "print data + ${responce.body}");

    var decodedData = jsonDecode(responce.body)["results"];

    setState(() {
      data = decodedData;
      isLoading = false;
      print("data + ${data}");
    });
  }
  @override
  void initState() {
    super.initState();
    this.getResponce ();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
            itemCount: data.isEmpty ? 0 : data.length ,
            itemBuilder: (  BuildContext context , int index ){
              return SingleChildScrollView(
                child : Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Image(
                            height: 50.0,
                            width: 50.0,
                            fit: BoxFit.contain,
                            image: NetworkImage(data[index]["picture"]["thumbnail"])),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row( children: <Widget>[
                                Icon(Icons.person),
                                Text(
                                  data[index]["name"]["first"]
                                      + " " +
                                      data[index]["name"]["last"],
                                  style: const TextStyle(
                                    fontSize: 20.0,fontWeight: FontWeight.bold,
                                  ),),
                              ],

                              ),
                              //  Icon(Icons.person),
                              // Text(
                              //   data[index]["name"]["first"]
                              //       + " " +
                              //       data[index]["name"]["last"],
                              // style: const TextStyle(
                              //   fontSize: 20.0,fontWeight: FontWeight.bold,
                              // ),),

                              Row(

                                  children: <Widget>[
                                    Expanded (
                                        child:Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Icon(Icons.email),
                                              Text("Email: ${ data[index]["email"]}")]))]),


                              Row( children: <Widget>[
                                Icon(Icons.male),
                                Text("Gender: ${ data[index]["gender"]}")],),
                              Row( children: <Widget>[
                                Icon(Icons.phone),
                                Text("Phone: ${ data[index]["phone"]}")],)
                              // Text( data[index]["gender"]),
                              // Text( data[index]["phone"]),
                            ],
                          ))
                    ],
                  ),
                ),
              );},
          ),
        ),
      ),
    );
  }
}
