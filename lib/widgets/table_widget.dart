import 'package:flutter/material.dart';
import 'package:news_checker/models/fact_model.dart';

class TableWidget extends StatelessWidget {
  final List<Fact> data;
  const TableWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade500),
        columnWidths: const <int, TableColumnWidth>{
          1: FractionColumnWidth(.25),
          2: FixedColumnWidth(64),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Container(
                  height: 36,
                  alignment: Alignment.center,
                  child: Text(
                    "Fact",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
              ),
              Container(
                height: 36,
                alignment: Alignment.center,
                child: Text(
                  "Source",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          ...data.map((item) => TableRow(children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      item.fact.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      item.source.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                )
              ]))
        ]);
  }
}
