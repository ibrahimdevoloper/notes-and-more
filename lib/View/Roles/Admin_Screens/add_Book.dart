import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mh_care/Model/Services/Size_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class AddBook extends StatefulWidget {
  final String currentUserId;
  AddBook(this.currentUserId);
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final bookNameController = TextEditingController();
  final bookCategoryController = TextEditingController();
  bool _nameValidate = false;
  bool _categoryValidate = false;

  String imageUrl;
  String pdfUrl;

  Column getData(double _height, Map<String, dynamic> documentFields) {
    return Column(
      children: [
        Container(
          height: _height * 0.4,
          // color: Colors.lightBlueAccent,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                  image: AssetImage('assets/thom.jpg'))),
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
                          image: AssetImage('assets/user.png'))),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: _height * .01),
                  child: Text(
                    documentFields['name'],
                    style:
                        TextStyle(color: Colors.white, fontSize: _height * .03),
                  ),
                ),
                Text(
                  documentFields['email'],
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: _height * .03,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: displayWidth(context) * 0.02,
              vertical: _height * 0.01),
          child: TextField(
              controller: bookNameController,
              keyboardType: TextInputType.text,
              autofocus: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'Book Name',
                errorText: _nameValidate ? 'Name Can\'t Be Empty' : null,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.02,
                    vertical: _height * 0.02),
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: displayWidth(context) * 0.02,
              vertical: _height * 0.01),
          child: TextField(
              controller: bookCategoryController,
              keyboardType: TextInputType.text,
              autofocus: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'Book Category',
                errorText:
                    _categoryValidate ? 'Category Can\'t Be Empty' : null,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.02,
                    vertical: _height * 0.02),
              )),
        ),
        getButtons(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            imageUrl == null && pdfUrl == null
                ? 'Must Upload Cover Photo and PDF File'
                : pdfUrl == null
                    ? ' Must Upload PDF File '
                    : imageUrl == null
                        ? ' Must Upload Cover Photo '
                        : 'Alls Set',
            style: TextStyle(
                color: imageUrl == null || pdfUrl == null
                    ? Colors.red
                    : Colors.green),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              bookCategoryController.text.isEmpty
                  ? _categoryValidate = true
                  : _categoryValidate = false;
              bookNameController.text.isEmpty
                  ? _nameValidate = true
                  : _nameValidate = false;
            });
            if (_nameValidate == false &&
                _categoryValidate == false &&
                imageUrl != null) {
              Firestore.instance
                  .collection('books')
                  .document('${bookCategoryController.text}')
                  .setData(
                {
                  'category': bookCategoryController.text,
                },
              ).then((value) {
                //Do your stuff.
              });
              Firestore.instance
                  .collection('books')
                  .document('${bookCategoryController.text}')
                  .collection('Books')
                  .document()
                  .setData(
                {
                  'bookName': bookNameController.text,
                  'category': bookCategoryController.text,
                  'imageurl': imageUrl,
                  'pdfurl': pdfUrl
                },
              ).then((value) {
                //Do your stuff.
              });

              bookCategoryController.clear();
              bookNameController.clear();
              Navigator.pop(context);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13),
            width: displayWidth(context) * .83,
            decoration: BoxDecoration(
                color: Colors.green[400],
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
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return Firestore.instance
        .collection('admin')
        .document(widget.currentUserId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final _height = displayHeight(context) -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('User Console'),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: provideDocumentFieldStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  Map<String, dynamic> documentFields = snapshot.data.data;

                  return getData(_height, documentFields);
                }
              })),
    );
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/${DateTime.now().toString()}')
            .putFile(file)
            .onComplete;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  Column getButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: () {
            uploadImage();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13),
            width: displayWidth(context) * .83,
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
              'Upload Cover',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: () {
            getPdfAndUpload();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13),
            width: displayWidth(context) * .83,
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
              'Upload PDF',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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

  Future getPdfAndUpload() async {
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
    }
    File file = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['pdf']);
    String fileName = '${randomName}.pdf';
    print(fileName);
    print('${file.readAsBytesSync()}');
    savePdf(file.readAsBytesSync(), fileName);
  }

  Future savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    documentFileUpload(url);
    return url;
  }

  void documentFileUpload(String str) {
    setState(() {
      pdfUrl = str;
    });
    // mainReference.child("Documents").child('pdf').set(data).then((v) {});
  }
}
