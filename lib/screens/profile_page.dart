import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:photocontesthub/inapp_purchase/CoinStorePage.dart';
import 'package:photocontesthub/models/users.dart';
import 'package:photocontesthub/screens/home_page.dart';
import 'package:photocontesthub/services/firestore_services.dart';
import 'package:photocontesthub/utils/Constants.dart';
import 'package:photocontesthub/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:photocontesthub/widgets/message_dialog_with_ok.dart';
import 'package:progress_dialog/progress_dialog.dart';
class ProfilePage extends StatefulWidget {
  static const String routeName = "/ProfilePage";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _facebook_nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  ProgressDialog progressDialog;
  FirestoreServices _fireStoreServices = FirestoreServices();
  String _email, _name, _facebook_name, _phone, _warning;
  bool isLoginPressed = false;
  Users users;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  _getProfile() async {
    users = await _fireStoreServices.getUserprofile();
    setState(() {
      _nameController.text = users.name;
      _emailController.text = users.email;
      _facebook_nameController.text = users.facebook_name;
      _phoneController.text = users.phone_number;
    });
  }

  showToastt(String message) {
    showToast(message,
        context: context,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        position: StyledToastPosition(align: Alignment.center, offset: 20.0));
  }

  updateProfile(BuildContext context, ProgressDialog progressDialog) async {
    progressDialog = new ProgressDialog(context);
    await progressDialog.show();

    Users users = Users(
      uid: Constants.prefs.getString(Constants.uid),
      name: _name,
      email: _email,
      facebook_name: _facebook_name,
      phone_number: _phone,
    );
    await _fireStoreServices.updateUserProfile(context, users).then((val) {
      progressDialog.hide();
      showDialog(
          context: context,
          builder: (context) => CustomDialogWithOk(
                title: "Profile Updated",
                description:
                    "Your Profile has been Updated, Now You can participate",
                primaryButtonText: "Ok",
                primaryButtonRoute: HomePage.routeName,
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile "),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.indigo),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: CircleAvatar(
                        radius: 100,
                        child: Image.asset(
                          Constants.profile_icon_placeholder,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${_nameController.text}",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  _buildErrorWidget(),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: _buildWidgets() + _buildButtons(),
                      )),
                ],
              ),
            ),
            RaisedButton(
                child: Text("Buy"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return CoinStorePage();
                  }));
                }),
            Divider(
              height: 10,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.blue,
            child: Text(
              "Save",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22),
            ),
            onPressed: () {
              submit(context);
            }),
      ),
    ];
  }

  bool isValid() {
    final form = _formKey.currentState;

    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit(BuildContext context) async {
    if (isValid()) {
      try {
        updateProfile(context, progressDialog);
      } catch (error) {
        setState(() {
          _warning = error.message;
          isLoginPressed = false;
        });
        print(error);
      }
    }
  }

  InputDecoration buildSignUpinputDecoration(
      String labelHint, String labelText) {
    return InputDecoration(
      labelText: labelText,
      fillColor: Colors.white,
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
      validator: Namevalidator.validate,
      controller: _nameController,
      decoration: buildSignUpinputDecoration("Name", "Enter your Name"),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _name = value,
    ));
    textfields.add(SizedBox(
      height: 20,
    ));

    textfields.add(TextFormField(
      style: TextStyle(fontSize: 22),
      validator: Emailvalidator.validate,
      controller: _emailController,
      enabled: false,
      decoration:
          buildSignUpinputDecoration("Email", "Enter The Email Address"),
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
          "Facebook Name", " Enter your name in facebook"),
      keyboardType: TextInputType.text,
      onSaved: (String value) => _facebook_name = value,
    ));
    textfields.add(SizedBox(
      height: 20,
    ));
    textfields.add(TextFormField(
      style: TextStyle(fontSize: 22),
      validator: phoneValidator.validate,
      controller: _phoneController,
      decoration:
          buildSignUpinputDecoration("phone No", "Enter your Phone Number"),
      keyboardType: TextInputType.number,
      onSaved: (String value) => _phone = value,
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
