import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:mh_care/Controller/BooksGetXController.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/CustomWidgets/ErrorWidget.dart';
import 'package:mh_care/Functions/createDynamicLink.dart';
import 'package:mh_care/Model/Book/Book.dart';
import 'package:mh_care/Model/Category/Category.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:mh_care/Pages/AddBookPage.dart';
import 'package:mh_care/Pages/PDFViewer.dart';
import 'package:share/share.dart';

class BooksPage extends StatelessWidget {
  Category _category;

  BooksPage({Category category}) {
    this._category = category;
  }

  @override
  Widget build(BuildContext context) {
    // print(_category.name);
    BooksGetXController controller = Get.put(BooksGetXController(
      category: _category,
    ));
    GlobalDataGetXController prefController = Get.find();
    return Scaffold(
        floatingActionButton: prefController.pref
                    .getString(UserData.USER_ROLE)
                    .compareTo(UserData.USER_ROLE_CUSTOMER) ==
                0
            ? Container(
                height: 0,
                width: 0,
              )
            : FloatingActionButton(
                backgroundColor: Get.theme.primaryColor,
                foregroundColor: Get.theme.accentColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Get.to(() => AddBookPage(
                        category: _category,
                      ));
                },
              ),
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          centerTitle: true,
          elevation: 0,
          title:_category!=null ? Text('${_category.name.capitalizeFirst} Books List'):Text('Books List'),
        ),
        body: FutureBuilder<List<Book>>(
            future: controller.getBooks(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                // printError(info: snapshot.error);
                // Get.snackbar("Error", "Error While Getting Data");
                return Center(
                    child: MyErrorWidget(
                        errorMessage: "Error While Getting Data"));
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
                  // controller.isLoading = true;
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
                    // return Center(child: Text("books"));
                    // controller.isLoading = false;

                    return ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: books.length,
                        itemBuilder: (context, i) {
                          return BookListItem(book: books[i], controller: controller);
                        });
                    // return GridView.builder(
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     mainAxisExtent: 270,
                    //     childAspectRatio: 5,
                    //     mainAxisSpacing: 2,
                    //     crossAxisSpacing: 2,
                    //   ),
                    //   itemBuilder: (BuildContext context, int i) {
                    //     return GestureDetector(
                    //       onTap: () {
                    //         Get.to(() => PDFViewerCachedFromUrl(
                    //               url: snapshot.data[i].pdfUrl,
                    //               name: snapshot.data[i].bookName,
                    //             ));
                    //         // Navigator.push(
                    //         //   context,
                    //         //   MaterialPageRoute(
                    //         //       builder: (context) =>
                    //         //       // BookView(snapshot.data.documents[index]),
                    //         //       PDFViewerCachedFromUrl(
                    //         //         url: snapshot.data.documents[index]['pdfurl'],
                    //         //         name: snapshot.data.documents[index]
                    //         //         ['bookName'],
                    //         //       )),
                    //         // );
                    //       },
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15.0),
                    //         child: CachedNetworkImage(
                    //           imageUrl: books[i].imageUrl,
                    //           fit: BoxFit.cover,
                    //           progressIndicatorBuilder:
                    //               (context, url, downloadProgress) => Center(
                    //             child: CircularProgressIndicator(
                    //                 value: downloadProgress.progress),
                    //           ),
                    //           errorWidget: (context, url, error) =>
                    //               Icon(Icons.error),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   itemCount: snapshot.data.length,
                    // );
                  } else {
                    return Center(
                        child: MyErrorWidget(errorMessage: "No Data"));
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

class BookListItem extends StatelessWidget {
  const BookListItem({
    Key key,
    @required this.book,
    @required this.controller,
  }) : super(key: key);

  final Book book;
  final BooksGetXController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Get.to(() => PDFViewerCachedFromUrl(
                    url: book.pdfUrl,
                    name:book.bookName,
                  ));
            },
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  width: 110,
                  imageUrl: book.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                          Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                ),
                Expanded(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          book.bookName,
                          style: Get.textTheme.headline6,
                        ),
                        Text(
                          book.details,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 4,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceAround,
                          children: [
                            LikeButton(
                              isLiked: book.bookLikesList.contains(FirebaseAuth.instance.currentUser.uid),
                              size: 30,
                              circleColor: CircleColor(
                                start:
                                    Get.theme.accentColor,
                                end: Get
                                    .theme.primaryColor,
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor:
                                    Get.theme.accentColor,
                                dotSecondaryColor: Get
                                    .theme.primaryColor,
                              ),
                              onTap: (isLiked)async{
                                if (!isLiked){
                                  //TODO: Add Like
                                  return controller.like(book);
                                }
                                else {
                                  //TODO: Remove Like
                                  return controller.dislike(book);

                                }
                              },
                              likeBuilder:
                                  (bool isLiked) {
                                return Icon(
                                  Icons.thumb_up_alt,
                                  color: isLiked
                                      ? Get.theme
                                          .primaryColor
                                      : Colors.grey,
                                  size: 30,
                                );
                              },
                              likeCount: book.numberOfLikes,
                              countBuilder: (int count,
                                  bool isLiked,
                                  String text) {
                                var color = isLiked
                                    ? Get.theme
                                        .primaryColor
                                    : Colors.grey;
                                Widget result;
                                if (count == 0) {
                                  result = Text(
                                    "like",
                                    style: TextStyle(
                                        color: color),
                                  );
                                } else
                                  result = Text(
                                    text,
                                    style: TextStyle(
                                        color: color),
                                  );
                                return result;
                              },
                            ),
                            IconButton(
                              onPressed: () async {
                                var link = await createDynamicLink(book.id);
                                Share.share('check out these notes on notes and more app $link', subject: 'Look what I made!');
                              },
                              icon: Icon(
                                Icons.share,
                                size: 30,
                                color: Get.theme.accentColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
                )
              ],
            ),
          )),
    );
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
