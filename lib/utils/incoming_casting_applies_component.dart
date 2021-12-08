import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/viewmodels/casting_applies_list_view_model.dart';
import 'package:pimo/viewmodels/casting_applies_view_model.dart';
import 'package:intl/intl.dart';

class IncomingAppliesListComponent extends StatefulWidget {
  final CastingAppliesListViewModel listApplies;
  IncomingAppliesListComponent({Key key, this.listApplies}) : super(key: key);

  @override
  IncomingCastingListComponentState createState() =>
      IncomingCastingListComponentState();
}

class IncomingCastingListComponentState
    extends State<IncomingAppliesListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listApplies.listCastingApplies.length,
      itemBuilder: (context, index) {
        return CastingCard(castingApplies: widget.listApplies.listCastingApplies[index]);
      },
    );
  }
}

class CastingCard extends StatelessWidget {
  final CastingAppliesViewModel castingApplies;
  const CastingCard({Key key, this.castingApplies}) : super(key: key);

  String formatDate(String date) {
    DateTime dt = DateTime.parse(date);;
    var formatter = new DateFormat('HH:mm - dd MMM, yyyy');
    return formatter.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: MaterialColors.mainColor.withOpacity(0.5),
                offset: Offset(0, 5),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    castingApplies.casting.name ?? '',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  castingApplies.casting.salary.toString() + 'VNĐ' ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent),
                ),
              ],
            ),
            Container(
              child: Text(
                castingApplies.casting.description ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              children: [
                Text('Bắt đầu: '),
                Text(
                  formatDate(castingApplies.casting.openTime) ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text('Kết thúc: '),
                Text(
                  formatDate(castingApplies.casting.closeTime) ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
