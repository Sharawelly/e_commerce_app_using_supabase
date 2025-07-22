import 'package:e_commerce_app_using_supabase/core/components/custom_circle_pro_ind.dart';
import 'package:e_commerce_app_using_supabase/core/functions/show_message.dart';
import 'package:e_commerce_app_using_supabase/views/product_details/logic/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/app_colors.dart';
import 'package:e_commerce_app_using_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/forgot_view.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/signup_view.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_row_with_arrow.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_text_btn.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_text_field.dart';
import 'package:e_commerce_app_using_supabase/views/nav_bar/ui/main_home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showMessage(context, state.errorMessage);
        } else if (state is LoginSuccess) {
          navigateTo(context, MainHomeView());
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          body: state is LoginLoading
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
                                  CustomTextFormField(
                                    controller: emailController,
                                    labelText: "Email",
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    labelText: "Password",
                                    isSecured: true,
                                    suffIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomTextButton(
                                        text: "Forgot Password?",
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const ForgotView(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  CustomRowWithArrowBtn(
                                    text: "Login",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomRowWithArrowBtn(
                                    text: "Login With Google",
                                    onTap: () =>
                                        navigateTo(context, MainHomeView()),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Don't Have an account?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      CustomTextButton(
                                        text: "Sign Up",
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const SignupView(),
                                          );
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
                ),
        );
      },
    );
  }
}
