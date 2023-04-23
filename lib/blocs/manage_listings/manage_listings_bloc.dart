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
      SupabaseQueryBuilder imageTable =
          supabaseClient.from('pet_listing_images');
      try {
        if (event is GetAllListingsEvent) {
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
          String path = await supabaseClient.storage.from('docs').uploadBinary(
                'listings/${DateTime.now().millisecondsSinceEpoch.toString()}${event.image.name}',
                event.image.bytes!,
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
