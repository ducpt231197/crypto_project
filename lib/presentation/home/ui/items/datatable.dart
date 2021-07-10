import 'package:crypto_project_demo10_database/data/model/coin_response.dart';
import 'package:crypto_project_demo10_database/presentation/detail/ui/screen/detail_screen.dart';
import 'package:crypto_project_demo10_database/presentation/home/bloc/coin_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DatatableItem extends StatefulWidget {
  final bool isAscending;
  final int? currentSortColumn;
  final List<Coin> coin;

  const DatatableItem(
      {Key? key,
      required this.coin,
      required this.isAscending,
      required this.currentSortColumn})
      : super(key: key);

  @override
  _DatatableItemState createState() => _DatatableItemState();
}

class _DatatableItemState extends State<DatatableItem> {
  bool sort = false;

  @override
  void initState() {
    sort = widget.isAscending;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoinBloc, CoinState>(
      listener: (context, state) {
        if (state is AddingFavoriteState) {
          _showSnackBarLoading(context);
        } else if (state is AddFavoriteFailureState) {
          _showSnackBarFailure(context);
        } else if (state is AddFavoriteSuccessState) {
          _showSnackBarSuccess(context, state.coin);
        } else if (state is DeleteFavoriteSuccessState) {
          _showSnackBarDelete(context);
        }
      },
      child: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                horizontalMargin: 0,
                sortAscending: widget.isAscending,
                sortColumnIndex: widget.currentSortColumn,
                columns: <DataColumn>[
                  DataColumn(
                    label: Container(
                        margin: const EdgeInsets.only(left: 50),
                        child: const Text('Name')),
                    tooltip: 'Name of crypto',
                    onSort: (columnIndex, _) {
                      setState(
                        () {
                          sort = !sort;
                          BlocProvider.of<CoinBloc>(context)
                              .add(SortNameEvent(widget.coin, sort));
                        },
                      );
                    },
                  ),
                  DataColumn(
                      label: const Text('Price'),
                      tooltip: 'Price of crypto',
                      onSort: (columnIndex, _) {
                        setState(
                          () {
                            sort = !sort;
                            BlocProvider.of<CoinBloc>(context)
                                .add(SortPriceEvent(widget.coin, sort));
                          },
                        );
                      }),
                ],
                rows: List<DataRow>.generate(
                  widget.coin.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<CoinBloc>(context).add(
                                    AddFavoriteEvent(
                                      email: FirebaseAuth
                                          .instance.currentUser!.email
                                          .toString(),
                                      coin: widget.coin
                                          .elementAt(index)
                                          .id
                                          .toString(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.star_border,
                                ),
                                iconSize: 20,
                              ),
                              CircleAvatar(
                                child: widget.coin
                                        .elementAt(index)
                                        .logoUrl!
                                        .endsWith('.svg')
                                    ? SvgPicture.network(
                                        widget.coin.elementAt(index).logoUrl!)
                                    : Image.network(
                                        widget.coin.elementAt(index).logoUrl!),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.coin.elementAt(index).name!,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.coin.elementAt(index).id!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Icon(
                                        double.parse(widget.coin
                                                    .elementAt(index)
                                                    .the1D!
                                                    .priceChangePct!) >
                                                0
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: double.parse(widget.coin
                                                    .elementAt(index)
                                                    .the1D!
                                                    .priceChangePct!) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      Text(
                                        '${(double.parse(widget.coin.elementAt(index).the1D!.priceChangePct!) * 100).toStringAsFixed(2)}%',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: double.parse(widget.coin
                                                      .elementAt(index)
                                                      .the1D!
                                                      .priceChangePct!) >
                                                  0
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ), onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      id: widget.coin.elementAt(index).id,
                                    )));
                      }),
                      DataCell(
                        Text(
                          double.parse(widget.coin.elementAt(index).price!) < 10
                              ? (double.parse(
                                      widget.coin.elementAt(index).price!))
                                  .toStringAsFixed(5)
                              : (double.parse(
                                      widget.coin.elementAt(index).price!))
                                  .toStringAsFixed(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showSnackBarSuccess(BuildContext context, String coin) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
      content: const Text('Add to watch list successful',
          style: TextStyle(
            color: Colors.black,
          )),
      action: SnackBarAction(
        label: 'Undo',
        textColor: Colors.black,
        onPressed: () {
          BlocProvider.of<CoinBloc>(context).add(
            DeleteFavoriteEvent(
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              coin: coin,
            ),
          );
        },
      ),
    ),
  );
}

void _showSnackBarLoading(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      duration: const Duration(milliseconds: 1500),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(
            height: 25,
            width: 51,
            child: SpinKitWave(
                color: Color(0xff070f51), type: SpinKitWaveType.start),
          ),
          const SizedBox(width: 10),
          const Text('Adding to watch list',
              style: TextStyle(
                color: Colors.black,
              )),
        ],
      ),
    ),
  );
}

void _showSnackBarFailure(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      content: Text(
        'This coin is in your watch list already',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

void _showSnackBarDelete(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      content: Text(
        'Deleted',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}
