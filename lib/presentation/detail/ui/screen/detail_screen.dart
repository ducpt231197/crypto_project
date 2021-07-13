import 'package:crypto_project_demo11_linechart/data/api/coin_api.dart';
import 'package:crypto_project_demo11_linechart/data/repositories/coin_responsitories.dart';
import 'package:crypto_project_demo11_linechart/domain/coin_Usecase/usecase/coin_usecase.dart';
import 'package:crypto_project_demo11_linechart/presentation/detail/bloc/detail_bloc.dart';
import 'package:crypto_project_demo11_linechart/presentation/detail/ui/items/detail_item.dart';
import 'package:crypto_project_demo11_linechart/presentation/home/bloc/coin_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                      'Detail',
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
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                      color: Colors.white),
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => DetailBloc(
                          CoinUsecase(
                            CoinRespositoryImpl(
                              CoinAPI(
                                Dio(
                                  BaseOptions(
                                    connectTimeout: 5000,
                                    // receiveTimeout: 10000
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )..add(LoadDetailEvent(id!)),
                      ),
                      BlocProvider(create: (context) => CoinBloc())
                    ],
                    child: const DetailItem(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
