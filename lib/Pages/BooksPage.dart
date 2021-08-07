import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/BooksGetXController.dart';
import 'package:mh_care/CustomWidgets/ErrorWidget.dart';
import 'package:mh_care/Model/Book/Book.dart';
import 'package:mh_care/Pages/AddBookPage.dart';
import 'package:mh_care/Pages/PDFViewer.dart';

class BooksPage extends StatelessWidget {
  String _categoryId="";
  BooksPage({String categoryId}):this._categoryId=categoryId;
  @override
  Widget build(BuildContext context) {
    BooksGetXController controller =
    Get.put(BooksGetXController(
      categoryId: _categoryId,
    ));
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Get.theme.primaryColor,
          foregroundColor: Get.theme.accentColor,
          child: Icon(Icons.add),
          onPressed: () {
            //TODO: Go To add book page;
            Get.to(()=>AddBookPage("HnJeMxfNxJX441Zqu4ahMcVrqHs2"));
          },
        ),
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          centerTitle: true,
          elevation: 0,
          title: Text('Books List'),
        ),
        body: StreamBuilder<List<Book>>(
            stream: controller.getBookStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                printError(info: snapshot.error);
                Get.snackbar("Error", "Error While Getting Data");
                return Center(
                    child: MyErrorWidget(errorMessage: "Error While Getting Data"));
                // return Container(
                //   child: Column(
                //     children: [
                //       Image.asset("assets/images/error.png"),
                //     Text("Error While Getting Data"),
                //     ],
                //   ),
                // );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var books = snapshot.data;
                  if (books.isNotEmpty) {
                    // return ListView.builder(
                    //     itemCount: books.length,
                    //     itemBuilder: (context, i) {
                    //       return CategoryListItem(
                    //         category: books[i],
                    //       );
                    //     });
                    return Center(child: Text("books"));
                    //TODO: un comment
                    // return GridView.builder(
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     mainAxisExtent: 270,
                    //     childAspectRatio: 5,
                    //     mainAxisSpacing: 2,
                    //     crossAxisSpacing: 2,
                    //   ),
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //               // BookView(snapshot.data.documents[index]),
                    //               PDFViewerCachedFromUrl(
                    //                 url: snapshot.data.documents[index]['pdfurl'],
                    //                 name: snapshot.data.documents[index]
                    //                 ['bookName'],
                    //               )),
                    //         );
                    //       },
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15.0),
                    //         child: CachedNetworkImage(
                    //           imageUrl: snapshot.data.documents[index]['imageurl'],
                    //           fit: BoxFit.cover,
                    //           progressIndicatorBuilder:
                    //               (context, url, downloadProgress) => Center(
                    //             child: CircularProgressIndicator(
                    //                 value: downloadProgress.progress),
                    //           ),
                    //           errorWidget: (context, url, error) => Icon(Icons.error),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   itemCount: snapshot.data.documents.length,
                    // );
                  } else {
                    return Center(child: MyErrorWidget(errorMessage: "No Data"));
                  }
                }
              }
              // if (!snapshot.hasData) {
              //   return Center(child: const Text('Loading Books...'));
              // }
              //
            }));
  }
}


// class BookList extends StatefulWidget {
//   // DocumentSnapshot doc;
//   String _categoryId;
//   BookList({String categoryId}):this._categoryId=categoryId;
//   @override
//   _BookListState createState() => _BookListState();
// }
//
// class _BookListState extends State<BookList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           centerTitle: true,
//           elevation: 0,
//           title: Text('Books List'),
//         ),
//         body: new StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection("books")
//                 .doc('${widget.doc.id}')
//                 .collection('Books')
//                 .snapshots(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: const Text('Loading Books...'));
//               }
//               return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisExtent: 270,
//                   childAspectRatio: 5,
//                   mainAxisSpacing: 2,
//                   crossAxisSpacing: 2,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                             // BookView(snapshot.data.documents[index]),
//                             PDFViewerCachedFromUrl(
//                               url: snapshot.data.documents[index]['pdfurl'],
//                               name: snapshot.data.documents[index]
//                               ['bookName'],
//                             )),
//                       );
//                     },
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15.0),
//                       child: CachedNetworkImage(
//                         imageUrl: snapshot.data.documents[index]['imageurl'],
//                         fit: BoxFit.cover,
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) => Center(
//                           child: CircularProgressIndicator(
//                               value: downloadProgress.progress),
//                         ),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       ),
//                     ),
//                   );
//                 },
//                 itemCount: snapshot.data.documents.length,
//               );
//             }));
//   }
// }
