import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WatchListItem extends StatefulWidget {
  const WatchListItem(
      {Key? key,
      required this.logo,
      required this.id,
      required this.name,
      required this.price,
      required this.percent});

  final String? logo;
  final String? id;
  final String? name;
  final String? price;
  final String? percent;

  @override
  _WatchListItemState createState() => _WatchListItemState();
}

class _WatchListItemState extends State<WatchListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width - 40,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(children: [
                  CircleAvatar(
                    child: widget.logo!.endsWith('.svg')
                        ? SvgPicture.network(widget.logo!)
                        : Image.network(widget.logo!),
                  ),
                  Container(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      Row(
                        children: [
                          Text(
                            widget.id!,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            double.parse(widget.percent!) > 0
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: double.parse(widget.percent!) > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                          Text(
                            '${(double.parse(widget.percent!) * 100).toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: double.parse(widget.percent!) > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ]),
              ),
              Text(
                double.parse(widget.price!) < 10
                    ? (double.parse(widget.price!)).toStringAsFixed(5)
                    : (double.parse(widget.price!)).toStringAsFixed(2),
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(
          height: 15,
          color: Colors.grey[300],
          thickness: 1,
        ),
      ],
    );
  }
}
