import 'package:flutter/material.dart';
import 'package:leman_project/Common/common_widgets.dart';
import 'package:leman_project/Common/constants.dart';
import 'package:leman_project/View_Providers/home_view_provider.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key key, @required this.homeProvider})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(
          key: key,
        );
  @override
  final Size preferredSize;
  final homeProvider;

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  var homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = widget.homeProvider;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: PopupMenuButton<String>(
        color: Colors.grey[100],
        icon: Icon(Icons.settings),
        onSelected: (String choice) {
          homeProvider.settingsMenuActions(choice);
        },
        itemBuilder: (BuildContext context) {
          return Constants.settingsMenuChoices.map((choice) {
            return PopupMenuItem<String>(
              child: ListTile(
                title: Text(choice),
                trailing: Icon(Icons.logout, color: Colors.black),
              ),
              value: choice,
            );
          }).toList();
        },
      ),
      centerTitle: true,
      //SEARCH BAR
      title: Selector<HomeViewProvider, bool>(
        selector: (context, employeesService) => employeesService.focus,
        builder: (context, focus, child) {
          return Container(
            height: orientation(context) == 'portrait'
                ? height(context) * 0.04
                : height(context) * 0.08,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: TextFormField(
              onChanged: (value) {
                homeProvider.searchedString(value);
              },
              onTap: () {
                if (focus != true)
                  homeProvider.changeSearchBarFocus(true, context);
              },
              keyboardType: TextInputType.name,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white)),
                hintText: "Caută după nume",
                prefixIcon: homeProvider.focus
                    ? GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          homeProvider.changeSearchBarFocus(false, context);
                        },
                      )
                    : Container(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          );
        },
      ),
      //SORT MENU
      actions: <Widget>[
        Selector<HomeViewProvider, String>(
          selector: (context, employeesService) =>
              employeesService.selectedSort,
          builder: (context, selectedSort, child) {
            return PopupMenuButton<String>(
              color: Colors.grey[100],
              icon: Icon(Icons.menu),
              onSelected: (String choice) {
                homeProvider.sortList(choice);
              },
              itemBuilder: (BuildContext context) {
                return Constants.sortMenuChoices.map((String choice) {
                  return PopupMenuItem<String>(
                    enabled: selectedSort == choice ? false : true,
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              },
            );
          },
        )
      ],
    );
  }
}
