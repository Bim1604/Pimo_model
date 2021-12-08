import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/viewmodels/casting_result_list_view_model.dart';
import 'package:pimo/viewmodels/casting_result_view_model.dart';

class CastingResultComponent extends StatefulWidget {

  final CastingResultListViewModel castingResult;
  CastingResultComponent({Key key, this.castingResult}) : super(key: key);

  @override
  CastingResultComponentState createState() =>  CastingResultComponentState();
}

class CastingResultComponentState extends State<CastingResultComponent> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: widget.castingResult.listCastResult.length,
      itemBuilder: (context, index) {
        return CastingResultCard(result: widget.castingResult.listCastResult[index]);
      },
    );
  }
}

class CastingResultCard extends StatelessWidget {
  final CastingResultViewModel result;
  const CastingResultCard({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
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
                    result.casting.name?? '',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Container(
                    child: Expanded(
                      child: Text(
                        result.casting.status ?  'Hoàn thành' : 'Kết thúc' ,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: result.casting.status == true
                            ? Colors.green
                            : result.casting.status == false
                            ? Colors.grey[800]
                            : Colors.redAccent)
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  result.casting.salary.toString()+ " VNĐ"?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent),
                ),
              ],
            ),
            Row(
              children: [
                Text('Bắt đầu: '),
                Text(
                  result.castingResultStartDate ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text('Kết thúc: '),
                Text(
                  result.castingResultEndDate ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}