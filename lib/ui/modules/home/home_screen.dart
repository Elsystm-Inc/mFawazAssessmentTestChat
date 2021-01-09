import 'dart:async';
import 'dart:io';
import 'package:chat_app/bloc/user_bloc/user_bloc.dart';
import 'package:chat_app/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:chat_app/ui/common/loading_two.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ui/modules/home/contact_card.widget.dart';
import '../../../main.dart';

class HomeScreen extends StatefulWidget {
  final String uId;

  HomeScreen({
    Key key,
    @required this.uId,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(uId: uId);
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  _HomeScreenState({@required this.uId});
  UserBloc userBloc;
  ContactsBloc contactsBloc;
  String uId;
  String userToken;

  final DatabaseReference databaseReference =
      FirebaseDatabase(databaseURL: Constants.realtimeDbUrl).reference();

  bool isLoading = false;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    contactsBloc = BlocProvider.of<ContactsBloc>(context);
    userBloc.add(
      SetStatusEvent(
        status: "Online",
      ),
    );
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    userBloc.add(SetupPushNotificationsEvent());
    contactsBloc.add(GetContactsEvent());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<UserBloc>(context).add(
        SetStatusEvent(
          status: "Online",
        ),
      );
    } else if (state == AppLifecycleState.inactive) {
      BlocProvider.of<UserBloc>(context).add(
        SetStatusEvent(
          status: "Offline",
        ),
      );
    }
  }

  /*Future<bool> onBackPress() {
    openDialog(ctx);
    return Future.value(false);
  }*/

  Future<Null> openDialog(BuildContext homeContext) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocListener<UserBloc, UserState>(
            cubit: userBloc,
            listener: (context, state) {
              if (state is StatusSettedState) {
                Navigator.pop(context, 1);
              }
            },
            child: SimpleDialog(
              contentPadding:
                  EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
              children: <Widget>[
                Container(
                  color: Colors.orange,
                  margin: EdgeInsets.only(bottom: 4.0),
                  padding: EdgeInsets.only(bottom: 4.0, top: 10.0),
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.exit_to_app,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0),
                      ),
                      Text(
                        'Exit app',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Are you sure to exit app?',
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.orange,
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      Text(
                        'CANCEL',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    userBloc.add(SetStatusEvent(
                      status: "Offline",
                    ));
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.orange,
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      Text(
                        'YES',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  void handleSignOut() {
    this.setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.removeObserver(this);
    userBloc.add(
      SetStatusEvent(
        status: "Offline",
      ),
    );
    userBloc.add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoggedOutState) {
          isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyApp()),
              (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.appColorSelector[800],
          title: Text(
            'Users',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              child: IconButton(
                padding: EdgeInsets.all(15),
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: handleSignOut,
              ),
            ),
          ],
        ),
        body: WillPopScope(
          child: Stack(
            children: <Widget>[
              // List
              BlocBuilder<ContactsBloc, ContactsState>(
                buildWhen: (previous, current) {
                  if (current is ContactsStatusLoadedState) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  if (state is ContactStreamLoadedState) {
                    return Container(
                      child: StreamBuilder(
                        stream: state.contactStream,
                        builder: (context, AsyncSnapshot<List<User>> snapshot) {
                          print(snapshot.toString());

                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orange),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              itemBuilder: (context, index) {
                                return ContactCard(
                                    contactsBloc: contactsBloc,
                                    uId: uId,
                                    databaseReference: databaseReference,
                                    context: context,
                                    contact: snapshot.data[index]);
                              },
                              itemCount: snapshot.data.length,
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    );
                  }
                },
              ),

              // Loading
              Positioned(
                child: isLoading ? const Loading() : Container(),
              )
            ],
          ),
          onWillPop: () {
            openDialog(this.context);
            return Future.value(false);
          },
        ),
      ),
    );
  }
}
