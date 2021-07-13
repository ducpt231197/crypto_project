import 'package:crypto_project_demo11_linechart/data/model/coin_response.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/coin_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'datatable.dart';


class ClosePanel extends StatefulWidget {
  final bool checkOpen = false;
  late final bool isAscending;
  late final List<Coin> coin;

  ClosePanel({Key? key, required this.coin, required this.isAscending}): super(key: key);

  @override
  _ClosePanelState createState() =>
      _ClosePanelState();
}

class _ClosePanelState extends State<ClosePanel> {
  // _ClosePanelState({required this.checkOpen, required this.coin});

  bool checkOpen = false;

  @override
  Widget build(BuildContext context) {
    int? _currentSortColumn;
    return IgnorePointer(
      ignoring: checkOpen ? true : false,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            ),
            BlocListener<CoinBloc, CoinState>(
              listener: (context, state) {
                if (state is SortNameState) {
                  _currentSortColumn = 0;
                  widget.isAscending = !widget.isAscending;
                  widget.coin = state.sortList;
                } else if (state is SortPriceState) {
                  _currentSortColumn = 1;
                  widget.isAscending = !widget.isAscending;
                  widget.coin = state.sortList;
                }
              },
              child: DatatableItem(
                  coin: widget.coin,
                  isAscending: widget.isAscending,
                  currentSortColumn: _currentSortColumn),
            )
          ],
        ),
      ),
    );
  }
}
