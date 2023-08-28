import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({super.key, this.hintText,this.controller, this.keyboardType,this.onChanged, this.onSaved, this.initialValue});

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          onSaved: onSaved,
          keyboardType: keyboardType,
          initialValue: initialValue,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            hintText: hintText,
            // hintStyle: const TextStyle(fontSize: 14),
             hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w300
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 1)
            ),
             focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white30, width: 1)
            ),
             enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 1)
            ),
          ),
        ),
      ),
    );
  }
}
