import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forth_session/core/helps%20functions/build_snackbar.dart';
import 'package:forth_session/core/services/get_it.dart';
import 'package:forth_session/features/auth/domain/repo/auth_repo.dart';
import 'package:forth_session/features/auth/presentation/cubits/sign_in/signin_cubit.dart';
import 'package:forth_session/features/auth/presentation/views/signupview.dart';
import 'package:forth_session/features/home/presentation/views/homeView.dart';

class Signinview extends StatefulWidget {
  const Signinview({super.key});

  @override
  State<Signinview> createState() => _SigninviewState();
}

class _SigninviewState extends State<Signinview> {
  bool isVisible = false; // State for password visibility
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Right-to-left for Arabic
      child: BlocProvider(
        create: (context) => SigninCubit(getIt<AuthRepo>()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'تسجيل دخول',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF0C0D0D) /* Grayscale-950 */,
                fontSize: 23,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Builder(
            builder: (context) {
              return BlocConsumer<SigninCubit, SigninState>(
                listener: (context, state) {
                  if (state is SigninSuccess) {
                    //  log(state.userEntity.toString());
                    BuildSnackBar(context, 'تم تسجيل الدخول');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homeview()),
                    );
                  }
                  if (state is SigninFailed) {
                    log(state.errMessage);
                    BuildSnackBar(context, state.errMessage);
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Column(
                        spacing: 33,
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 16,
                              children: [
                                customTextFormField(
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                  hinttext: 'البريد الإلكتروني',
                                  textInputType: TextInputType.emailAddress,
                                ),
                                customTextFormField(
                                  onSaved: (value) {
                                    password = value!;
                                  },

                                  hinttext: 'كلمة المرور',
                                  textInputType: TextInputType.text,
                                  obscureText: isVisible,
                                  suff: IconButton(
                                    icon: Icon(
                                      isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xffC9CECF),
                                    ),
                                    onPressed: () {
                                      // Handle visibility toggle
                                      setState(() {
                                        isVisible = !isVisible;
                                        print(
                                          'Password visibility toggled: $isVisible',
                                        );
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'نسيت كلمة المرور؟',
                                  style: TextStyle(
                                    color: const Color(
                                      0xFF2D9F5D,
                                    ) /* Green1-600 */,
                                    fontSize: 15,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                    height: 1.70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 33,
                            children: [
                              customButton(
                                title: 'تسجيل الدخول',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    context
                                        .read<SigninCubit>()
                                        .signInWithEmailAndPassword(
                                          email,
                                          password,
                                        );
                                  } else {
                                    setState(() {
                                      autoValidateMode =
                                          AutovalidateMode.always;
                                    });
                                  }
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signupview(),
                                    ),
                                  );
                                },
                                child: customTextRich(
                                  firstPart: 'لا تمتلك حساب؟ ',
                                  secondPart: "قم بإنشاء حساب",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            spacing: 20,
                            children: [
                              Row(
                                spacing: 20,
                                children: [
                                  Expanded(child: Divider()),
                                  Center(
                                    child: Text(
                                      'أو',
                                      style: TextStyle(
                                        color: const Color(
                                          0xFF0C0D0D,
                                        ) /* Grayscale-950 */,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              customGoogleButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class customGoogleButton extends StatelessWidget {
  const customGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,

          foregroundColor: Color(0xFF1B5E37),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color(0xFFE6E9E9), // Grayscale-200
              width: 1,
            ),
          ),
        ),
        onPressed: () {},
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Vector.png', width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              'تسجيل بواسطة جوجل',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class customTextRich extends StatelessWidget {
  const customTextRich({
    super.key,
    required this.firstPart,
    required this.secondPart,
    required this.textAlign,
    this.secondPartColor,
    this.firstPartColor,
  });
  final String firstPart;
  final String secondPart;
  final TextAlign textAlign;
  final Color? secondPartColor;
  final Color? firstPartColor;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstPart,
            style: TextStyle(
              color:
                  firstPartColor ?? const Color(0xFF949D9E) /* Grayscale-950 */,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 1.40,
            ),
          ),
          TextSpan(
            text: secondPart,
            style: TextStyle(
              color:
                  secondPartColor ?? const Color(0xFF1B5E37) /* Green1-600 */,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              height: 1.40,
            ),
          ),
        ],
      ),
      textAlign: textAlign,
    );
  }
}

class customButton extends StatelessWidget {
  const customButton({super.key, required this.title, required this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B5E37) /* Green1-500 */,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class customTextFormField extends StatelessWidget {
  const customTextFormField({
    super.key,
    required this.hinttext,
    required this.textInputType,
    this.onSaved,
    this.obscureText = false,
    this.suff,
    this.pref,
    this.contentPadding,
    this.hintStyle,
    this.controller,
    this.onChanged,
    this.isEnabled,
  });

  final String hinttext;
  final bool obscureText;
  final TextInputType textInputType;
  final void Function(String?)? onSaved;
  final Widget? suff;
  final Widget? pref;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? isEnabled;

  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        } else {
          return null;
        }
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suff,
        prefixIcon: pref,
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        border: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        hintText: hinttext,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 1, color: Color(0xFFE6E9E9)),
    );
  }
}
