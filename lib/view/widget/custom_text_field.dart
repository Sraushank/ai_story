import 'package:flutter/cupertino.dart';
import '../utils/app_color/colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    bool isTextEmpty = controller.text.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CupertinoTextField(
        controller: controller,
        placeholder: 'Enter your story prompt',
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        suffix: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: isLoading
              ? const CupertinoActivityIndicator()
              : CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: isTextEmpty ? null : onSend,
                  child: Icon(
                    CupertinoIcons.arrow_right_circle_fill,
                    size: 40,
                    color: isTextEmpty ? null : AppColors.darkBlue,
                  ),
                ),
        ),
      ),
    );
  }
}
