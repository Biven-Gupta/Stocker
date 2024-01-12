import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task/main.dart';
import 'package:task/model/item_list.dart';
import 'package:task/utils/utils.dart';
import 'package:task/utils/widgets.dart';
import 'package:task/view_model/home_view_model.dart';
import 'package:task/view_model/login_view_model.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginViewModel _loginViewModel = LoginViewModel.instance;
  final HomeViewModel _homeViewModel = HomeViewModel.instance;
  // final ScrollController _scrollController = ScrollController();
  final int itemsPerPage = 10;
  ItemList? _itemList = ItemList();
  // List<HomeResponse>? _itemListPaginated = [];
  StreamSubscription? _homeResponseData;

  @override
  void initState() {
    super.initState();
    _homeViewModel.content();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeResponseData = _homeViewModel.contentResponseBehaviorSubject.listen((ItemList? value) {
      log(value.toString(), name: "Home content results");
      if (value != null) {
        if (mounted) {
          _itemList = value;
          //_loadItems();
        }
      }
    }, onError: (value) {
      Utils.showErrorToast(context, message: "Something went wrong please try again");
    });
  }

  void showNotification(String name, String price) async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails("Stockers", "Trading", priority: Priority.max, importance: Importance.max);
    DarwinNotificationDetails iOSNotificationDetails = const DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);
    await notificationsPlugin.show(0, name, price, notificationDetails);
  }

/*  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadItems();
    }
  }

   void _loadItems() {
    for (int i = 0; i < itemsPerPage; i++) {
      _itemListPaginated?.add(_itemList!.items![_itemListPaginated!.length + 1]);
    } setState(() {});
  }*/

  @override
  void dispose() {
    super.dispose();
    _homeResponseData?.cancel();
    // _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: Image.asset(
              "assets/background.png",
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Row(
                children: [
                  Icon(
                    Icons.fact_check_outlined,
                    size: 30,
                    weight: 50,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Stocks",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Are sure you want to Logout?",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    _loginViewModel.logout();
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (r) => false);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.logout_rounded, size: 30)),
                )
              ],
            ),
            body: StreamBuilder(
              stream: _homeViewModel.contentResponseBehaviorSubject,
              builder: (context, snapshot) {
                log("Snapshot Data ${snapshot.hasData}");
                log("Snapshot Data ${snapshot.data}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Widgets.isLoading(col: Colors.deepOrange);
                } else if (snapshot.hasData) {
                  log("Snapshot Data IF ELSE BLOCK ${snapshot.data}");
                  return Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: ListView.builder(
                      itemCount: _itemList?.items?.length ?? 0 + 1,
                      itemBuilder: (context, position) {
                        // if (position < _itemListPaginated!.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                showNotification(_itemList?.items?[position].name ?? "N/A", _itemList?.items?[position].price.toString() ?? "0.0");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.orange[200], backgroundBlendMode: BlendMode.luminosity),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_itemList?.items?[position].name ?? "N/A", style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                                    Text(_itemList?.items?[position].price.toString() ?? "N/A",
                                        style: const TextStyle(fontSize: 36, color: Colors.deepOrange, fontWeight: FontWeight.w900)),
                                    Row(
                                      children: [
                                        Text(_itemList?.items?[position].type ?? "N/A",
                                            style: const TextStyle(fontSize: 16, color: Colors.deepOrange, fontWeight: FontWeight.w900)),
                                        const SizedBox(width: 20),
                                        Text(_itemList?.items?[position].exchange ?? "N/A", style: const TextStyle(fontSize: 16, color: Colors.black)),
                                        const SizedBox(width: 20),
                                        Text("\"${_itemList?.items?[position].exchangeShortName ?? "N/A"}\"",
                                            style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        // } else {
                        //   return const Center(child: CircularProgressIndicator());
                        // }
                      },
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No data found!", style: TextStyle(fontSize: 24, color: Colors.deepOrange, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            _homeViewModel.content();
                          },
                          child: const Text("Retry"))
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
