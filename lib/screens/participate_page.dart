import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photocontesthub/models/eventPostModel.dart';
import 'package:photocontesthub/models/eventsModel.dart';
import 'package:photocontesthub/screens/home_page.dart';
import 'package:photocontesthub/screens/profile_page.dart';
import 'package:photocontesthub/screens/wallet_page.dart';
import 'package:photocontesthub/services/firebase_auth_services.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/validators.dart';
import 'package:photocontesthub/widgets/message_dialog_with_ok.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class ParticipatePage extends StatefulWidget {
  final EventModels eventModels;

  ParticipatePage({this.eventModels});

  @override
  _ParticipatePageState createState() =>
      _ParticipatePageState(this.eventModels);
}

class _ParticipatePageState extends State<ParticipatePage> {
  final EventModels eventModels;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _facebook_nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FirestoreServices _fireStoreServices = FirestoreServices();

  String _email, _name, _facebook_name, _phone, _warning;
  File _selectedFile;
  bool _inProcess = false;
  bool inApp = true;

  _ParticipatePageState(this.eventModels);

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            getImage(ImageSource.gallery);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                _selectedFile,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            getImage(ImageSource.gallery);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: MediaQuery.of(context).size.width * 0.95,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                "https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png",
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }
  }

  getImage(ImageSource source) async {
    setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      print("not Null");
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          maxHeight: 700,
          maxWidth: 700,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrange,
              toolbarTitle: "Pch Cropper",
              statusBarColor: Colors.deepOrange.shade900,
              initAspectRatio: CropAspectRatioPreset.original,
              backgroundColor: Colors.white,
              lockAspectRatio: false));

      setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      print("Null Image");
      setState(() {
        _inProcess = false;
      });
    }
  }

  StorageUploadTask _storageUploadTask;
  final FirebaseStorage _storage = FirebaseStorage();

  Future<void> _startUploadForInApp(
      EventPostModel eventPostModel, ProgressDialog pr, FirebaseUser user,) async {
    if (_selectedFile != null) {
      String filePath = 'images/Event${eventModels.eventId}/${DateTime.now()}.png';
      _storageUploadTask =
          await _storage.ref().child(filePath).putFile(_selectedFile);
      var download_url =
          await (await _storageUploadTask.onComplete).ref.getDownloadURL();
      var url = download_url.toString();
      print(url);

      _fireStoreServices
          .updatePostLink(context, url, eventModels,user )
          .then((val) async {
        await pr.hide();

        showDialog(
            context: context,
            builder: (context) => CustomDialogWithOk(
                  title: "Photo Posted",
                  description:
                      " You have participated Successfully",
                  primaryButtonText: "Ok",
                  primaryButtonRoute: HomePage.routeName,
                ));
      });
    } else {
      print(" No Image Selected");
    }
  }

  showToastt(String message) {
    showToast(message,
        context: context,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        position:
            StyledToastPosition(align: Alignment.bottomCenter, offset: 20.0));
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(
      context,
      isDismissible: false,
    );

    final firestore = Provider.of<FirestoreServices>(context, listen: false);
    final auth = Provider.of<FirebaseAuthServices>(context, listen: false);

    _participateTheUser(ProgressDialog progressDialog) async {
      String facebookName =
          await firestore.getFacebookName(await auth.getCurrentUser());
      print("Face book Name$facebookName");
      String name = await firestore.getName(await auth.getCurrentUser());
      print("name $name");
      int amount = await firestore.getAmount(await auth.getCurrentUser());
      print("Amount $amount");

      EventPostModel eventPostModel = EventPostModel(
          eventTag:
              "#Photo_Contest ${eventModels.eventId} by Photo Contest Hub",
          eventPromotionStatus:
              "Winners will get Rs ${eventModels.prize} +some Addons(Check from Our App) from Photo Contest Hub and get featured in our Page and Channel",
          registrationFee: "${eventModels.entryFee}",
          contestantName: facebookName,
          rulesTag: "#Rules_to_Participate",
          startDate: "${eventModels.votingStartDate}",
          endDate: "${eventModels.votingEndDate}",
          sharePoint: "1",
          commentPoint: "1",
          likePoint: "1",
          wowPoint: "1",
          resultDate: "${eventModels.resultDate}",
          pageName: "Photo Contest Hub");

      if (_selectedFile == null) {
        showToastt("Please Select the Image");
        print("Image Not Selected");
      } else if (name == "" ||
          name == null ||
          facebookName == "" ||
          facebookName == null) {
        setState(() {
          showDialog(
              context: context,
              builder: (context) => CustomDialogWithOk(
                    title: "Name is Empty",
                    description: " Please Update Your Name & Facebook Name",
                    primaryButtonText: "Ok",
                    primaryButtonRoute: ProfilePage.routeName,
                  ));
        });
      } else if (amount.isNaN || amount == null) {
        print(("Amount is Null or mpty"));
      } else if (amount >= int.parse(eventPostModel.registrationFee)) {
        print("can Proccedd");
        print(" Amount is Greater Than Required");
        await pr.show();
        await firestore
            .participate(eventModels, facebookName, await auth.getCurrentUser(),
                eventModels.entryFee, context)
            .then((val) async{
          if (inApp) {
            print("In App Contest");
            _startUploadForInApp( eventPostModel, pr,await auth.getCurrentUser());
          }
        });
      } else if (amount <= int.parse(eventPostModel.registrationFee)) {
        showDialog(
            context: context,
            builder: (context) => CustomDialogWithOk(
                  title: "Low Balance in Wallet",
                  description:
                      "You have low amount in your wallet. Add money to wallet to Participate",
                  primaryButtonText: "OK",
                  primaryButtonRoute: WalletScreen.routeName,
                ));
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Upload Pics"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  getImageWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        _buildErrorWidget(),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: _buildWidgets(),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple, width: 2),
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FlatButton(
                        child: Text("Upload The Image"),
                        onPressed: () {
                          print("Clicked");
                          _participateTheUser(pr);
                        }),
                  )
                ],
              ),
            ),
            (_inProcess)
                ? Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center()
          ],
        ),
      ),
    );
  }

  InputDecoration buildSignUpinputDecoration(
      String labelHint, String labelText) {
    return InputDecoration(
      labelText: labelText,
      fillColor: Colors.grey,
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(30.0),
        borderSide: new BorderSide(),
      ),
      //fillColor: Colors.green
    );
  }

  List<Widget> _buildWidgets() {
    List<Widget> textfields = [];
    textfields.add(TextFormField(
      style: TextStyle(fontSize: 22),
      validator: Emailvalidator.validate,
      controller: _emailController,
      enabled: true,
      decoration: buildSignUpinputDecoration(
          "Description", "Write description (optional)"),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) => _email = value,
    ));
    textfields.add(SizedBox(
      height: 20,
    ));

    textfields.add(TextFormField(
      style: TextStyle(fontSize: 22),
      validator: Namevalidator.validate,
      controller: _facebook_nameController,
      decoration: buildSignUpinputDecoration(
          "Shooted at", " Where was this photo taken? (optional)"),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _facebook_name = value,
    ));
    textfields.add(SizedBox(
      height: 20,
    ));

    return textfields;
  }

  _buildErrorWidget() {
    if (_warning != null) {
      return Container(
        color: Colors.yellow,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                  IconButton(icon: Icon(Icons.error_outline), onPressed: () {}),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _warning = null;
                    });
                  }),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
