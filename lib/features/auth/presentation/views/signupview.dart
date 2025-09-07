import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forth_session/core/helps%20functions/build_snackbar.dart';
import 'package:forth_session/core/services/get_it.dart';
import 'package:forth_session/features/auth/domain/repo/auth_repo.dart';
import 'package:forth_session/features/auth/presentation/cubits/sign_up/signup_cubit.dart';
import 'package:forth_session/features/auth/presentation/views/signinview.dart';
import 'package:forth_session/features/home/presentation/views/homeView.dart';

class Signupview extends StatefulWidget {
  const Signupview({super.key});

  @override
  State<Signupview> createState() => _SignupviewState();
}

class _SignupviewState extends State<Signupview> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isVisible = false; // State for password visibility
  bool isChecked = false; // State for checkbox
  late String email, name, password;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Right-to-left for Arabic
      child: BlocProvider(
        create: (context) => SignupCubit(getIt<AuthRepo>()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'حساب جديد',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF0C0D0D) /* Grayscale-950 */,
                fontSize: 23,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                // Handle settings action
                Navigator.pop(context);
              },
            ),
          ),
          body: Builder(
            builder: (context) {
              return BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccess) {
                    BuildSnackBar(context, 'تم انشاء حساب');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homeview()),
                    );
                  }
                  if (state is SignupFailed) {
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
                      child: Form(
                        key: formKey,
                        child: Column(
                          spacing: 33,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 16,
                              children: [
                                customTextFormField(
                                  hinttext: 'الاسم كامل',
                                  textInputType: TextInputType.name,
                                  onSaved: (value) {
                                    name = value!;
                                  },
                                ),
                                customTextFormField(
                                  hinttext: 'البريد الإلكتروني',
                                  textInputType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    email = value!;
                                  },
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
                              ],
                            ),
                            customRowConfirm(
                              checkboxValue: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  print('Checkbox value changed: $isChecked');
                                });
                              },
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 33,
                              children: [
                                customButton(
                                  title: 'إنشاء حساب جديد',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      if (isChecked) {
                                        context
                                            .read<SignupCubit>()
                                            .createUserWithEmailAndPassword(
                                              email,
                                              password,
                                              name,
                                            );
                                      } else {
                                        BuildSnackBar(
                                          context,
                                          'يرجى الموافقة على الشروط والأحكام',
                                        );
                                      }
                                    } else {
                                      setState(() {
                                        autovalidateMode =
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
                                        builder: (context) => Signinview(),
                                      ),
                                    );
                                  },
                                  child: customTextRich(
                                    textAlign: TextAlign.center,
                                    firstPart: 'تمتلك حساب بالفعل؟',
                                    secondPart: "تسجيل الدخول",
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

class customRowConfirm extends StatelessWidget {
  const customRowConfirm({
    super.key,
    required this.checkboxValue,
    required this.onChanged,
  });
  final bool checkboxValue;

  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: customCheckbox(
            checkboxValue: checkboxValue,
            onChanged: onChanged,
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width - 100,

          child: customTextRich(
            firstPart: "من خلال إنشاء حساب ، فإنك توافق على ",
            secondPartColor: Color(0xFF2D9F5D),
            secondPart: "الشروط والأحكام الخاصة بنا",
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

class customCheckbox extends StatelessWidget {
  const customCheckbox({
    super.key,
    required this.checkboxValue,
    required this.onChanged,
  });
  final bool checkboxValue;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(!checkboxValue);
      },
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: checkboxValue
              ? const Color(0xFF1B5E37) /* Green1-600 */
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFDCDEDE), width: 1),
        ),
        child: checkboxValue
            ? Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }
}
