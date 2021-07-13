import 'package:crypto_project_demo11_linechart/data/model/coin_response.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/coin_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'datatable.dart';

class OpenPanel extends StatefulWidget {
  final List<Coin> coin;
  final bool isAscending;

  OpenPanel(this.coin, this.isAscending);

  @override
  _OpenPanelState createState() =>
      _OpenPanelState(coin: coin, isAscending: isAscending);
}

class _OpenPanelState extends State<OpenPanel> {
  List<Coin> coin;

  _OpenPanelState({required this.coin, required this.isAscending});

  bool isAscending;

  @override
  Widget build(BuildContext context) {
    int screenHeight = MediaQuery.of(context).size.height.toInt();
    int? _currentSortColumn;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 5, top: 10),
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(12.0))),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight < 750 ? 5 : 15,
                bottom: screenHeight < 750 ? 5 : 15),
            height: screenHeight < 750 ? 130 : 190,
            child: PieChart(
              PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  // sectionsSpace: 0,
                  startDegreeOffset: -90,
                  centerSpaceRadius: screenHeight < 750 ? 35 : 55,
                  sections: showingSections()),
              // swapAnimationDuration: Duration(milliseconds: 150), // Optional
              // swapAnimationCurve: Curves.linear,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('\$1,585',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const Text('Crypto', style: TextStyle(fontSize: 16)),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xffec6d33),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('\$972',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const Text('Cash', style: TextStyle(fontSize: 16)),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xff51a553),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('\$5,081',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const Text('Custody', style: TextStyle(fontSize: 16)),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xff0073f7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 48,
                  margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: TextField(
                    onChanged: (text) {
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchingEvent(text, coin));
                    },
                    onSubmitted: (text) {
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchingEvent(text, coin));
                    },
                    style: const TextStyle(height: 1.5),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                        bottom: 11,
                        top: 12,
                      ),
                      border: InputBorder.none,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      filled: true,
                      fillColor: Color(0xffebebeb),
                      hintText: 'Search...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                BlocListener<CoinBloc, CoinState>(
                  listener: (context, state) {
                    if (state is SortNameState) {
                      _currentSortColumn = 0;
                      isAscending = !isAscending;
                      coin = state.sortList;
                    } else if (state is SortPriceState) {
                      _currentSortColumn = 1;
                      isAscending = !isAscending;
                      coin = state.sortList;
                    }
                  },
                  child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, searchState) {
                    if (searchState is SearchingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (searchState is SearchSuccessState) {
                      return DatatableItem(
                          coin: searchState.resultList,
                          isAscending: isAscending,
                          currentSortColumn: _currentSortColumn);
                    } else if (searchState is SearchFailureState) {
                      return const Expanded(
                        child: Center(
                          child: Image(
                            image: AssetImage('images/noResult3.png'),
                          ),
                        ),
                      );
                    } else if (searchState is SearchNull) {
                      return DatatableItem(
                          coin: coin,
                          isAscending: isAscending,
                          currentSortColumn: _currentSortColumn);
                    }
                    return DatatableItem(
                        coin: coin,
                        isAscending: isAscending,
                        currentSortColumn: _currentSortColumn);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      // final isTouched = i == touchedIndex;
      // final double fontSize = isTouched ? 40 : 16;
      // final double radius = isTouched ? 60 : 50;
      double fontSize = 10;
      double radius = 30;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 65,
            title: '65%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffec6d33),
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff51a553),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
