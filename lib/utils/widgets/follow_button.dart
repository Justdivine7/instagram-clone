import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  final Function()? function;

  const FollowButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    required this.function,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        
        onPressed: widget.function,
        child: Container(
          
          width: 200,
          height:36,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: Border.all(
              color: widget.borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
