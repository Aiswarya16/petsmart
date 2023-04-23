import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'manage_listings_event.dart';
part 'manage_listings_state.dart';

class ManageListingsBloc
    extends Bloc<ManageListingsEvent, ManageListingsState> {
  ManageListingsBloc() : super(ManageListingsInitialState()) {
    on<ManageListingsEvent>((event, emit) async {
      emit(ManageListingsLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('pet_listings');
      SupabaseQueryBuilder categoryTable =
          supabaseClient.from('pet_categories');
      SupabaseQueryBuilder favoritesTable = supabaseClient.from('favorites');
      SupabaseQueryBuilder profileTable = supabaseClient.from('profiles');
      SupabaseQueryBuilder imageTable =
          supabaseClient.from('pet_listing_images');
      try {
        if (event is GetOthersListingsEvent) {
          List<dynamic> temp = [];

          if (event.query != null && event.categoryId != null) {
            temp = await queryTable
                .select('*')
                .neq('by_user_id', supabaseClient.auth.currentUser!.id)
                .ilike('title', '%${event.query}%')
                .eq('category_id', event.categoryId)
                .eq('status', 'pending')
                .order('title', ascending: true);
          } else if (event.query != null) {
            temp = await queryTable
                .select('*')
                .neq('by_user_id', supabaseClient.auth.currentUser!.id)
                .ilike('title', '%${event.query}%')
                .eq('status', 'pending')
                .order('title', ascending: true);
          } else if (event.categoryId != null) {
            temp = await queryTable
                .select('*')
                .neq('by_user_id', supabaseClient.auth.currentUser!.id)
                .eq('category_id', event.categoryId)
                .eq('status', 'pending')
                .order('title', ascending: true);
          } else {
            temp = await queryTable
                .select('*')
                .neq('by_user_id', supabaseClient.auth.currentUser!.id)
                .eq('status', 'pending')
                .order('title', ascending: true);
          }

          List<Map<String, dynamic>> listings =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < listings.length; i++) {
            listings[i]['images'] = await imageTable
                .select('*')
                .eq('pet_listing_id', listings[i]['id']);

            listings[i]['category'] = await categoryTable
                .select('*')
                .eq('id', listings[i]['category_id'])
                .single();
            listings[i]['profile'] = await profileTable
                .select('*')
                .eq('user_id', listings[i]['by_user_id'])
                .single();

            listings[i]['favorite'] = (await favoritesTable
                    .select('*')
                    .eq('user_id', supabaseClient.auth.currentUser!.id)
                    .eq('pet_listing_id', listings[i]['id'])
                    .maybeSingle() !=
                null);
          }
          Logger().w(listings);
          emit(
            OthersListingsSuccessState(
              listings: listings,
            ),
          );
        }
        if (event is GetMyOrderListingsEvent) {
          List<dynamic> temp = [];

          temp = await queryTable
              .select('*')
              .eq('bought_by', supabaseClient.auth.currentUser!.id)
              .eq('status', event.status)
              .order('bought_at', ascending: false);

          List<Map<String, dynamic>> listings =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < listings.length; i++) {
            listings[i]['images'] = await imageTable
                .select('*')
                .eq('pet_listing_id', listings[i]['id']);

            listings[i]['category'] = await categoryTable
                .select('*')
                .eq('id', listings[i]['category_id'])
                .single();
            listings[i]['profile'] = await profileTable
                .select('*')
                .eq('user_id', listings[i]['by_user_id'])
                .single();

            listings[i]['favorite'] = (await favoritesTable
                    .select('*')
                    .eq('user_id', supabaseClient.auth.currentUser!.id)
                    .eq('pet_listing_id', listings[i]['id'])
                    .maybeSingle() !=
                null);
          }
          Logger().w(listings);
          emit(
            MyOrdersListingsSuccessState(
              listings: listings,
            ),
          );
        } else if (event is CollectMyOrderListingsEvent) {
          await queryTable.update(
            {
              'status': 'complete',
            },
          ).eq('id', event.listingId);

          add(GetMyOrderListingsEvent(status: 'orderd'));
        } else if (event is FavoriteListingsEvent) {
          if (event.favorite) {
            await favoritesTable.upsert(
              {
                'pet_listing_id': event.listingId,
                'user_id': supabaseClient.auth.currentUser!.id,
              },
            );
          } else {
            await favoritesTable
                .delete()
                .eq('pet_listing_id', event.listingId)
                .eq('user_id', supabaseClient.auth.currentUser!.id);
          }

          add(GetOthersListingsEvent());
        } else if (event is OrderListingsEvent) {
          await queryTable.update(
            {
              'bought_at': DateTime.now().toIso8601String(),
              'bought_by': supabaseClient.auth.currentUser!.id,
              'status': 'ordered',
            },
          ).eq('id', event.listingId);

          add(GetOthersListingsEvent());
        } else if (event is GetAllListingsEvent) {
          List<dynamic> temp = [];

          if (event.query != null) {
            temp = await queryTable
                .select('*')
                .eq('by_user_id', supabaseClient.auth.currentUser!.id)
                .ilike('title', '%${event.query}%')
                .order('title', ascending: true);
          } else {
            temp = await queryTable
                .select('*')
                .eq('by_user_id', supabaseClient.auth.currentUser!.id)
                .order('title', ascending: true);
          }

          List<Map<String, dynamic>> listings =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < listings.length; i++) {
            listings[i]['images'] = await imageTable
                .select('*')
                .eq('pet_listing_id', listings[i]['id']);
          }
          emit(
            ManageListingsSuccessState(
              listings: listings,
            ),
          );
        } else if (event is AddListingsEvent) {
          String path = await supabaseClient.storage.from('docs').upload(
                'listings/${DateTime.now().millisecondsSinceEpoch.toString()}${event.image.name}',
                File(event.image.path!),
              );

          path = path.replaceRange(0, 5, '');

          Map<String, dynamic> listing = await queryTable
              .insert(
                {
                  'title': event.title,
                  'description': event.description,
                  'price': event.price,
                  'age': event.age,
                  'gender': event.gender,
                  'discounted_price': event.discountedPrice,
                  'phone': event.phone,
                  'address_line': event.address,
                  'place': event.place,
                  'district': event.district,
                  'state': event.state,
                  'pin_code': event.pin,
                  'category_id': event.categoryId,
                  'by_user_id': supabaseClient.auth.currentUser!.id,
                },
              )
              .select()
              .single();

          await imageTable.insert({
            'pet_listing_id': listing['id'],
            'image_url': supabaseClient.storage.from('docs').getPublicUrl(path),
          });

          add(GetAllListingsEvent());
        } else if (event is EditListingsEvent) {
          await queryTable.update(
            {
              'title': event.title,
              'description': event.description,
              'price': event.price,
              'age': event.age,
              'gender': event.gender,
              'discounted_price': event.discountedPrice,
              'phone': event.phone,
              'address_line': event.address,
              'place': event.place,
              'district': event.district,
              'state': event.state,
              'pin_code': event.pin,
            },
          ).eq('id', event.listingId);

          add(GetAllListingsEvent());
        } else if (event is UploadImageListingsEvent) {
          String path = await supabaseClient.storage.from('docs').upload(
                'listings/${DateTime.now().millisecondsSinceEpoch.toString()}${event.image.name}',
                File(event.image.path!),
              );

          path = path.replaceRange(0, 5, '');

          await imageTable.insert({
            'pet_listing_id': event.listingId,
            'image_url': supabaseClient.storage.from('docs').getPublicUrl(path),
          });

          add(GetAllListingsEvent());
        } else if (event is DeleteListingsEvent) {
          await queryTable.delete().eq('id', event.listingId);
          add(GetAllListingsEvent());
        } else if (event is DeleteImageListingsEvent) {
          await imageTable.delete().eq('id', event.imageId);
          add(GetAllListingsEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ManageListingsFailureState());
      }
    });
  }
}
