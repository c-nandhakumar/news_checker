import 'package:flutter/material.dart';
import 'package:news_checker/screens/home_screen.dart';
import 'package:news_checker/screens/web_view_screen.dart';
// import 'package:news_checker/models/fact_model.dart';
// import 'package:news_checker/widgets/table_widget.dart';
import 'package:news_checker/widgets/textfield_widget.dart';

class ResultScreen extends StatefulWidget {
  final String queryText;
  final Map<String, dynamic> body;
  const ResultScreen({required this.queryText, required this.body, super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  TextEditingController queryController = TextEditingController();
  // FactModel? factModel;

  @override
  void initState() {
    super.initState();
    queryController.text = widget.queryText;
    // factModel = factModelFromJson(dummyData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, leading: true),
      body: SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            children: [
              TextFieldWidget(
                  enableBackButton: true,
                  title: "Your Query",
                  controller: queryController,
                  readOnly: true),
              const SizedBox(
                height: 16,
              ),
              widget.body['validation'] == ""
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Summary :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.body["validation"] == true
                              ? "\" The fact is true \""
                              : "\" The fact is wrong \"",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: widget.body["validation"] == true
                                  ? Colors.green.shade800
                                  : Colors.red.shade600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),

              widget.body['justification'] == ""
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Justification :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "${widget.body["justification"]}",
                          style: const TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),

              widget.body['validation'] == ""
                  ? Container()
                  : const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "More Information :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),

              Text(
                "${widget.body["answer"]}",
                style: const TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),

              widget.body["link"] != ""
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).push(createRoute(
                            WebViewScreen(widget.body['link'], "Source")));
                      },
                      child: Text(
                        "${widget.body["link"]}",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    )
                  : Container(),

              const SizedBox(height: 12),
              // factModel!.facts!.isNotEmpty
              //     ? TableWidget(data: factModel!.facts!)
              //     : Container()
            ]),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 12.0, right: 12, bottom: 16, top: 6),
        child: FilledButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: const Text('Back To Query',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ),
      ),
    );
  }
}
