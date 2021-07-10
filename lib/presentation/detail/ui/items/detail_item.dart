import 'package:crypto_project_demo10_database/presentation/detail/bloc/detail_bloc.dart';
import 'package:crypto_project_demo10_database/presentation/detail/ui/items/raised_gradient_button.dart';
import 'package:crypto_project_demo10_database/presentation/detail/ui/items/status_item.dart';
import 'package:crypto_project_demo10_database/presentation/home/bloc/coin_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                  Divider(
                    height: 15,
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  const Placeholder(
                    fallbackHeight: 300,
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
                  StatusItem(
                      title: '1 Hours Change',
                      price: state.coin
                          .elementAt(0)
                          .the1H!
                          .priceChange
                          .toString()),
                  StatusItem(
                      title: '1 Day Change',
                      price: state.coin
                          .elementAt(0)
                          .the1D!
                          .priceChange
                          .toString()),
                  StatusItem(
                      title: '7 Days Change',
                      price: state.coin
                          .elementAt(0)
                          .the7D!
                          .priceChange
                          .toString()),
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
            return const Expanded(
              child: SpinKitWave(
                  color: Color(0xff070f51), type: SpinKitWaveType.start),
            );
          }
          return Container(
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height - 300) / 5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text('OUT OF STATE'),
            ),
          );
        },
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
