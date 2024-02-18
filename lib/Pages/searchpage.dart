// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconly/iconly.dart';
// import 'package:tickodo/Widgets/searched.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController searchController = TextEditingController();
//   FocusNode focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     FocusScope.of(context).requestFocus(focusNode);
//   }

//   @override
//   void dispose() {
//     searchController.dispose(); // Dispose the controller
//     focusNode.dispose(); // Dispose the focus node
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Searched(),
//           Searched(),
//           Searched(),
//         ],
//       );
//   }
// }
