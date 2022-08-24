import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_expense/entry_screen.dart';
import 'dart:ui';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:task_expense/constants.dart' as constants;

class MyHomePage extends StatefulWidget {
  String title, description, date, time, amount, expense;

   MyHomePage({Key? key,
    this.title = '',
    this.description = '',
    this.date = '',
    this.time = '',
    this.amount = '',
    this.expense = ''}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  List<Color> colorList = [
    const Color(0xffFF0000),
    const Color(0xff008631),
    const Color(0xffC1C1C1),

  ];


  @override
  void initState() {
    super.initState();

    if (widget.title.isNotEmpty) {
      constants.data.add({
        'title': widget.title,
        'description': widget.description,
        'date': widget.date,
        'time': widget.time,
        'amount': widget.amount,
        'expense': widget.expense,
        'count': ++constants.count
      });
    }

    setState(() {
      if (widget.expense == 'Expense') {
        constants.dataMap['Expense'] = constants.expense++;
      } else if (widget.expense == 'Income') {
        constants.dataMap['Income'] = constants.income++;
      }

      if (constants.expense != 1) {
        constants.dataMap['Saving'] = constants.income - constants.expense;
      }
    });

    constants.data.sort(
            (a, b) => b["count"].compareTo(a["count"])); // Sort by Latest Entry
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [

          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    child: Text('+ Add', style: TextStyle(fontSize: 20.0),),
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                        const EntryScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: PieChart(
              dataMap: constants.dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 60,
              chartRadius: MediaQuery
                  .of(context)
                  .size
                  .width / 2.8,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 12,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: false,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
              ),
            ),
          ),

          Expanded(
            flex: 7,
            child: constants.data.isNotEmpty
                ? Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: constants.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(15.0),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2, 2),
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius:
                      BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Icon(
                              constants.data[i]['expense'] == 'Expense'
                                  ? Icons.arrow_back
                                  : Icons.arrow_forward,
                              color:
                              constants.data[i]['expense'] == 'Expense'
                                  ? Colors.red
                                  : Colors.green,
                              size: 28.0)),
                      trailing: Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          numberFormat
                              .format(int.parse(constants.data[i]['amount']))
                              .toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(constants.data[i]['title'],
                          style:
                          TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.0),
                          Text(
                            constants.data[i]['description'],
                            maxLines: 2,
                          ),
                          SizedBox(height: 7.0),
                          Text(
                            '${constants.data[i]['date']} at ${constants
                                .data[i]['time']}',
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
                : Center(
              child: Text('Your expense is null',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


