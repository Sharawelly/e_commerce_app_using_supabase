import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/functions/build_appbar.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_elevated_btn.dart';
import 'package:e_commerce_app_using_supabase/views/auth/ui/widgets/custom_text_field.dart';


class EditNameView extends StatelessWidget {
  const EditNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Edit Name"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomTextFormField(labelText: "Enter Name"),
            const SizedBox(height: 15),
            CustomEBtn(text: "Update", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
