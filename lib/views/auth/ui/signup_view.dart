import 'package:e_commerce_app_using_supabase/core/components/custom_circle_pro_ind.dart';
import 'package:e_commerce_app_using_supabase/core/functions/show_message.dart';
import 'package:e_commerce_app_using_supabase/views/nav_bar/ui/main_home_view.dart';
import 'package:e_commerce_app_using_supabase/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/app_colors.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_row_with_arrow.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_text_btn.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            showMessage(context, state.errorMessage);
          }
          if (state is SignUpSuccess || state is GoogleSignInSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainHomeView()),
            );
          }
        },
        builder: (context, state) {
          AuthenticationCubit cubit = context.read<AuthenticationCubit>();
          return state is SignUpLoading
              ? CustomCircleProgIndicator()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Welcome To Our Market",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Card(
                            color: AppColors.kWhiteColor,
                            margin: const EdgeInsets.all(24),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const CustomTextFormField(
                                    labelText: "Name",
                                    keyboardType: TextInputType.name,
                                  ),
                                  const SizedBox(height: 20),
                                  const CustomTextFormField(
                                    labelText: "Email",
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    labelText: "Password",
                                    keyboardType: TextInputType.visiblePassword,
                                    isSecured: true,
                                    suffIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomRowWithArrowBtn(
                                    text: "Sign Up",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.register(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomRowWithArrowBtn(
                                    text: "Sign Up With Google",
                                    onTap: () {
                                      cubit.googleSignIn();
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Already Have an account?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      CustomTextButton(
                                        text: "Login",
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
