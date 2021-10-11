import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fun_flutter/app/components/state_pages.dart';
import 'package:fun_flutter/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Image.asset(
                          'assets/icons/ic_android.png',
                          height: 60,
                          width: 60,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormFieldItem(
                          label: 'user'.tr,
                          prefixIconData: Icons.person_rounded,
                          primaryColor: Theme.of(context).primaryColor,
                          controller: controller.userController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'tips_user_empty'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormFieldItem(
                          obscureText: true,
                          label: 'password'.tr,
                          prefixIconData: Icons.lock_rounded,
                          primaryColor: Theme.of(context).primaryColor,
                          controller: controller.pwdController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'tips_password_empty'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (await Get.toNamed(Routes.VERITY)) {
                                  controller.login(
                                    controller.userController.text,
                                    controller.pwdController.text,
                                    succes: () => Get.back(),
                                  );
                                }
                              }
                            },
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            color: Theme.of(context).primaryColor,
                            child: GetBuilder(init: controller, builder: 
                              (_) => controller.loadState ==
                                      LoadState.kLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'login'.tr,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'tips_to_register'.tr,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 50,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormFieldItem extends StatelessWidget {
  const FormFieldItem({
    Key? key,
    required this.primaryColor,
    this.obscureText = false,
    required this.validator,
    required this.prefixIconData,
    required this.label,
    required this.controller,
  }) : super(key: key);

  final Color primaryColor;
  final bool obscureText;
  final TextEditingController controller;
  final Function(String? value) validator;
  final IconData prefixIconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        validator: (value) => validator(value),
        style: const TextStyle(
          textBaseline: TextBaseline.alphabetic,
          // color: Colors.white,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          prefixIcon: Icon(prefixIconData),
          filled: true, // 不然 fillColor 等 不生效
          fillColor: primaryColor.withOpacity(0.07),
          labelStyle: const TextStyle(fontSize: 15),
          hintText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          // label: Text(
          //   label,
          //   // style: const TextStyle(color: Colors.white),
          // ),
        ),
      ),
    );
  }
}
