import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/BooksCategoryGetXController.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/Model/Category/Category.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:mh_care/Pages/AddBooksCategoryPage.dart';
import 'package:mh_care/Pages/BooksPage.dart';
import 'package:mh_care/CustomWidgets/ErrorWidget.dart';

class BooksCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BooksCategoryGetXController controller =
        Get.put(BooksCategoryGetXController());
    SharedPreferencesGetXController prefController = Get.find();
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
                Get.to(() => AddBooksCategoryPage());
              },
            ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Get.theme.primaryColor,
        title: Text('Books Categories'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                // fit: BoxFit.cover,
                repeat: ImageRepeat.repeatY,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstIn),
                alignment: Alignment.bottomCenter,
                image: AssetImage(
                  'assets/oldImages/books.png',
                ))),
        child: new StreamBuilder<List<Category>>(
          stream: controller.getCategoryStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Get.snackbar("Error", "Error While Getting Data");
              return Center(
                  child:
                      MyErrorWidget(errorMessage: "Error While Getting Data"));
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
                var categories = snapshot.data;
                if (categories.isNotEmpty) {
                  return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        return CategoryListItem(
                          category: categories[i],
                        );
                      });
                } else {
                  return Center(child: MyErrorWidget(errorMessage: "No Data"));
                }
              }
            }
          },
          // stream: FirebaseFirestore.instance.collection("books").snapshots(),
          // builder:
          //     (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //   if (!snapshot.hasData) return new Text("There is no Books");
          //   return new ListView(children: getBooksList(snapshot, context));
        ),
      ),
    );
  }

// getBooksList(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
//   return snapshot.data.docs
//       .map((doc) => GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => BookList(doc)),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: new ListTile(
//                   leading: Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage('assets/oldImages/open-book.png'),
//                       ),
//                     ),
//                   ),
//                   title: new Text(
//                     doc.id,
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ))
//       .toList();
// }
}

class CategoryListItem extends StatelessWidget {
  Category _category;

  CategoryListItem({
    Key key,
    @required category,
  })  : this._category = category,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Go to Book List
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => BookList(doc)),
        // );
        print("CategoryListItem:${_category.name}");
        Get.to(() => BooksPage(category: _category));
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
                  image: AssetImage('assets/oldImages/open-book.png'),
                ),
              ),
            ),
            title: new Text(
              _category.name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
