import 'package:crypto_project_demo11_linechart/data/api/coin_api.dart';
import 'package:crypto_project_demo11_linechart/data/repositories/coin_responsitories.dart';
import 'package:crypto_project_demo11_linechart/domain/coin_Usecase/usecase/coin_usecase.dart';
import 'package:crypto_project_demo11_linechart/presentation/detail/ui/screen/detail_screen.dart';
import 'package:crypto_project_demo11_linechart/presentation/favorite/bloc/favorite_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/coin_bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_project_demo11_linechart/presentation/favorite/ui/items/watch_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}): super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FavoriteBloc(
              CoinUsecase(
                CoinRespositoryImpl(
                  CoinAPI(Dio()),
                ),
              ),
            )..add(
                FavoriteLoadingSuccessEvent(
                  FirebaseAuth.instance.currentUser!.email.toString(),
                ),
              ),
          ),
          BlocProvider(
            create: (context) => CoinBloc(),
          ),
        ],
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                    fit: StackFit.loose,
                    alignment: const Alignment(0, 0),
                    children: [
                      const Text(
                        'Watch List',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Positioned(
                          left: 20,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 25,
                            ),
                          )),
                    ]),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const TextField(
                          style: TextStyle(height: 1.5),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 14.0, bottom: 20.0, top: 17.5),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0)),
                            ),
                            filled: true,
                            fillColor: Color(0xffebebeb),
                            hintText: 'Search...',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[300],
                          thickness: 3,
                        ),
                        BlocBuilder<FavoriteBloc, FavoriteState>(
                          builder: (context, state) {
                            if (state is FavoriteLoadingSuccessState) {
                              return Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.listCoin.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onLongPress: () async {
                                        var a = await showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Remove ?'),
                                            content: RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  const TextSpan(
                                                      text: 'Remove '),
                                                  TextSpan(
                                                    text: state.listCoin
                                                        .elementAt(index)
                                                        .id,
                                                    style: const TextStyle(
                                                      color: Color(0xff070f71),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                      text:
                                                          ' from watch list?'),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text(
                                                  'No',
                                                  style: TextStyle(
                                                    color: Color(0xff070f71),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, "cancel");
                                                },
                                              ),
                                              TextButton(
                                                child: const Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                    color: Color(0xff070f71),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, "remove");
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                        if (a == 'remove') {
                                          BlocProvider.of<CoinBloc>(context)
                                              .add(
                                            DeleteFavoriteEvent(
                                              email: FirebaseAuth
                                                  .instance.currentUser!.email
                                                  .toString(),
                                              coin: state.listCoin
                                                  .elementAt(index)
                                                  .id!,
                                            ),
                                          );
                                          BlocProvider.of<FavoriteBloc>(context)
                                              .add(
                                            FavoriteLoadingSuccessEvent(
                                              FirebaseAuth.instance.currentUser!.email.toString(),
                                            ),
                                          );
                                        }
                                      },
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      id: state.listCoin
                                                          .elementAt(index)
                                                          .id,
                                                    )));
                                      },
                                      child: WatchListItem(
                                        logo: state.listCoin
                                            .elementAt(index)
                                            .logoUrl,
                                        name: state.listCoin
                                            .elementAt(index)
                                            .name,
                                        id: state.listCoin.elementAt(index).id,
                                        percent: state.listCoin
                                            .elementAt(index)
                                            .the1D!
                                            .priceChangePct,
                                        price: state.listCoin
                                            .elementAt(index)
                                            .price,
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (state is FavoriteLoadingState) {
                              return const Expanded(
                                child: SpinKitWave(
                                    color: Color(0xff070f51),
                                    type: SpinKitWaveType.start),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
