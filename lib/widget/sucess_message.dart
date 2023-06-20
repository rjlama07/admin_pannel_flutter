import 'package:admin_pannel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SucessMessage extends StatelessWidget {
  const SucessMessage({
    super.key,
    required this.message,
    required this.onpressed,
    required this.buttonlabel,
  });
  final String message;
  final Function onpressed;
  final String buttonlabel;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
          height: 200,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                  height: 100,
                  child: Center(
                      child: Lottie.asset("assets/lottie/sucessfull.json"))),
              const SizedBox(height: 8),
              Text(
                message,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  onpressed();
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                  child: Center(
                    child: Text(
                      buttonlabel,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
