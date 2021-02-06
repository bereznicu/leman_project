import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/Entities/employee_entity.dart';
import 'package:leman_project/Entities/ticket_entity.dart';
import 'package:leman_project/Services/employees_service.dart';
import 'package:leman_project/View_Providers/employee_view_provider.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class EmployeeViewBody extends StatefulWidget {
  const EmployeeViewBody({Key key, @required this.employee}) : super(key: key);
  final EmployeeEntity employee;
  @override
  _EmployeeViewBodyState createState() => _EmployeeViewBodyState();
}

class _EmployeeViewBodyState extends State<EmployeeViewBody> {
  var employeesService;
  var employeeProvider;
  @override
  void initState() {
    employeeProvider = context.read<EmployeeViewProvider>();
    employeesService = context.read<EmployeesService>();
    employeesService.ticketsStreamListen(widget.employee, employeeProvider);
    super.initState();
  }

  @override
  void dispose() {
    employeesService.cancelStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Date selector
          Container(
            color: Colors.cyan[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                  ),
                  label: Text(""),
                  onPressed: () {
                    employeeProvider.previousMonth();
                    employeesService.ticketsStreamListen(
                        widget.employee, employeeProvider);
                  },
                ),
                InkWell(
                  child: Selector<EmployeeViewProvider, String>(
                    selector: (_, employeeProvider) => employeeProvider.date,
                    builder: (_, date, child) {
                      return Text(
                        employeeProvider.date,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: orientation(context) == 'portrait'
                                ? height(context) * 0.02
                                : height(context) * 0.04),
                      );
                    },
                  ),
                  onTap: () async {
                    showMonthPicker(
                      context: context,
                      initialDate: employeeProvider.selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    ).then((value) {
                      if (value != null) {
                        employeeProvider.updateDate(value);
                        employeesService.ticketsStreamListen(
                            widget.employee, employeeProvider);
                      }
                    });
                  },
                ),
                FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                  ),
                  label: Text(""),
                  onPressed: () {
                    employeeProvider.nextMonth();
                    employeesService.ticketsStreamListen(
                        widget.employee, employeeProvider);
                  },
                ),
              ],
            ),
          ),
          // spacer(height(context) * 0.05, 0),
          Container(
            height: orientation(context) == 'portrait'
                ? height(context) * 0.6
                : height(context) * 0.8,
            child: Selector<EmployeeViewProvider, List<TicketEntity>>(
              selector: (_, employeeProvider) => employeeProvider.tickets,
              builder: (_, ticketsList, child) {
                if (ticketsList.isEmpty)
                  return Center(
                    child: Text("Niciun tichet de afișat"),
                  );
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: ticketsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: orientation(context) == 'portrait'
                            ? width(context) * 0.8
                            : width(context) * 0.4,
                        child: Card(
                          color: Colors.grey[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          shadowColor: Colors.white,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${ticketsList[index].category}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "${ticketsList[index].details}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 15.0),
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                    children: <TextSpan>[
                                      TextSpan(text: "Creat de "),
                                      TextSpan(
                                          text: "${ticketsList[index].creator}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: " în "),
                                      TextSpan(
                                          text: ticketsList[index]
                                              .date
                                              .toString()
                                              .split(' ')[0],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
