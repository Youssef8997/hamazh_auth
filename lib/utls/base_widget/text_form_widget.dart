import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamazh_auth/utls/helper/extension.dart';

import '../manger/color_manger.dart';

class TextFormWidget extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? help;
  final int? maxLine;
  final bool? isFilled;
  final bool? isPass;
  final Color? filledColor;
  final TextEditingController? controller;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixActive;
  final bool? active;
  final bool? obscure;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String?)? onSumbted;
  final Function(PointerDownEvent?)? onTapOutSide;

  const TextFormWidget(
      {super.key,
      this.label,
      this.controller,
      this.help,
      this.suffix,
      this.suffixActive,
      this.isFilled,
      this.filledColor,
      this.validator,
      this.active,
      this.onSumbted,
      this.textStyle,
      this.textInputFormatter,
      this.prefix,
      this.hint,
      this.onChange,
      this.keyboardType,
      this.onTap,
      this.maxLine,
      this.onTapOutSide,
      this.obscure,
      this.isPass});

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscure ?? false,
      onTapOutside: widget.onTapOutSide,
      maxLines: widget.maxLine ?? 1,
      onTap: widget.onTap,
      inputFormatters: widget.textInputFormatter,
      enabled: widget.active,
      controller: widget.controller,
      onChanged: widget.onChange,
      onFieldSubmitted: widget.onSumbted,
      style: widget.textStyle,
      keyboardType: widget.keyboardType,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        constraints: widget.maxLine != null
            ? null
            : BoxConstraints(
                minHeight: context.height * .057,
                maxHeight: context.height * .057),
        helperText: widget.help,
        labelText: widget.label,
        suffixIcon: widget.suffixActive,
        suffix: widget.suffix,
        prefixIcon: widget.prefix,
        hintText: widget.hint,
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 40, minHeight: 20),
        filled: true,
        fillColor: widget.filledColor ?? ColorsManger.white,
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                width: .8, color: ColorsManger.pColor, strokeAlign: 2)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: .8,
              color: ColorsManger.pColor,
              strokeAlign: 2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                width: .8, color: ColorsManger.pColor, strokeAlign: 2)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                width: .8, color: ColorsManger.pColor, strokeAlign: 2)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: widget.validator ??
          (value) {
            if (value != null && value.isEmpty) {
              return "من فضلك تاكد من تلك المعلومات ";
            } else {
              return null;
            }
          },
    );
  }
}
