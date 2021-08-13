import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/AddBooksGetXController.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/Functions/myImagePicker.dart';
import 'package:mh_care/Model/Category/Category.dart';
import 'package:mh_care/Model/UserData/UserData.dart';

class AddBookPage extends StatelessWidget {
  Category category;

  AddBookPage({Category category}) {
    this.category = category;
  }

  // final bookNameController = TextEditingController();
  // final bookCategoryController = TextEditingController();
  // bool _nameValidate = false;
  // bool _categoryValidate = false;
  //
  // String imageUrl;
  // String imagePath;
  // String pdfUrl;

  // Stream<DocumentSnapshot> provideDocumentFieldStream() {
  //   return FirebaseFirestore.instance
  //       // .collection('admin')
  //       .collection('user')
  //       .doc(currentUserId)
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    // print(category.name);
    GlobalDataGetXController prefController = Get.find();
    var controller = Get.put(AddBooksGetXController(category));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Add Book'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Get.theme.primaryColor,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 250,
                // color: Colors.lightBlueAccent,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.darken),
                        image: AssetImage('assets/oldImages/thom.jpg'))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.white),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/oldImages/user.png'))),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          prefController.pref.getString(UserData.USER_NAME),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Text(
                        prefController.pref.getString(UserData.USER_EMAIL),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GetBuilder<AddBooksGetXController>(
                  init: controller,
                  builder: (controller) {
                    return TextField(
                      // controller: bookNameController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Book Name',
                        errorText: controller.isNameError
                            ? 'Please Enter a Correct Name'
                            : null,
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onChanged: (value) {
                        controller.name = value;
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GetBuilder<AddBooksGetXController>(
                  init: controller,
                  builder: (controller) {
                    return TextField(
                      // controller: bookNameController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      minLines: 2,
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Book Details',
                        errorText: controller.isDetailsError
                            ? 'Please Enter a Correct Name'
                            : null,
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onChanged: (value) {
                        controller.details = value;
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GetBuilder<AddBooksGetXController>(
                  init: controller,
                  builder: (controller) {
                    return TextField(
                      // controller: bookCategoryController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Book Dropbox Url',
                          errorText: controller.isPdfUrlError
                              ? 'Enter a Correct Dropbox Link'
                              : null,
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.info_outline_rounded),
                            color: Colors.black54,
                            onPressed: () {
                              Get.bottomSheet(
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Please Add A File With This URL Format",
                                            style: Get.textTheme.headline6,
                                          ),
                                          Text(
                                            "https://www.dropbox.com/s/8i1vv76racw7z6r/1.pdf?dl=1",
                                            style: Get.textTheme.bodyText1,
                                          ),
                                          Text(
                                            "And Please Make sure that dl=1 bc it makes the link a direct one",
                                            style: Get.textTheme.headline6,
                                          ),
                                          Text(
                                            "And Please Make sure that file has PDF format",
                                            style: Get.textTheme.headline6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.white);
                            },
                          )),
                      onChanged: (value) {
                        controller.pdfUrl = value;
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GetBuilder<AddBooksGetXController>(
                    init: controller,
                    builder: (controller) {
                      if (controller.isCategoryLoading) {
                        return CircularProgressIndicator();
                      } else {
                        controller.categories.map((e) {
                          print("dropbox");
                          print("${e.name}|${e.id}");
                        });
                        return DropdownButton<String>(
                          isExpanded: true,
                          value: controller.selectedCategoryId != null
                              ? controller.selectedCategoryId
                              : null,
                          hint: Text("Please Select Category"),
                          items: controller.categories.map((e) {
                            print("${e.name}|${e.id}");
                            return DropdownMenuItem<String>(
                              child: Text(e.name),
                              value: e.id,
                            );
                          }).toList(),
                          onChanged: (value) {
                            print(value);
                            var i = controller.categories.indexWhere((element){
                              return element.id.compareTo(value)==0;
                            });
                            controller.category=controller.categories[i];
                            controller.selectedCategoryId = value;
                          },
                        );
                      }
                    }),
              ),
              // getButtons(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: GestureDetector(
                  onTap: () async {
                    // uploadImage();
                    var imagePath = await myImagePicker();
                    controller.coverImagePath = imagePath;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(
                                2,
                                3,
                              ))
                        ]),
                    child: Text(
                      'Upload Cover Image',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 8,
              //     horizontal: 16,
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       //TODO: modify this
              //       // getPdfAndUpload();
              //     },
              //     child: Container(
              //       padding: EdgeInsets.symmetric(vertical: 13),
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(20),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.black12,
              //                 spreadRadius: 2,
              //                 blurRadius: 3,
              //                 offset: Offset(
              //                   2,
              //                   3,
              //                 ))
              //           ]),
              //       child: Text(
              //         'Upload PDF',
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 8,
              //     horizontal: 16,
              //   ),
              //   child: Text(
              //     imageUrl == null && pdfUrl == null
              //         ? 'Must Upload Cover Photo and PDF File'
              //         : pdfUrl == null
              //             ? ' Must Upload PDF File '
              //             : imageUrl == null
              //                 ? ' Must Upload Cover Photo '
              //                 : 'Alls Set',
              //     style: TextStyle(
              //         color: imageUrl == null || pdfUrl == null
              //             ? Colors.red
              //             : Colors.green),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: GetBuilder<AddBooksGetXController>(
                  init: controller,
                  builder: (controller) {
                    if (controller.isLoading)
                      return CircularProgressIndicator();
                    else
                      return GestureDetector(
                        onTap: () {
                          if (controller.validator())
                            Get.snackbar(
                                "Error", "Please Check Your Entered Info");
                          else
                            controller.addBook();
                          // setState(() {
                          // bookCategoryController.text.isEmpty
                          //     ? _categoryValidate = true
                          //     : _categoryValidate = false;
                          // bookNameController.text.isEmpty
                          //     ? _nameValidate = true
                          //     : _nameValidate = false;
                          // });
                          // if (_nameValidate == false &&
                          //     _categoryValidate == false &&
                          //     imageUrl != null) {
                          //   FirebaseFirestore.instance
                          //       .collection('books')
                          //       .doc('${bookCategoryController.text}')
                          //       .set(
                          //     {
                          //       'category': bookCategoryController.text,
                          //     },
                          //   ).then((value) {
                          //     //Do your stuff.
                          //   });
                          //   FirebaseFirestore.instance
                          //       .collection('books')
                          //       .doc('${bookCategoryController.text}')
                          //       .collection('Books')
                          //       .doc()
                          //       .set(
                          //     {
                          //       'bookName': bookNameController.text,
                          //       'category': bookCategoryController.text,
                          //       'imageurl': imageUrl,
                          //       'pdfurl': pdfUrl
                          //     },
                          //   ).then((value) {
                          //     //Do your stuff.
                          //   });
                          //
                          //   bookCategoryController.clear();
                          //   bookNameController.clear();
                          //   Navigator.pop(context);
                          // }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(
                                      2,
                                      3,
                                    ))
                              ]),
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  // Column getData(double _height, Map<String, dynamic> documentFields) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: _height * 0.4,
  //         // color: Colors.lightBlueAccent,
  //         decoration: BoxDecoration(
  //             image: DecorationImage(
  //                 fit: BoxFit.cover,
  //                 colorFilter: new ColorFilter.mode(
  //                     Colors.black.withOpacity(0.4), BlendMode.darken),
  //                 image: AssetImage('assets/oldImages/thom.jpg'))),
  //         child: Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 height: 80,
  //                 width: 80,
  //                 decoration: BoxDecoration(
  //                     color: Colors.white24,
  //                     shape: BoxShape.circle,
  //                     border: Border.all(width: 2, color: Colors.white),
  //                     image: DecorationImage(
  //                         fit: BoxFit.cover,
  //                         image: AssetImage('assets/oldImages/user.png'))),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(vertical: _height * .01),
  //                 child: Text(
  //                   documentFields['name'],
  //                   style:
  //                       TextStyle(color: Colors.white, fontSize: _height * .03),
  //                 ),
  //               ),
  //               Text(
  //                 documentFields['email'],
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               SizedBox(
  //                 height: _height * .03,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(
  //             horizontal: displayWidth(context) * 0.02,
  //             vertical: _height * 0.01),
  //         child: TextField(
  //             controller: bookNameController,
  //             keyboardType: TextInputType.text,
  //             autofocus: false,
  //             textInputAction: TextInputAction.next,
  //             decoration: InputDecoration(
  //               fillColor: Colors.white,
  //               filled: true,
  //               labelText: 'Book Name',
  //               errorText: _nameValidate ? 'Name Can\'t Be Empty' : null,
  //               border: OutlineInputBorder(),
  //               contentPadding: EdgeInsets.symmetric(
  //                   horizontal: displayWidth(context) * 0.02,
  //                   vertical: _height * 0.02),
  //             )),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(
  //             horizontal: displayWidth(context) * 0.02,
  //             vertical: _height * 0.01),
  //         child: TextField(
  //             controller: bookCategoryController,
  //             keyboardType: TextInputType.text,
  //             autofocus: false,
  //             textInputAction: TextInputAction.next,
  //             decoration: InputDecoration(
  //               fillColor: Colors.white,
  //               filled: true,
  //               labelText: 'Book Category',
  //               errorText:
  //                   _categoryValidate ? 'Category Can\'t Be Empty' : null,
  //               border: OutlineInputBorder(),
  //               contentPadding: EdgeInsets.symmetric(
  //                   horizontal: displayWidth(context) * 0.02,
  //                   vertical: _height * 0.02),
  //             )),
  //       ),
  //       getButtons(),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 10),
  //         child: Text(
  //           imageUrl == null && pdfUrl == null
  //               ? 'Must Upload Cover Photo and PDF File'
  //               : pdfUrl == null
  //                   ? ' Must Upload PDF File '
  //                   : imageUrl == null
  //                       ? ' Must Upload Cover Photo '
  //                       : 'Alls Set',
  //           style: TextStyle(
  //               color: imageUrl == null || pdfUrl == null
  //                   ? Colors.red
  //                   : Colors.green),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             bookCategoryController.text.isEmpty
  //                 ? _categoryValidate = true
  //                 : _categoryValidate = false;
  //             bookNameController.text.isEmpty
  //                 ? _nameValidate = true
  //                 : _nameValidate = false;
  //           });
  //           if (_nameValidate == false &&
  //               _categoryValidate == false &&
  //               imageUrl != null) {
  //             FirebaseFirestore.instance
  //                 .collection('books')
  //                 .doc('${bookCategoryController.text}')
  //                 .set(
  //               {
  //                 'category': bookCategoryController.text,
  //               },
  //             ).then((value) {
  //               //Do your stuff.
  //             });
  //             FirebaseFirestore.instance
  //                 .collection('books')
  //                 .doc('${bookCategoryController.text}')
  //                 .collection('Books')
  //                 .doc()
  //                 .set(
  //               {
  //                 'bookName': bookNameController.text,
  //                 'category': bookCategoryController.text,
  //                 'imageurl': imageUrl,
  //                 'pdfurl': pdfUrl
  //               },
  //             ).then((value) {
  //               //Do your stuff.
  //             });
  //
  //             bookCategoryController.clear();
  //             bookNameController.clear();
  //             Navigator.pop(context);
  //           }
  //         },
  //         child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 13),
  //           width: displayWidth(context) * .83,
  //           decoration: BoxDecoration(
  //               color: Colors.green[400],
  //               borderRadius: BorderRadius.circular(20),
  //               boxShadow: [
  //                 BoxShadow(
  //                     color: Colors.black12,
  //                     spreadRadius: 2,
  //                     blurRadius: 3,
  //                     offset: Offset(
  //                       2,
  //                       3,
  //                     ))
  //               ]),
  //           child: Text(
  //             'Save',
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // uploadImage() async {
  //   final _firebaseStorage = FirebaseStorage.instance;
  //   final _imagePicker = ImagePicker();
  //   PickedFile image;
  //   //Check Permissions
  //   await Permission.photos.request();
  //
  //   var permissionStatus = await Permission.photos.status;
  //
  //   if (permissionStatus.isGranted) {
  //     //Select Image
  //     image = await _imagePicker.getImage(source: ImageSource.gallery);
  //     var file = File(image.path);
  //
  //     if (image != null) {
  //       //Upload to Firebase
  //       var snapshot = await _firebaseStorage
  //           .ref()
  //           .child('images/${DateTime.now().toString()}')
  //           .putFile(file)
  //           .whenComplete(() {
  //         // TODO: fill the function
  //       });
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imageUrl = downloadUrl;
  //       });
  //     } else {
  //       print('No Image Path Received');
  //     }
  //   } else {
  //     print('Permission not granted. Try Again with permission access');
  //   }
  // }

  Column getButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 10.0,
        ),
        // GestureDetector(
        //   onTap: () {
        //     uploadImage();
        //   },
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: 13),
        //     width: displayWidth(context) * .83,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(20),
        //         boxShadow: [
        //           BoxShadow(
        //               color: Colors.black12,
        //               spreadRadius: 2,
        //               blurRadius: 3,
        //               offset: Offset(
        //                 2,
        //                 3,
        //               ))
        //         ]),
        //     child: Text(
        //       'Upload Cover',
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 10.0,
        ),
        // GestureDetector(
        //   onTap: () {
        //     //TODO: modify this
        //     // getPdfAndUpload();
        //   },
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: 13),
        //     width: displayWidth(context) * .83,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(20),
        //         boxShadow: [
        //           BoxShadow(
        //               color: Colors.black12,
        //               spreadRadius: 2,
        //               blurRadius: 3,
        //               offset: Offset(
        //                 2,
        //                 3,
        //               ))
        //         ]),
        //     child: Text(
        //       'Upload PDF',
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 10.0,
        ),

        // TextButton(
        //   style: TextButton.styleFrom(
        //       primary: Colors.white,
        //       backgroundColor: Colors.lightBlueAccent,
        //       onSurface: Colors.grey,
        //       elevation: 5),
        //   child: Text("Upload Cover",
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 12)),
        //   onPressed: () {
        //     uploadImage();
        //   },
        // ),
        // TextButton(
        //   style: TextButton.styleFrom(
        //       primary: Colors.white,
        //       backgroundColor: Colors.lightBlueAccent,
        //       onSurface: Colors.grey,
        //       elevation: 5),
        //   child: Text("Upload Pdf",
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 12)),
        //   onPressed: () {
        //     getPdfAndUpload();
        //   },
        // ),
      ],
    );
  }

