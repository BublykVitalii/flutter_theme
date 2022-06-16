import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_theme/screens/domain/todo.dart';
import 'package:flutter_theme/user/domain/firestore_ids.dart';
import 'package:flutter_theme/user/domain/user_exception.dart';
import 'package:flutter_theme/user/domain/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class FirebaseUserRepository extends UserRepository {
  late final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection(FirestoreIds.users);

  @override
  Future<Todo?> getMainTodo(String userId) async {
    try {
      final userDocRef = _users.doc(userId);
      final userData =
          await userDocRef.get().then((value) => value.data()) ?? {};
      final mainTodoId = userData[FirestoreIds.mainTodoId] ?? '';
      final todo = await _todoFromJson(userData);
      return todo.firstWhere((d) => d.id == mainTodoId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Todo>> getTodo(String userId) async {
    final userDoc = await _users.doc(userId).get();
    return _todoFromJson(userDoc.data());
  }

  @override
  Future<void> createNewTodo(Todo todo, String userId) async {
    final userDocRef = _users.doc(userId);
    final todoJson = _todoToJson(todo);
    final todos = await getTodo(userId);
    try {
      if (todos.contains(todo)) {
        throw TodoAlreadyExistException(todo.title);
      }
      await Future.wait([
        userDocRef.update({
          FirestoreIds.todos: FieldValue.arrayUnion([todoJson]),
        }),
        if (todo.isMain) userDocRef.update({FirestoreIds.mainTodoId: todo.id}),
      ]);
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        await userDocRef.set({
          FirestoreIds.mainTodoId: todo.id,
          FirestoreIds.todos: [_todoToJson],
        });
        return;
      }
      rethrow;
    }
  }

  @override
  Future<void> editTodo(Todo todo, String userId) async {
    final userDocRef = _users.doc(userId);
    final userData = await userDocRef.get().then((value) => value.data()) ?? {};
    final todoJson = _todoToJson(todo);
    late final oldTodoJson;
    try {
      final todoJson = userData[FirestoreIds.todos] ?? [];
      oldTodoJson =
          todoJson.firstWhere((json) => json[FirestoreIds.id] == todo.id);
    } catch (_) {
      oldTodoJson = {};
    }

    if (!mapEquals(todoJson, oldTodoJson)) {
      await Future.wait([
        userDocRef.update({
          FirestoreIds.todos: FieldValue.arrayUnion([todoJson]),
        }),
        userDocRef.update({
          FirestoreIds.todos: FieldValue.arrayRemove([oldTodoJson]),
        }),
      ]);
    }
    if (todo.isMain) {
      await userDocRef.update({
        FirestoreIds.mainTodoId: todo.id,
      });
    } else {
      final mainTodoId = userData[FirestoreIds.mainTodoId] ?? '';
      if (mainTodoId == todo.id) {
        await userDocRef.update({
          FirestoreIds.mainTodoId: FieldValue.delete(),
        });
      }
    }
  }

  @override
  Future<void> removeTodo(String id, String userId) async {
    final userDoc = _users.doc(userId);
    final userData = await userDoc.get().then((value) => value.data()) ?? {};
    final mainTodoId = userData[FirestoreIds.mainTodoId] ?? '';
    final todosJson = userData[FirestoreIds.todos] ?? [];
    final todoJson =
        todosJson.firstWhere((json) => json[FirestoreIds.id] == id);

    await Future.wait([
      userDoc.update({
        FirestoreIds.todos: FieldValue.arrayRemove([todoJson]),
        if (mainTodoId == id) FirestoreIds.mainTodoId: FieldValue.delete(),
      }),
    ]);
  }

  Future<List<Todo>> _todoFromJson(
    Map<String, dynamic>? userDataJson,
  ) async {
    if (userDataJson == null) return [];
    final String mainTodoId = userDataJson[FirestoreIds.mainTodoId] ?? '';
    final List todosJson = userDataJson[FirestoreIds.todos];
    final todos = await Future.wait(
      todosJson.map<Future<Todo>>(
        (json) async {
          return Todo(
            json.data()["title"] ?? json.data()['note'],
            json[FirestoreIds.id],
            complete: json.data()["complete"],
            note: json.data()['note'],
            isMain: mainTodoId == json[FirestoreIds.id],
          );
        },
      ).toList(),
    );
    return todos..sort((d1, d2) => d1.title.compareTo(d2.title));
  }

  Map<String, dynamic> _todoToJson(Todo todo) {
    return {
      FirestoreIds.id: todo.id,
      FirestoreIds.title: todo.title,
    };
  }
}
