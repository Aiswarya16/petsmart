import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:pets/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:pets/ui/widget/custom_action_button.dart';
import 'package:pets/ui/widget/custom_icon_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/custom_alert_dialog.dart';

class PetDetailsScreen extends StatefulWidget {
  final ManageListingsBloc manageListingsBloc;
  final dynamic listDetails;
  const PetDetailsScreen({
    super.key,
    required this.manageListingsBloc,
    required this.listDetails,
  });

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    isFavorite = widget.listDetails['favorite'];
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  final Razorpay _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await showDialog(
      context: context,
      builder: (context) => const CustomAlertDialog(
        title: 'Payment Success',
        message:
            'Thank you for the payment, you can find your order in the orders section.',
        primaryButtonLabel: 'Ok',
      ),
    );

    widget.manageListingsBloc.add(
      OrderListingsEvent(
        listingId: widget.listDetails['id'],
      ),
    );

    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Logger().e(response.error);
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Payment Failed',
        message: response.message ?? 'Something went wrong, Please try again',
        primaryButtonLabel: 'Ok',
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  void makePayment() async {
    // String orderId = await createOrder(widget.testDetails['total_price']);

    var options = {
      'key': 'rzp_test_j07YpjyCexi5xr',
      'amount': (widget.listDetails['discounted_price']) * 100,
      'name': 'PetsMart',
      // 'order_id': orderId,
      'description': '#${widget.listDetails['title']}',
      'prefill': {
        'contact': '9999999999',
        'email': Supabase.instance.client.auth.currentUser!.email,
      }
    };
    Logger().w(options);
    _razorpay.open(options);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.pink,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isFavorite = !isFavorite;
              widget.manageListingsBloc.add(
                FavoriteListingsEvent(
                  listingId: widget.listDetails['id'],
                  favorite: isFavorite,
                ),
              );
              setState(() {});
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            FlutterCarousel.builder(
              itemCount: widget.listDetails['images'].length,
              itemBuilder: (context, itemIndex, pageViewIndex) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.listDetails['images'][itemIndex]
                      ['image_url'],
                  width: MediaQuery.of(context).size.width - 60,
                ),
              ),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width - 60,
                enlargeCenterPage: true,
                showIndicator: true,
                slideIndicator: const CircularSlideIndicator(
                  currentIndicatorColor: Colors.pink,
                  indicatorBackgroundColor: Colors.white70,
                  indicatorRadius: 4,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.listDetails['category']['category'],
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.listDetails['title'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    widget.listDetails['gender'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[800],
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '₹${widget.listDetails['price'].toString()}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.red[800],
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    '₹${widget.listDetails['discounted_price']}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.listDetails['description'],
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.black54,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Posted by',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(
                            widget.listDetails['profile']['name'],
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Posted on',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy hh:mm a').format(
                                DateTime.parse(
                                    widget.listDetails['created_at'])),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.listDetails['address_line']}, ${widget.listDetails['place']}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    widget.listDetails['district'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    widget.listDetails['state'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    'Pin ${widget.listDetails['pin_code']}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.black54,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomIconButton(
                          iconData: Icons.call_rounded,
                          onPressed: () async {
                            Uri uri =
                                Uri.parse('tel:${widget.listDetails['phone']}');
                            await launchUrl(
                              uri,
                            );
                          },
                          color: Colors.green[600]!,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (widget.listDetails['bought_by'] == null)
                        Expanded(
                          flex: 3,
                          child: CustomActionButton(
                            iconData: Icons.pets_outlined,
                            onPressed: () {
                              makePayment();
                            },
                            label: 'Adopt',
                          ),
                        ),
                      if (widget.listDetails['bought_by'] != null &&
                          widget.listDetails['status'] != 'complete')
                        Expanded(
                          flex: 3,
                          child: CustomActionButton(
                            iconData: Icons.done,
                            onPressed: () {
                              widget.manageListingsBloc.add(
                                CollectMyOrderListingsEvent(
                                    listingId: widget.listDetails['id']),
                              );
                              Navigator.pop(context);
                            },
                            label: 'Collected',
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