//TODO: modify this
// Future getPdfAndUpload() async {
//   var rng = new Random();
//   String randomName = "";
//   for (var i = 0; i < 20; i++) {
//     print(rng.nextInt(100));
//     randomName += rng.nextInt(100).toString();
//   }
//   File file = await FilePicker.getFile(
//       type: FileType.custom, allowedExtensions: ['pdf']);
//   String fileName = '${randomName}.pdf';
//   print(fileName);
//   print('${file.readAsBytesSync()}');
//   savePdf(file.readAsBytesSync(), fileName);
// }
//
// Future savePdf(List<int> asset, String name) async {
//   Reference reference = FirebaseStorage.instance.ref().child(name);
//   UploadTask uploadTask = reference.putData(asset);
//   String url = await uploadTask.ref.getDownloadURL();
//   print(url);
//   documentFileUpload(url);
//   return url;
// }

// void documentFileUpload(String str) {
//   setState(() {
//     pdfUrl = str;
//   });
//   // mainReference.child("Documents").child('pdf').set(data).then((v) {});
// }
}

//
// class AddBookPage extends StatefulWidget {
//   final String currentUserId;
//   AddBookPage(this.currentUserId);
//   @override
//   _AddBookPageState createState() => _AddBookPageState();
// }
//
// class _AddBookPageState extends State<AddBookPage> {
//   final bookNameController = TextEditingController();
//   final bookCategoryController = TextEditingController();
//   bool _nameValidate = false;
//   bool _categoryValidate = false;
//
//   String imageUrl;
//   String pdfUrl;
//
//
//
//   Stream<DocumentSnapshot> provideDocumentFieldStream() {
//     return FirebaseFirestore.instance
//         // .collection('admin')
//         .collection('user')
//         .doc(widget.currentUserId)
//         .snapshots();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _height = displayHeight(context) -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Add Book'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Get.theme.primaryColor,
//       ),
//       body: SingleChildScrollView(
//           child: StreamBuilder<DocumentSnapshot>(
//               stream: provideDocumentFieldStream(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 if (snapshot.hasData) {
//                   Map<String, dynamic> documentFields = snapshot.data.data();
//                   return Text("_height, documentFields");
//                   // return getData(_height, documentFields);
//                 }
//               })),
//     );
//   }
//
//   Column getData(double _height, Map<String, dynamic> documentFields) {
//     return Column(
//       children: [
//         Container(
//           height: _height * 0.4,
//           // color: Colors.lightBlueAccent,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.cover,
//                   colorFilter: new ColorFilter.mode(
//                       Colors.black.withOpacity(0.4), BlendMode.darken),
//                   image: AssetImage('assets/oldImages/thom.jpg'))),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 80,
//                   width: 80,
//                   decoration: BoxDecoration(
//                       color: Colors.white24,
//                       shape: BoxShape.circle,
//                       border: Border.all(width: 2, color: Colors.white),
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage('assets/oldImages/user.png'))),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: _height * .01),
//                   child: Text(
//                     documentFields['name'],
//                     style:
//                     TextStyle(color: Colors.white, fontSize: _height * .03),
//                   ),
//                 ),
//                 Text(
//                   documentFields['email'],
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(
//                   height: _height * .03,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: displayWidth(context) * 0.02,
//               vertical: _height * 0.01),
//           child: TextField(
//               controller: bookNameController,
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               textInputAction: TextInputAction.next,
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 labelText: 'Book Name',
//                 errorText: _nameValidate ? 'Name Can\'t Be Empty' : null,
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.symmetric(
//                     horizontal: displayWidth(context) * 0.02,
//                     vertical: _height * 0.02),
//               )),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: displayWidth(context) * 0.02,
//               vertical: _height * 0.01),
//           child: TextField(
//               controller: bookCategoryController,
//               keyboardType: TextInputType.text,
//               autofocus: false,
//               textInputAction: TextInputAction.next,
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 labelText: 'Book Category',
//                 errorText:
//                 _categoryValidate ? 'Category Can\'t Be Empty' : null,
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.symmetric(
//                     horizontal: displayWidth(context) * 0.02,
//                     vertical: _height * 0.02),
//               )),
//         ),
//         getButtons(),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: Text(
//             imageUrl == null && pdfUrl == null
//                 ? 'Must Upload Cover Photo and PDF File'
//                 : pdfUrl == null
//                 ? ' Must Upload PDF File '
//                 : imageUrl == null
//                 ? ' Must Upload Cover Photo '
//                 : 'Alls Set',
//             style: TextStyle(
//                 color: imageUrl == null || pdfUrl == null
//                     ? Colors.red
//                     : Colors.green),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               bookCategoryController.text.isEmpty
//                   ? _categoryValidate = true
//                   : _categoryValidate = false;
//               bookNameController.text.isEmpty
//                   ? _nameValidate = true
//                   : _nameValidate = false;
//             });
//             if (_nameValidate == false &&
//                 _categoryValidate == false &&
//                 imageUrl != null) {
//               FirebaseFirestore.instance
//                   .collection('books')
//                   .doc('${bookCategoryController.text}')
//                   .set(
//                 {
//                   'category': bookCategoryController.text,
//                 },
//               ).then((value) {
//                 //Do your stuff.
//               });
//               FirebaseFirestore.instance
//                   .collection('books')
//                   .doc('${bookCategoryController.text}')
//                   .collection('Books')
//                   .doc()
//                   .set(
//                 {
//                   'bookName': bookNameController.text,
//                   'category': bookCategoryController.text,
//                   'imageurl': imageUrl,
//                   'pdfurl': pdfUrl
//                 },
//               ).then((value) {
//                 //Do your stuff.
//               });
//
//               bookCategoryController.clear();
//               bookNameController.clear();
//               Navigator.pop(context);
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 13),
//             width: displayWidth(context) * .83,
//             decoration: BoxDecoration(
//                 color: Colors.green[400],
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12,
//                       spreadRadius: 2,
//                       blurRadius: 3,
//                       offset: Offset(
//                         2,
//                         3,
//                       ))
//                 ]),
//             child: Text(
//               'Save',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   uploadImage() async {
//     final _firebaseStorage = FirebaseStorage.instance;
//     final _imagePicker = ImagePicker();
//     PickedFile image;
//     //Check Permissions
//     await Permission.photos.request();
//
//     var permissionStatus = await Permission.photos.status;
//
//     if (permissionStatus.isGranted) {
//       //Select Image
//       image = await _imagePicker.getImage(source: ImageSource.gallery);
//       var file = File(image.path);
//
//       if (image != null) {
//         //Upload to Firebase
//         var snapshot = await _firebaseStorage
//             .ref()
//             .child('images/${DateTime.now().toString()}')
//             .putFile(file)
//             .whenComplete(() {
//           // TODO: fill the function
//         });
//         var downloadUrl = await snapshot.ref.getDownloadURL();
//         setState(() {
//           imageUrl = downloadUrl;
//         });
//       } else {
//         print('No Image Path Received');
//       }
//     } else {
//       print('Permission not granted. Try Again with permission access');
//     }
//   }
//
//   Column getButtons() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         SizedBox(
//           height: 10.0,
//         ),
//         GestureDetector(
//           onTap: () {
//             uploadImage();
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 13),
//             width: displayWidth(context) * .83,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12,
//                       spreadRadius: 2,
//                       blurRadius: 3,
//                       offset: Offset(
//                         2,
//                         3,
//                       ))
//                 ]),
//             child: Text(
//               'Upload Cover',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10.0,
//         ),
//         GestureDetector(
//           onTap: () {
//             //TODO: modify this
//             // getPdfAndUpload();
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 13),
//             width: displayWidth(context) * .83,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12,
//                       spreadRadius: 2,
//                       blurRadius: 3,
//                       offset: Offset(
//                         2,
//                         3,
//                       ))
//                 ]),
//             child: Text(
//               'Upload PDF',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10.0,
//         ),
//
//         // TextButton(
//         //   style: TextButton.styleFrom(
//         //       primary: Colors.white,
//         //       backgroundColor: Colors.lightBlueAccent,
//         //       onSurface: Colors.grey,
//         //       elevation: 5),
//         //   child: Text("Upload Cover",
//         //       style: TextStyle(
//         //           color: Colors.white,
//         //           fontWeight: FontWeight.bold,
//         //           fontSize: 12)),
//         //   onPressed: () {
//         //     uploadImage();
//         //   },
//         // ),
//         // TextButton(
//         //   style: TextButton.styleFrom(
//         //       primary: Colors.white,
//         //       backgroundColor: Colors.lightBlueAccent,
//         //       onSurface: Colors.grey,
//         //       elevation: 5),
//         //   child: Text("Upload Pdf",
//         //       style: TextStyle(
//         //           color: Colors.white,
//         //           fontWeight: FontWeight.bold,
//         //           fontSize: 12)),
//         //   onPressed: () {
//         //     getPdfAndUpload();
//         //   },
//         // ),
//       ],
//     );
//   }
//
//   //TODO: modify this
//   // Future getPdfAndUpload() async {
//   //   var rng = new Random();
//   //   String randomName = "";
//   //   for (var i = 0; i < 20; i++) {
//   //     print(rng.nextInt(100));
//   //     randomName += rng.nextInt(100).toString();
//   //   }
//   //   File file = await FilePicker.getFile(
//   //       type: FileType.custom, allowedExtensions: ['pdf']);
//   //   String fileName = '${randomName}.pdf';
//   //   print(fileName);
//   //   print('${file.readAsBytesSync()}');
//   //   savePdf(file.readAsBytesSync(), fileName);
//   // }
//   //
//   // Future savePdf(List<int> asset, String name) async {
//   //   Reference reference = FirebaseStorage.instance.ref().child(name);
//   //   UploadTask uploadTask = reference.putData(asset);
//   //   String url = await uploadTask.ref.getDownloadURL();
//   //   print(url);
//   //   documentFileUpload(url);
//   //   return url;
//   // }
//
//   void documentFileUpload(String str) {
//     setState(() {
//       pdfUrl = str;
//     });
//     // mainReference.child("Documents").child('pdf').set(data).then((v) {});
//   }
// }
