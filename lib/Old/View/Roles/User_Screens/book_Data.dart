import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mh_care/View/Roles/User_Screens/PDFViewer.dart';

class BookList extends StatefulWidget {
  DocumentSnapshot doc;
  BookList(this.doc);
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text('Books List'),
        ),
        body: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("books")
                .doc('${widget.doc.id}')
                .collection('Books')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: const Text('Loading Books...'));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 270,
                  childAspectRatio: 5,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // BookView(snapshot.data.documents[index]),
                                PDFViewerCachedFromUrl(
                                  url: snapshot.data.documents[index]['pdfurl'],
                                  name: snapshot.data.documents[index]
                                      ['bookName'],
                                )),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data.documents[index]['imageurl'],
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.documents.length,
              );
            }));
  }
}
