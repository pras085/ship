import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class GoogleSignInFunction {
  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;
  //final userController = Get.find<UserController>().obs;

  static final GoogleSignInFunction _instance =
      GoogleSignInFunction._internal();

  factory GoogleSignInFunction() {
    return _instance;
  }

  GoogleSignInFunction._internal() {
    init();
  }

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future init() async {
    if (_auth == null || _googleSignIn == null) {
      await Firebase.initializeApp();
      _auth = FirebaseAuth.instance;
      _initGoogleSignIn();
    }
  }

  void _initGoogleSignIn() {
    _googleSignIn = GoogleSignIn(scopes: ['email']);
  }

  Future signInWithGoogle(bool isRegisterView, BuildContext context) async {
//    await init();
    try {
      await _googleSignIn.signOut();
    } catch (err) {}
    GoogleSignInAccount signInAccout = await _googleSignIn.signIn();
    GoogleSignInAuthentication authentication =
        await signInAccout.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    await _auth.signInWithCredential(authCredential);
    LoginFunction loginFunction = LoginFunction();
    UserModel usm = UserModel(
        email: _googleSignIn.currentUser.email,
        name: _googleSignIn.currentUser.displayName);
    await loginFunction.loginUser(usm, true, context, true);
    usm.isGoogle = true;
    //userController.value.setParam(usm);
    await _googleSignIn.signOut();
    if (!loginFunction.isSuccess) {
      await _googleSignIn.signOut();
      _registerFirst(usm, isRegisterView);
    } else {
      usm = loginFunction.userModel;
      if (loginFunction.userModel.isVerifPhone) {
        loginFunction.saveDataUserGotoHome(usm);
      } else {
        await _googleSignIn.signOut();
        if (usm.name == null || usm.phone == null)
          _registerFirst(usm, isRegisterView);
        else
          Get.offAllNamed(Routes.VERIFY_PHONE, arguments: usm);
      }
    }

    // final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    // final GoogleSignInAuthentication googleSignInAuthentication =
    //     await googleSignInAccount.authentication;

    // final AuthCredential credential = GoogleAuthProvider.getCredential(
    //   accessToken: googleSignInAuthentication.accessToken,
    //   idToken: googleSignInAuthentication.idToken,
    // );

    // final UserCredential authResult =
    //     await _auth.signInWithCredential(credential);
    // //final FirebaseUser user = authResult.user;
    // final FirebaseUser user =
    //     (await _auth.signInWithCredential(credential)).user;

    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);

    // final FirebaseUser currentUser = await _auth.currentUser;
    // assert(user.uid == currentUser.uid);

    // return 'signInWithGoogle succeeded: $user';
  }

  void _registerFirst(UserModel usm, bool isRegisterView) {
    if (isRegisterView) {
      RegisterUserController registerUserController = Get.find();
      registerUserController.setUserModelGoogleAccount(usm);
    } else
      Get.toNamed(Routes.REGISTER_USER, arguments: usm);
  }

  void signOut() async {
    if (_googleSignIn == null) await init();
    await _googleSignIn.signOut();
    //userController.value.userModel.value = UserModel();
    print("User Sign Out");
  }
}
