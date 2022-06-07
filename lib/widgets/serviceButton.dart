import 'package:flutter/material.dart';

class ServiceButton extends StatefulWidget {
  const ServiceButton({required this.buttonText, Key? key}) : super(key: key);

  @override
  State<ServiceButton> createState() => _ServiceButtonState();
  final String buttonText;
}

class _ServiceButtonState extends State<ServiceButton> {
  @override
  Widget build(BuildContext context) {
    var wd = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SizedBox(
        width: wd / 1.25,
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            widget.buttonText,
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              side: MaterialStateProperty.all(
                  BorderSide(color: Colors.cyanAccent, width: 3)),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
        ),
      ),
    );
  }
}
