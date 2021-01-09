import 'package:chat_app/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key key,
    @required this.contactsBloc,
    @required this.uId,
    @required this.databaseReference,
    @required this.context,
    @required this.contact,
  }) : super(key: key);

  final ContactsBloc contactsBloc;
  final String uId;
  final DatabaseReference databaseReference;
  final BuildContext context;
  final User contact;

  @override
  Widget build(BuildContext context) {
    contactsBloc.add(GetContactStatus(id: contact.id));
    if (contact.id == uId) {
      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Material(
                    child: contact.image != null
                        ? CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.appColorSelector[800]),
                              ),
                              width: 75.0,
                              height: 75.0,
                              padding: EdgeInsets.all(20.0),
                            ),
                            imageUrl: contact.image,
                            width: 75.0,
                            height: 75.0,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 75.0,
                            color: Colors.grey[900],
                          ),
                    borderRadius: BorderRadius.all(Radius.circular(37.5)),
                    clipBehavior: Clip.hardEdge,
                  ),
                  Material(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: StreamBuilder(
                        stream: databaseReference.child(contact.id).onValue,
                        builder: (context, snap) {
                          if (snap.hasData &&
                              !snap.hasError &&
                              snap.data.snapshot.value != null) {
                            Map data = snap.data.snapshot.value;
                            if (data["status"] == "Online") {
                              return Icon(
                                Icons.circle,
                                size: 20.0,
                                color: Colors.green,
                              );
                            } else {}
                          }
                          return Icon(
                            Icons.circle,
                            size: 20.0,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    clipBehavior: Clip.hardEdge,
                  ),
                ],
              ),
              Flexible(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Nickname: ${contact.nickname ?? 'Not Defined'}',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          child: Text(
                            'E-mail: ${contact.email}',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          alignment: Alignment.centerLeft,
                        )
                      ],
                    ),
                  ),
                  //margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, Constants.chatScreen,
                arguments: [contact.id, contact.email]);

            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          peerId: contact.id,
                          peerEmail: contact.email,
                        )));*/
          },
          color: AppTheme.semiLightGrey,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}
