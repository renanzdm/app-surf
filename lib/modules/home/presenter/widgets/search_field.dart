import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final double width;
  final Function(String)? onChanged;

  const SearchField({
    Key? key,
    required this.width,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white12, borderRadius: BorderRadius.circular(12)),
            child: TextField(
              focusNode: myFocusNode,
              onChanged: widget.onChanged,
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar Praia',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              child: Placeholder(),
            ),
          ),
        ],
      ),
    );
  }
}
