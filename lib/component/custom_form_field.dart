import 'package:flutter/material.dart';
typedef MyValidator = String? Function(String?);
class CustomFormField extends StatelessWidget {
String hintText ;
MyValidator validator;
TextEditingController controller;
TextInputType keyboardType ;
IconButton? suffix;
bool isPassword;
CustomFormField({required this.hintText,required this.validator,required this.controller,this.keyboardType = TextInputType.text,this.suffix,this.isPassword = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      //textDirection: TextDirection,
      style: TextStyle(
          color: Color(0xffEDEDED)
      ),
      decoration: InputDecoration(
        suffixIcon: suffix,
        //labelText: 'Email',
        hintText: hintText,
        //suffixIcon: ,
        hintStyle: const TextStyle(
          color: Color(0xffEDEDED)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        fillColor:const Color(0xff444444),
          filled: true
      ),
    );
  }
}
