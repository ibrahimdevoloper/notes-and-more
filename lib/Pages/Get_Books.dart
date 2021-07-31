import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mh_care/Pages/book_Data.dart';


class GetBooksCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Books Categories'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                // fit: BoxFit.cover,
                repeat: ImageRepeat.repeatY,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstIn),
                alignment: Alignment.bottomCenter,
                image: AssetImage(
                  'assets/books.png',
                ))),
        child: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("books").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no Books");
              return new ListView(children: getBooksList(snapshot, context));
            }),
      ),
    );
  }

  getBooksList(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return snapshot.data.docs
        .map((doc) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookList(doc)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: new ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/open-book.png'),
                        ),
                      ),
                    ),
                    title: new Text(
                      doc.id,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }
}
