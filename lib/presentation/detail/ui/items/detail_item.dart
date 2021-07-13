import 'package:crypto_project_demo11_linechart/presentation/detail/bloc/detail_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/detail/ui/items/raised_gradient_button.dart';
import 'package:crypto_project_demo11_linechart/presentation/detail/ui/items/status_item.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/coin_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class DetailItem extends StatefulWidget {
  const DetailItem({Key? key}) : super(key: key);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  DateTime toDay = DateTime.now();

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

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
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is LoadDetailSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: state.coin.elementAt(0).logoUrl!.endsWith('.svg')
                            ? SvgPicture.network(
                                state.coin.elementAt(0).logoUrl!)
                            : Image.network(state.coin.elementAt(0).logoUrl!),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state.coin.elementAt(0).name!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<CoinBloc>(context).add(
                            AddFavoriteEvent(
                              email: FirebaseAuth.instance.currentUser!.email
                                  .toString(),
                              coin: state.coin.elementAt(0).id.toString(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.star_border,
                        ),
                        iconSize: 20,
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            double.parse(state.coin.elementAt(0).price!) < 10
                                ? '\$${(double.parse(state.coin.elementAt(0).price!)).toStringAsFixed(5)}'
                                : '\$${(double.parse(state.coin.elementAt(0).price!)).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                state.coin.elementAt(0).id!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Icon(
                                double.parse(state.coin
                                            .elementAt(0)
                                            .the1D!
                                            .priceChangePct!) >
                                        0
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: double.parse(state.coin
                                            .elementAt(0)
                                            .the1D!
                                            .priceChangePct!) >
                                        0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              Text(
                                '${(double.parse(state.coin.elementAt(0).the1D!.priceChangePct!) * 100).toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: double.parse(state.coin
                                              .elementAt(0)
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
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    height: MediaQuery.of(context).size.height / 3,
                    child: LineChart(
                      mainData(
                        maxY: state.maxY,
                        minY: state.minY,
                        price: state.history.elementAt(0).prices,
                        time: state.history.elementAt(0).timestamps,
                      ),
                    ),
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Rank',
                        style: TextStyle(
                          color: Color(0xff070f71),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        state.coin.elementAt(0).rank.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 15,
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  StatusItem(
                      title: 'Market Cap',
                      price: state.coin.elementAt(0).marketCap.toString()),
                  // StatusItem(
                  //     title: '1 Hours Change',
                  //     price: state.coin
                  //         .elementAt(0)
                  //         .the1H!
                  //         .priceChange
                  //         .toString()),
                  StatusItem(
                      title: '1 Day Change',
                      price: state.coin
                          .elementAt(0)
                          .the1D!
                          .priceChange
                          .toString()),
                  // StatusItem(
                  //     title: '7 Days Change',
                  //     price: state.coin
                  //         .elementAt(0)
                  //         .the7D!
                  //         .priceChange
                  //         .toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: RaisedGradientButton(
                          child: const Text(
                            'Buy',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xff02072f),
                              Color(0xff0d1970)
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: RaisedGradientButton(
                          child: const Text(
                            'Sell',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xff02072f),
                              Color(0xff0d1970)
                            ],
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else if (state is LoadingDetailState) {
            return const SpinKitWave(
                color: Color(0xff070f51), type: SpinKitWaveType.start);
          } else if (state is LoadDetailFailureState) {
            return const Center(
              child: Text('Failure STATE'),
            );
          }
          return const Center(
            child: Text('OUT OF STATE'),
          );
        },
      ),
    );
  }

  LineChartData mainData({
    required double? minY,
    required double? maxY,
    required List<DateTime>? time,
    required List<String>? price,
  }) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return time!.elementAt(0).toString().substring(5, 10);
              case 10:
                return time!.elementAt(10).toString().substring(5, 10);
              case 20:
                return time!.elementAt(20).toString().substring(5, 10);
              case 29:
                return time!.elementAt(29).toString().substring(5, 10);
            }
            return '';
          },
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 29,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, double.parse(price!.elementAt(0))),
            FlSpot(1, double.parse(price.elementAt(1))),
            FlSpot(2, double.parse(price.elementAt(2))),
            FlSpot(3, double.parse(price.elementAt(3))),
            FlSpot(4, double.parse(price.elementAt(4))),
            FlSpot(5, double.parse(price.elementAt(5))),
            FlSpot(6, double.parse(price.elementAt(6))),
            FlSpot(7, double.parse(price.elementAt(7))),
            FlSpot(8, double.parse(price.elementAt(8))),
            FlSpot(9, double.parse(price.elementAt(9))),
            FlSpot(10, double.parse(price.elementAt(10))),
            FlSpot(11, double.parse(price.elementAt(11))),
            FlSpot(12, double.parse(price.elementAt(12))),
            FlSpot(13, double.parse(price.elementAt(13))),
            FlSpot(14, double.parse(price.elementAt(14))),
            FlSpot(15, double.parse(price.elementAt(15))),
            FlSpot(16, double.parse(price.elementAt(16))),
            FlSpot(17, double.parse(price.elementAt(17))),
            FlSpot(18, double.parse(price.elementAt(18))),
            FlSpot(19, double.parse(price.elementAt(19))),
            FlSpot(20, double.parse(price.elementAt(20))),
            FlSpot(21, double.parse(price.elementAt(21))),
            FlSpot(22, double.parse(price.elementAt(22))),
            FlSpot(23, double.parse(price.elementAt(23))),
            FlSpot(24, double.parse(price.elementAt(24))),
            FlSpot(25, double.parse(price.elementAt(25))),
            FlSpot(26, double.parse(price.elementAt(26))),
            FlSpot(27, double.parse(price.elementAt(27))),
            FlSpot(28, double.parse(price.elementAt(28))),
            FlSpot(29, double.parse(price.elementAt(29))),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
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