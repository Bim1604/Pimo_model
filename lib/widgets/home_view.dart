import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';

class CardHorizontal extends StatelessWidget {
  //Khai báo những thuộc tính có trong 1 object
  CardHorizontal(
      {this.title = "Placeholder Title",
        this.cta = "",
        this.name,
        this.id,
        this.openTime,
        this.address,
        this.closeTime,
        this.description,
        this.img,
        this.tap = defaultFunc});

  final String name;
  final String address;
  final String openTime;
  final String closeTime;
  final String description;
  final String cta;
  final String img;
  final int id;
  final Function tap;
  final String title;

  factory CardHorizontal.fromJson(Map<String, dynamic> json) {
    return CardHorizontal(
      name: json['casting']['name'],
      id: json['casting']['id'],
      description: json['casting']['description'],
      openTime: json['casting']['openTime'],
      closeTime: json['casting']['closeTime'],
      address: json['casting']['address'],
      img: json['casting']['poster'],
    );
  }

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        margin: EdgeInsets.only(top: 10),
        child: GestureDetector(
          onTap: tap,
          child: Stack(overflow: Overflow.clip, children: [
            Card(
              elevation: 0.7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Row(
                children: [
                  Flexible(flex: 1, child: Container()),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: TextStyle(
                                    color: MaterialColors.caption,
                                    fontSize: 15)),
                            Text(cta,
                                style: TextStyle(
                                    color: MaterialColors.muted,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            Text('Bắt đầu: '+openTime,
                                style: TextStyle(
                                    color: MaterialColors.muted,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300)),
                            Text('Kết thúc: '+closeTime,
                                style: TextStyle(
                                    color: MaterialColors.muted,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            FractionalTranslation(
              translation: Offset(0.0, -0.09),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0, left: 13, right: 13),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 0, top: 16),
                      height: 127,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          image: DecorationImage(
                              image: NetworkImage(img), fit: BoxFit.cover))),
                ),
              ),
            ),
          ]),
        ));
  }
}