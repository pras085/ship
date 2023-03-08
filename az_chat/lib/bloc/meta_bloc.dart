import 'package:azlogistik_chat/models/link_metadata.dart';
import 'package:azlogistik_chat/services/chat_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metadata_fetch/metadata_fetch.dart';

part 'meta_state.dart';

class MetaCubit extends Cubit<MetaState> {

  static MetaCubit? instance;
  
  MetaCubit() : super(MetaLoadFailed());

  static MetaCubit newInstance(String? preText){
    MetaCubit.instance = MetaCubit();
    if(preText != null){
      MetaCubit.instance!.fetchMeta(preText);
    }
    return MetaCubit.instance!;
  }

  Future<void> fetchMeta(String message) async {
    emit(MetaLoadProgress());
    bool success = false;
    if(MetaCubit.instance != null && message != ''){
      var meta = await ChatRequest.getUrlMeta(message);
      if(meta != null){
        // debugPrint('META FOUND');
        if(meta.HasURL && MetaCubit.instance != null){
          // debugPrint('META HAS URL AND Cubit NOT NULL');
          emit(MetaLoadSuccess(meta));
          success = true;
        }
      }
    }
    if(MetaCubit.instance != null && !success){
      emit(MetaLoadFailed());
    }
  }
}