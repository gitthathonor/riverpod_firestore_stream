// provider
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

// 리턴 : Stream<List<Chat>>
// 마지막 데이터(tail)만 받을거면 yield를 사용한다.
final chatStreamProvider = StreamProvider<List<Chat>>((ref) {
  // "chat"이라는 collection에 연결된 선만 연결되어 있으면 된다. 하지만 그러면 파싱이 되어 있지 않기 때문에 파싱을 해서 전달해줘야 한다.
  // 일반적인 스프링 서버에 http요청을 하면 Future 타입이다.
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection("chat").snapshots();
  return stream.map((snapshot) => snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList());
});

final chatFirestoreRepositoryProvider = Provider((ref) {
  return ChatFireStoreRepository();
});

class ChatFireStoreRepository {
  final db = FirebaseFirestore.instance;

  Future<DocumentReference> insert(ChatInsertReqDto dto) async {
    return await db.collection("chat").add(dto.toJson());
  }
}
