import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/core/routes_enum.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat_firestore_repository.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

final chatControllerProvider = Provider((ref) {
  return ChatController(ref);
});

class ChatController {
  Ref _ref;
  ChatController(this._ref);
  void insert(ChatInsertReqDto dto) {
    // try-catch로 잡는 케이스도 있다. 연습해보자
    Future<DocumentReference> futureDoc = _ref.read(chatFirestoreRepositoryProvider).insert(dto);

    futureDoc.then((value) {
      print("디버그 : ${value.id}");
      // 여기서는 화면 이동
      // Navigator.pushNamed(context, Routes.login.path);
      // Navigator.popAndPushNamed(context, Routes.login.path);
      // Navigator.pop(context);
      // Navigator.pushNamedAndRemoveUntil(context, Routes.login.path, (route) => false);
    }).onError((error, stackTrace) {
      // 여기서는 경고창(에러메시지)
      print("error : ${error}");
    });
  }
}
