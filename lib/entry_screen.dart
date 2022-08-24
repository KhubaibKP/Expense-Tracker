import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:task_expense/home_screen.dart';
import 'package:task_expense/numbers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();
  final double buttonSize = 30;
  TextEditingController titleInput = TextEditingController();
  TextEditingController descInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController amountInput = TextEditingController();

  String dropdownvalue = 'Expense';

  var itemslist = [
    'Expense',
    'Income',
  ];

  void addEntry() {
    if (timeInput.text.isEmpty ||
        descInput.text.isEmpty ||
        dateInput.text.isEmpty ||
        timeInput.text.isEmpty ||
        amountInput.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "All fields should be filled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    } else {

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(
                      title: titleInput.text,
                      description: descInput.text,
                      date: dateInput.text,
                      time: timeInput.text,
                      amount: amountInput.text,
                      expense: dropdownvalue
                  )),
              (route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          color: Colors.grey.shade300,
          child: Column(
            children: [
              SizedBox(height: 25.0),
              TextField(
                controller: titleInput,
                keyboardType: TextInputType.text,
                maxLength: 30,
                decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide:
                      BorderSide(width: 5, color: Colors.black)),
                  counterText: '',
                  fillColor: Colors.white, filled: true,
                ),
              ),
              SizedBox(height: 12.0,),
              TextField(
                controller: descInput,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 100,
                decoration: const InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide:
                      BorderSide(width: 1, color: Colors.blueAccent)),
                  counterText: '',
                  fillColor: Colors.white, filled: true,
                ),
              ),
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                    selectDate(context);
                  },
                      icon: const Icon(
                    Icons.calendar_month,
                  ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    child: TextField(
                      controller: dateInput,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      decoration: const InputDecoration(
                        hintText: "Date",
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.blueAccent)),
                        counterText: '',
                        fillColor: Colors.white, filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      selectTime(context);
                    },
                    icon: Icon(
                      Icons.timer,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Expanded(
                    child: TextField(
                      controller: timeInput,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: "Time",
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.blueAccent)),
                        counterText: '',
                        fillColor: Colors.white, filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              DropdownButton(

                value: dropdownvalue,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                iconEnabledColor: Colors.green,
                iconSize: 35.0,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),

                // Array list of items
                items: itemslist.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
              SizedBox(height: 12.0,),
              TextField(
                controller: amountInput,
                keyboardType: TextInputType.none,
                maxLength: 30,
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide:
                      BorderSide(width: 5, color: Colors.black)),
                  counterText: '',
                  fillColor: Colors.white, filled: true,
                ),
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: NumberButton(
                        number: 1,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: NumberButton(
                        number: 2,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: NumberButton(
                        number: 3,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: NumberButton(
                        number: 4,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: NumberButton(
                        number: 5,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: NumberButton(
                        number: 6,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: NumberButton(
                        number: 7,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: NumberButton(
                        number: 8,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: NumberButton(
                        number: 9,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: NumberButton(
                        number: 0,
                        size: buttonSize,
                        color: Colors.white,
                        textController: amountInput,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          try {
                            amountInput.text = amountInput.text
                                .substring(0, amountInput.text.length - 1);
                          } on RangeError catch (e) {
                            print(e);
                          }
                        },
                        child:
                        Text('Delete', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            elevation: MaterialStateProperty.all(10.0),
                            backgroundColor:
                            MaterialStateProperty.all(Colors.red)),
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 80.0),


            ],

          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addEntry,
        child: const Icon(Icons.check),
      ),

    );
  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2023));

    if (pickedDate != null)
      {
        String dateformat = DateFormat('dd MMMM, yyyy').format(pickedDate);
        print(dateformat);

        setState(() {
          dateInput.text = dateformat;
        });
      }
    else{
      print('Please select a date');
    }

  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        selectedTime = timeOfDay;
        if (selectedTime.hour > 12) {
          if (selectedTime.minute < 10) {
            timeInput.text =
            "${selectedTime.hour % 12}:0${selectedTime.minute} PM";
          } else {
            timeInput.text =
            "${selectedTime.hour % 12}:${selectedTime.minute} PM";
          }
        } else {
          if (selectedTime.minute < 10) {
            timeInput.text = "${selectedTime.hour}:0${selectedTime.minute} AM";
          } else {
            timeInput.text = "${selectedTime.hour}:${selectedTime.minute} AM";
          }
        }
      });
    }
  }



}
