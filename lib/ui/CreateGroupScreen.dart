import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myturn/injection/GroupModule.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/bloc/group/group_bloc.dart';
import 'package:myturn/core/theme/AppTheme.dart';
import 'package:myturn/models/group.dart';
import 'package:myturn/repo/FirebaseGroupRepo.dart';

class CreateGroupScreen extends StatefulWidget {
  CreateGroupScreen() : super();

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final MainModule mainModule = MainModule();
  // need to change the GroupBloc instantiation in GroupModule to inject FirebaseRepo object
  //final GroupBloc _groupBloc = GroupModule().get<GroupBloc>(additionalParameters: {'groupRepo': FirebaseGroupRepo()});
  final GroupBloc _groupBloc = GroupModule().get<GroupBloc>();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, Object> _groupValues = Map();

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      currentTheme: this.mainModule.get<ContemporaryTheme>(),
      child: Builder(
        builder: (context) => Container(
            color: Theme.of(context).backgroundColor,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(8, 35, 8, 10), //provide extra padding on all 4 sides
              child: _screen(context),
            )),
      ),
    );
  } //build

  Widget _screen(BuildContext context) {
    ///to set common media query attributes in current theme
    ThemeProvider.of(context).currentTheme.mediaQueryData(MediaQuery.of(context));
    return BlocBuilder(
        bloc: _groupBloc,
        builder: (BuildContext context, GroupState state) {
          Scaffold _scaffold = Scaffold(
            appBar: AppBar(),
            body: _body(context),
            bottomNavigationBar: _bottomNav(context),
          );
          return _scaffold;
        });
  } //_screen

  /// build body
  Widget _body(BuildContext context) {
    return _formFields();
  }

  /// ***** start: bottom navbar *****
  BottomAppBar _bottomNav(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: ThemeProvider.of(context).currentTheme.bottomBarBorder()))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              tooltip: "Search",
              onPressed: () => _onSave(),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => debugPrint("on schedule"),
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => debugPrint("on schedule"),
            )
          ],
        ),
      ),
    );
  }

  /// This method is called on click of Save icon.
  /// The values from the form fields are saved to the corresponding global variables so that we can use them to set to the Group object.
  /// The Group object is then posted to GroupBloc to add the same to Firestore database.
  void _onSave() {
    if (_formKey.currentState.validate()) {
      // Save the values from the textfield to the corresponding global variables
      _formKey.currentState.save();

      this._groupBloc.add(GroupModule().get<AddGroup>(additionalParameters: {
            'group': this._createGroupObj(),
          }));
    }
  }

  /// This method constructors the form with textfields
  Widget _formFields() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter group name!';
                }
                return null;
              },
              onSaved: (value) => _groupValues['group_name'] = value,
              decoration: InputDecoration(labelText: "Group Name"),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Address"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter address!';
                }
                return null;
              },
              onSaved: (value) => _groupValues['address'] = value,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Phone #"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter phone number!';
                }
                return null;
              },
              onSaved: (value) => _groupValues['phone_num'] = value,
            ),
          ],
        ),
      ),
    );
  } // end of _formFields

  /// This method gets the values from the global form variables and returns a Group object
  Group _createGroupObj() {
    return Group(groupName: _groupValues['group_name'], address: _groupValues['address'], adminId: "Admin", groupId: 'gid', phoneNum: _groupValues['phone_num']);
  }
} // End of CreateGroupScreen
