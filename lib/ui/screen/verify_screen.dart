// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:pets/ui/widget/custom_button.dart';

// class Verify extends StatelessWidget {
//   const Verify({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 330,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   'Verify',
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Text(
//                   'Enter code sent to your mobile number',
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomTextField(),
//                   CustomTextField(),
//                   CustomTextField(),
//                   CustomTextField(),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: CustomButton(
//                   text: "Verify",
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (_) => Dialog(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 25, vertical: 15),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 'Account created',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineSmall!
//                                     .copyWith(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Center(
//                                 child: Text(
//                                   'Your account has been successfully created!',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .labelLarge!
//                                       .copyWith(
//                                         color: Colors.black,
//                                       ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               CustomButton(
//                                 text: 'Ok',
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   'Didn"t receive code? Resend ',
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//               ),
//             ]),
//       ),
//     );
//   }
// }

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 60,
//       height: 70,
//       child: TextFormField(
//         decoration: InputDecoration(
//             filled: true,
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5.0),
//                 borderSide: const BorderSide())),
//       ),
//     );
//   }
// }
