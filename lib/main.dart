import 'package:flutter/material.dart';
import 'package:flutterdemo/button_widget.dart';
import 'package:flutterdemo/color_utils.dart';
import 'package:flutterdemo/text_field_widget.dart';
import 'package:flutterdemo/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _nameControllerFocus = FocusNode();
  final FocusNode _passwordControllerFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlutterLogo(
                      size: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildUsername(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildPassword(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildNextButton(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildToastButton(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildSnackbarButton(context),
                    SizedBox(
                      height: 10,
                    ),
                    _buildSnackbarWithActionButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsername() {
    return TextFormFieldWidget(
      hintText: "Username",
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: _nameController,
      focusNode: _nameControllerFocus,
      onSubmitField: () {
        // Use this method to change cursor focus
        // First param - Current Controller
        // Second param - The Controller you want to focus on the next button press
        changeFocus(context, _nameControllerFocus, _passwordControllerFocus);
      },
      parametersValidate: "Please enter Username.",
      prefixIcon: Icon(
          Icons.insert_emoticon), // Don't pass image in case of no prefix Icon
    );
  }

  Widget _buildPassword() {
    return TextFormFieldWidget(
      hintText: "Password",
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      actionKeyboard: TextInputAction.done,
      functionValidate: commonValidation,
      controller: _passwordController,
      focusNode: _passwordControllerFocus,
      onSubmitField: () {},
      parametersValidate: "Please enter password.",
      prefixIcon: Icon(Icons.keyboard_hide),
    );
  }

  Widget _buildNextButton() {
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Next",
        leadingIcon: Icon(Icons.send),
        height: 50.0,
        borderRadius: 5,
        color: primaryColor,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: primaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        onClick: () {
          var validate = _formKey.currentState.validate();
          if (validate) {
            hideKeyboard();
            _formKey.currentState.save();
            Utils.displayToast("Fields validated...");
            // Perform operation
          }
        });
  }

  Widget _buildSnackbarButton(BuildContext context) {
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Show Snackbar",
        height: 50.0,
        borderRadius: 5,
        color: primaryColor,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: primaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        onClick: () {
          hideKeyboard();
          Scaffold.of(context)
              .showSnackBar(Utils.displaySnackBar("This is Snackbar"));
        });
  }

  Widget _buildSnackbarWithActionButton(BuildContext context) {
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Show Snackbar with Action",
        height: 50.0,
        borderRadius: 5,
        color: primaryColor,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: primaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        onClick: () {
          hideKeyboard();
          Scaffold.of(context).showSnackBar(Utils.displaySnackBar(
              "This is Snackbar with Action",
              actionMessage: "RETRY", onClick: () {
            // perform button click action
            print("RETRY clicked");
          }));
        });
  }

  Widget _buildToastButton() {
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Show Toast",
        height: 50.0,
        borderRadius: 5,
        color: primaryColor,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: primaryColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        onClick: () {
          hideKeyboard();
          Utils.displayToast("This is toast message");
        });
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
