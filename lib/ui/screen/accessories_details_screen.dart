// import 'package:flutter/material.dart';

// class AccessoriesDetailsScreen extends StatelessWidget {
//   const AccessoriesDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 3,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.favorite_border,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Material(
//                 child: Image.asset("assets/images/plate.png"),
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               Text(
//                   "Furever Friends Stainless Steel  Pet feeding Bowl 700ml Anti Skid pet feeder (700ML) Stainless Steel Pet Bowl(700 ml Silver)",
//                   style: Theme.of(context).textTheme.titleLarge),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     Icons.star_border,
//                     color: Colors.green,
//                   ),
//                   SizedBox(
//                     width: 1,
//                   ),
//                   Icon(Icons.star_border, color: Colors.green),
//                   SizedBox(
//                     width: 1,
//                   ),
//                   Icon(Icons.star_border, color: Colors.green),
//                   SizedBox(
//                     width: 1,
//                   ),
//                   Icon(Icons.star_border, color: Colors.green),
//                   SizedBox(
//                     width: 1,
//                   ),
//                   Icon(Icons.star_border, color: Colors.green),
//                   SizedBox(
//                     width: 1,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Special Price ",
//                 textAlign: TextAlign.start,
//                 style: TextStyle(color: Colors.green, fontSize: 30),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               RichText(
//                 text: TextSpan(
//                   text: '70% off ',
//                   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                         color: Colors.green,
//                       ),
//                   children: [
//                     TextSpan(
//                       text: '599 ',
//                       style:
//                           Theme.of(context).textTheme.headlineSmall!.copyWith(
//                                 color: Colors.grey,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                     ),
//                     TextSpan(
//                       text: ' ₹177',
//                       style:
//                           Theme.of(context).textTheme.headlineSmall!.copyWith(
//                                 color: Colors.black,
//                               ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Text(
//               //   "70% off 599 ₹177",
//               //   textAlign: TextAlign.start,
//               //   style: TextStyle(color: Colors.green, fontSize: 30),
//               // ),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 "Buy Now and Pay Later with EMI Activate Now",
//                 textAlign: TextAlign.start,
//                 style: TextStyle(color: Colors.black, fontSize: 18),
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Text(
//                 "All offers & Coupons",
//                 textAlign: TextAlign.start,
//                 style: TextStyle(color: Colors.black, fontSize: 18),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.auto_graph_outlined, color: Colors.black),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     "88 people  ordered this in the last 15 days",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(color: Colors.black, fontSize: 18),
//                   ),
//                 ],
//               ),

//               const SizedBox(
//                 height: 5,
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.only(left: 15, right: 15),
//               //   child: CustomButton(
//               //     text: 'View Similer',
//               //     onTap: () {},
//               //     buttonColor: Colors.white,
//               //     labelColor: Colors.black,
//               //     elevation: 0,
//               //   ),
//               // ),
//               const SizedBox(
//                 height: 10,
//               ),
//               // Row(
//               //   children: [
//               //     Expanded(
//               //       child: CustomButton(
//               //         text: 'Add to cart',
//               //         onTap: () {},
//               //       ),
//               //     ),
//               //     const SizedBox(
//               //       width: 10,
//               //     ),
//               //     Expanded(
//               //       child: CustomButton(
//               //         text: 'Buy now',
//               //         onTap: () {},
//               //       ),
//               //     )
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
