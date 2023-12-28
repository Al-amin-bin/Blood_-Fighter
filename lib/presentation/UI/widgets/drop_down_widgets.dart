import 'package:flutter/material.dart';

class DropDownWidgets extends StatefulWidget {
  const DropDownWidgets({
    Key? key,
    required this.dropDownList,
    required this.onChanged,
    required this.dropdownValue,
  }) : super(key: key);

  final List<String> dropDownList;
  final String dropdownValue;
  final ValueChanged<String> onChanged;

  @override
  State<DropDownWidgets> createState() => _DropDownWidgetsState();
}

class _DropDownWidgetsState extends State<DropDownWidgets> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
        child: DropdownButton(
          value: widget.dropdownValue,
          items: widget.dropDownList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            widget.onChanged(value!);
          },
          isExpanded: true,
          underline: Container(),
          style: TextStyle(fontSize: 20, color: Colors.black),
          dropdownColor: Colors.white,
          iconEnabledColor: Colors.black,
        ),
      ),
    );
  }
}
