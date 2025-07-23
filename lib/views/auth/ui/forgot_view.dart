import 'package:e_commerce_app_using_supabase/core/components/custom_circle_pro_ind.dart';
import 'package:e_commerce_app_using_supabase/core/functions/show_message.dart';
import 'package:e_commerce_app_using_supabase/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/app_colors.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_elevated_btn.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          Navigator.pop(context);
          showMessage(context, "Password reset link sent to your email.");
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          body: state is PasswordResetLoading
              ? CustomCircleProgIndicator()
              : SafeArea(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Enter Your Email To Reset Password",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          color: AppColors.kWhiteColor,
                          margin: const EdgeInsets.all(24),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  labelText: "Email",
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                ),
                                const SizedBox(height: 20),
                                CustomEBtn(
                                  text: "Submit",

                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.resetPassword(
                                        email: emailController.text,
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
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
    );
  }
}
