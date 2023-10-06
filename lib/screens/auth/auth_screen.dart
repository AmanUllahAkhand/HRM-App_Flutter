import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hrm_app/screens/auth/widgets/input_fields.dart';
import 'package:hrm_app/screens/auth/widgets/submit_button.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import '../../controllers/login_controller.dart';
import '../../controllers/registeration_controller.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterationController registerationController =
  Get.put(RegisterationController());

  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;
  bool isRememberMeSelected = false;

  // A Hive box for storing login details
  late Box<LoginDetails> loginDetailsBox;

  @override
  void initState() {
    super.initState();

    // Open the Hive box for login details
    openLoginDetailsBox();
  }

  Future<void> openLoginDetailsBox() async {
    final appDocumentDirectory =
    await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    // Open the Hive box with a unique name
    loginDetailsBox = await Hive.openBox<LoginDetails>('login_details');
  }

  void saveLoginDetails() {
    final email = loginController.emailController.text;
    final password = loginController.passwordController.text;

    // Check if "Remember Me" is selected
    if (isRememberMeSelected) {
      // Save the login details in the Hive box
      loginDetailsBox.put('login_details', LoginDetails(email, password));
    } else {
      // Remove the login details from the Hive box (if previously saved)
      loginDetailsBox.delete('login_details');
    }
  }

  void retrieveLoginDetails() {
    final savedDetails = loginDetailsBox.get('login_details');
    if (savedDetails != null) {
      loginController.emailController.text = savedDetails.email;
      loginController.passwordController.text = savedDetails.password;
      setState(() {
        isRememberMeSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      'WELCOME',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: !isLogin.value ? Colors.amber : Colors.white,
                        onPressed: () {
                          isLogin.value = false;
                        },
                        child: Text('Register'),
                      ),
                      MaterialButton(
                        color: isLogin.value ? Colors.amber : Colors.white,
                        onPressed: () {
                          isLogin.value = true;
                          retrieveLoginDetails(); // Populate login details
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  isLogin.value ? loginWidget() : registerWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registerationController.nameController, 'name'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailController, 'email address'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'password'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () {
            saveLoginDetails(); // Save login details
            registerationController.registerWithEmail();
          },
          title: 'Register',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailController, 'email address'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordController, 'password'),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Checkbox(
              value: isRememberMeSelected,
              onChanged: (value) {
                setState(() {
                  isRememberMeSelected = value!;
                });
              },
            ),
            Text('Remember Me'),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () {
            saveLoginDetails(); // Save login details
            loginController.loginWithEmail();
          },
          title: 'Login',
        )
      ],
    );
  }
}

@HiveType(typeId: 0)
class LoginDetails extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  LoginDetails(this.email, this.password);
}
