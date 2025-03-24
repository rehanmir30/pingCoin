import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/colors.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({super.key});

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(
            "SILVER SPOT PRICE",
            style: TextStyle(color: rWhite, fontSize: 13, fontWeight: FontWeight.w600),
          ).marginOnly(top: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: rHint),
                  ),
                  Column(
                    children: [
                      Text(
                        "LBMA London",
                        style: TextStyle(color: rWhite),
                      ),
                      Text(
                        "AM   US 30.79",
                        style: TextStyle(color: rWhite),
                      ),
                    ],
                  ).marginOnly(left: 8)
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: rHint),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shanghai",
                        style: TextStyle(color: rWhite),
                      ),
                      Text(
                        "AM US 32.35",
                        style: TextStyle(color: rWhite),
                      ),
                    ],
                  ).marginOnly(left: 8)
                ],
              ),
            ],
          ).marginOnly(top: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SILVER MELT VALUE ",
                style: TextStyle(
                  color: rWhite,
                  fontSize: 10,
                ),
              ),
              Text(
                "US 30.35 ",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                ),
              ),
            ],
          ).marginOnly(top: 8, bottom: 8)
        ],
      ),
    );
  }
}
