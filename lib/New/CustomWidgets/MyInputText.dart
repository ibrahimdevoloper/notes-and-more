import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInputText extends StatelessWidget {
  final TextEditingController _controller;
  bool _isEmpty;

  //TODO: add onchange and oneditingdone
  Function(String) _onChanged;
  String _errorMessage;
  bool _isPassword=false;

  MyInputText({
    @required TextEditingController controller,
    bool isEmpty = true,
    Function(String) onChange,
    String errorMessage,
    bool isPassword=false,
  })  : this._controller = controller,
        this._onChanged = onChange,
        this._errorMessage = errorMessage,
        this._isPassword = isPassword,
        this._isEmpty = isEmpty;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16,
        vertical: 10),
        errorText: _errorMessage,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        fillColor: Color(0xFFF2F2F2),
        filled: _isEmpty,
      ),
      onChanged: (value) => this._onChanged,
    );
  }
}
