import 'package:flutter/material.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/View_Providers/home_view_provider.dart';
import 'package:leman_project/Views/single_employee_view.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeBody extends StatefulWidget {
  final employeesService;
  final homeProvider;
  HomeBody(
      {Key key, @required this.employeesService, @required this.homeProvider})
      : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    print("BODY INIT STATE");
    widget.employeesService.retrieveEmployees(widget.homeProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        spacer(
            orientation(context) == 'portrait'
                ? height(context) * 0.02
                : height(context) * 0.04,
            0),
        Selector<HomeViewProvider, Tuple2<List<String>, String>>(
            selector: (_, homeProvider) => Tuple2(homeProvider.filteredList, homeProvider.selectedSort),
            builder: (_, data, child) {
              print("REBUILD LIST");
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                        // thickness: 1.0,
                        );
                  },
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: data.item1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeView(
                                employee: data.item1[index],
                              ),
                            ));
                      },
                      onLongPress: () {},
                      title: Text(data.item1[index]),
                      trailing: Icon(Icons.arrow_forward),
                    );
                  },
                ),
              );
            }),
      ],
    );
  }
}
