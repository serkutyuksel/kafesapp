import 'package:flutter/material.dart';
import 'package:kafes_app/Screens/filter_page.dart';

class CategoryOptions extends StatefulWidget {
  CategoryOptions({this.uid});
  final uid;
  @override
  _CategoryOptionsState createState() => _CategoryOptionsState();
}

class _CategoryOptionsState extends State<CategoryOptions> {
  var _department = "Food Engineering";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children:[ DropdownButton<String>(
            hint: Text("Choose your department(optional)"),
            isExpanded: true,
            value: _department,
            elevation: 8,
            style: TextStyle(color: Colors.redAccent),
            underline: Container(
              height: 1,
              color: Colors.grey,
            ),
            onChanged: (String newValue) {
              setState(() {
                _department = newValue;
              });
            },
            items: [
              "Computer Engineering",
              "Software Engineering",
              "Aerospace Engineering",
              "Biomedical Engineering",
              "Civil Engineering",
              "Electrical and Electronics Engineering",
              "Food Engineering",
              "Genetics and Bioengineering",
              "Industrial Engineering",
              "Mechanical Engineering",
              "Mechatronics Engineering",
              "Mathematics",
              "Physics",
              "English Translation and Interpreting",
              "Psychology",
              "Sociology",
              "Architecture",
              "Industrial Design",
              "Interior Architecture and Environmental Design",
              "Textile and Fashion Design",
              "Visual Communication Design",
              "Law",
              "Cinema and Digital Media",
              "New Media and Communication",
              "Public Relations and Advertising",
              "Accounting and Auditing Program",
              "Business Administration",
              "Economics",
              "International Trade and Finance",
              "Logistics Management",
              "Health Management",
              "Nursing",
              "Medicine",
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()),
          MaterialButton(
            child: Text("Filter with selected Department", style: TextStyle(color: Colors.redAccent),),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FilterPage(filter: _department))),
            },
          ),
          ],
      ),
    );
  }
}
