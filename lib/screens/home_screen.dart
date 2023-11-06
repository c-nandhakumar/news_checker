import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_checker/screens/result_screen.dart';
import 'package:news_checker/widgets/textfield_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController queryController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic> body = {};
  Future<void> getFacts() async {
    Response response = await http.post(
        Uri.parse(
            "https://2301-2409-4072-8e83-f634-ed14-30ea-a8a5-fb78.ngrok-free.app/answer"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": queryController.text}));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode < 205) {
      setState(() {
        body = jsonDecode(response.body);
      });
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppBar(context: context),
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                children: [
                  TextFieldWidget(
                      readOnly: isLoading,
                      title: "Type Your Query",
                      controller: queryController),
                  isLoading
                      ? Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 64),
                            // child: Lottie.asset('assets/lottie/loader.json'),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/gifs/artificial-intelligence.gif",
                                  height: 200,
                                ),
                                const Text(
                                  "Analyzing Facts...",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              )),
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12, bottom: 16, top: 6),
          child: FilledButton(
            onPressed: isLoading
                ? () {
                    print("Inside");
                  }
                : () async {
                    try {
                      if (queryController.text.isEmpty) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Query shouldn't be empty. Please enter the query"),
                          behavior: SnackBarBehavior.floating,
                        ));
                        return;
                      }
                      if (isLoading == false) {
                        setState(() {
                          body = {};
                          isLoading = true;
                        });
                        print(queryController.text);
                        await Future.delayed(const Duration(seconds: 3), () {});
                        // await getFacts();
                        body = {
                          "validation": false,
                          "answer":
                              "According to the report, Police detained Jamia Millia Islamia students during a protest outside UP Bhawan against the demolition drive in UP in connection with the violence that broke out in New Delhi on June 13, 2022. ",
                          "link":
                              "https://newsmobile.in/articles/2023/10/31/fact-check-did-police-arrest-protesters-supporting-hamas-in-hardoi-up-heres-the-truth/",
                          "justification":
                              "NewsMobile fact-checked the viral post, and found it to be false. We first did a keyword search but did not find any report suggesting any pro-Palestine protest in Hardoi, Uttar Pradesh.",
                        };
                        if (body.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(createRoute(ResultScreen(
                              queryText: queryController.text, body: body)));
                        } else {
                          throw Exception();
                        }
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Oops.. Something went wrong"),
                        behavior: SnackBarBehavior.floating,
                      ));
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3.5,
                      ),
                    ),
                  )
                : const Text('Check Fact',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}

commonAppBar({bool? leading = false, required BuildContext context}) {
  return AppBar(
    leading: leading!
        ? IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            })
        : null,
    title: const Text.rich(TextSpan(children: [
      TextSpan(
          text: "NEWS",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff1e4da7))),
      TextSpan(
          text: "MOBILE",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xffc40305)))
    ])),
    centerTitle: true,
  );
}

Route createRoute(page) {
  return PageRouteBuilder(
    // transitionDuration: const Duration(milliseconds: 800),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
