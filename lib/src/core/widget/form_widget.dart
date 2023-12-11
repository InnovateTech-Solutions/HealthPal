// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/model/form_model.dart';

class FormWidget extends StatefulWidget {
  FormWidget({required this.textForm, Key? key}) : super(key: key);
  FormModel textForm;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2)),
          ],
        ),
        child: TextFormField(
            onTap: widget.textForm.onTap,
            readOnly: widget.textForm.enableText,
            inputFormatters: widget.textForm.inputFormat,
            keyboardType: widget.textForm.type,
            onChanged: widget.textForm.onChange,
            validator: widget.textForm.validator,
            obscureText: widget.textForm.invisible,
            controller: widget.textForm.controller,
            decoration: InputDecoration(
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.subappcolor),
                  borderRadius: const BorderRadius.all(Radius.circular(7))),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.subappcolor),
                  borderRadius: const BorderRadius.all(Radius.circular(7))),
              hintText: widget.textForm.hintText,
            )),
      ),
    );
  }
}
