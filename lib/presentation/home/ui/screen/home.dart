import 'package:crypto_project_demo11_linechart/data/api/coin_api.dart';
import 'package:crypto_project_demo11_linechart/data/repositories/coin_responsitories.dart';
import 'package:crypto_project_demo11_linechart/domain/coin_Usecase/usecase/coin_usecase.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/coin_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/search_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/ui/items/left_child_container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/ui/items/close_panel.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/ui/items/open_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checkOpen = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Drawer(
        child: LeftChildContainer(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocProvider(
          create: (context) => HomeBloc(
            CoinUsecase(
              CoinRespositoryImpl(
                CoinAPI(Dio()),
              ),
            ),
          )..add(HomeLoadingSuccessEvent()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homeState) {
              if (homeState is HomeLoadingState) {
                return SlidingUpPanel(
                  onPanelOpened: () {
                    setState(() {
                      checkOpen = true;
                    });
                  },
                  onPanelClosed: () {
                    setState(() {
                      checkOpen = false;
                    });
                  },
                  minHeight: 0,
                  maxHeight: 0,
                  panel: Container(),
                  collapsed: Container(),
                  body: Container(
                    padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height - 300) / 5),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/bg.png'),
                      fit: BoxFit.cover,
                    )),
                    child: const Center(
                      child: SpinKitWave(
                          color: Colors.white, type: SpinKitWaveType.start),
                    ),
                  ),
                  borderRadius: radius,
                );
              } else if (homeState is HomeLoadingSuccessState) {
                return SlidingUpPanel(
                  onPanelOpened: () {
                    setState(() {
                      checkOpen = true;
                    });
                  },
                  onPanelClosed: () {
                    setState(() {
                      checkOpen = false;
                    });
                  },
                  minHeight: 380,
                  maxHeight: screenHeight - 100,
                  panel: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => SearchBloc(),
                      ),
                      BlocProvider(
                        create: (context) => CoinBloc(),
                      )
                    ],
                    child: OpenPanel(homeState.listCoin, true),
                  ),
                  collapsed: BlocProvider(
                    create: (context) => CoinBloc(),
                    child: ClosePanel(
                        coin: homeState.listCoin, isAscending: false),
                  ),
                  body: Container(
                    padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height - 300) / 5),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/bg.png'),
                      fit: BoxFit.cover,
                    )),
                    child: Column(
                      children: [
                        const Text(
                          'Balance',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const Text(
                          "\$7,654.32",
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'CRYPTO',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      '\$1,567',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'CASH',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      '\$876',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'CUSTODY',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      '\$5,158',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  borderRadius: radius,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
