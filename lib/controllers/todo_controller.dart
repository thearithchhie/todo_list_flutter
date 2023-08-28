// ignore_for_file: unused_element, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/widgets/ui.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  final addTodoTitle = 'Add todo'.obs;
  final RxBool? isCheck = false.obs;

  GlobalKey<FormState>? fromKey;
  TextEditingController? textTitleForm = TextEditingController(text: '');
  TextEditingController? textDescriptionForm = TextEditingController(text: '');

  final fireStore = FirebaseFirestore.instance.collection('todos');
  var allTodoList = [].obs;
  var todo = Todo().obs;
  var todoList = <Todo>[].obs;

  ScrollController? scrollController;
  RxList<bool> isCheckedList = <bool>[].obs;

  Future updateCheckBox(bool? isTodo, String taskId) async {
    final todo = await fireStore.doc(taskId).get();
    if(todo.data()!.isNotEmpty) {
      final update = await fireStore.doc(taskId).update({
        "isTodo": isTodo == true ? false : true
      });
      Get.showSnackbar(UI.successSnackBar(message: 'Mark is completely'));
      await getAllTodos();
    }
  }

  void refreshTodo({bool showMessage = false}) async {
    getAllTodos();
    if (showMessage) {
      Get.showSnackbar(
          UI.successSnackBar(message: "Todo page refreshed successfully"));
    }
  }

  void initScrollController() {
    scrollController = ScrollController();
    getAllTodos();
  }

  Future<void> getAllTodos() async {
    try {
      fireStore.get().then((QuerySnapshot querySnapshot) {
        final data = querySnapshot.docs;
      });
      var response = await fireStore.get();
      allTodoList.assignAll(response.docs);
    }catch(e) {
      Get.log('getAllTodos ${e.toString()}');
    }
  }

  Future addTodo() async {
    try {
      Get.log(
          'addTodo ${textTitleForm?.value.text}, ${textDescriptionForm?.value.text}');
      final valueDuplicate = await checkDuplicateRecord(
          title: textTitleForm!.value.text,
          description: textDescriptionForm!.value.text,
          isTodo: false);
          if(valueDuplicate == true) {
            return;
          }

      DocumentReference docRef = await fireStore.add(
        {
          'title': textTitleForm?.value.text,
          'description': textDescriptionForm?.value.text,
          'isTodo': false
        },
      );
      String taskId = docRef.id;
      fireStore.doc(taskId).update(
        {'id': taskId},
      );
      getAllTodos();
      _clearAll();
    } catch (e) {
      Get.log('catch addTodo ${e.toString()}');
    }
  }

  Future<void> updateTasks(
      {String? taskId,
      String? title,
      String? description,
      bool isTodo = false}) async {
    try {
      final valueDuplicate = await checkDuplicateRecord(
          title: textTitleForm!.value.text,
          description: textDescriptionForm!.value.text,
          isTodo: false);
          if(valueDuplicate == true) {
            return;
          }
    CollectionReference collection =
        FirebaseFirestore.instance.collection('todos');
    collection
        .doc(taskId)
        .update({'title': title, 'description': description, 'isTodo': isTodo})
        .then((_) => Get.showSnackbar(
            UI.successSnackBar(message: 'update Successfully')))
        .catchError((e) => Get.showSnackbar(
            UI.errorSnackBar(message: 'updateTasks Failed: $e')));
    getAllTodos();
    _clearAll();
    }catch(e) {
      Get.log('catch updateTasks ${e.toString()}');
    }
  }

  Future<void> deleteTask({required String taskId}) async {
    fireStore
        .doc(taskId)
        .delete()
        .then((_) =>
            Get.showSnackbar(UI.errorSnackBar(message: 'Delete Successfully')))
        .catchError(
            (e) => Get.showSnackbar(UI.errorSnackBar(message: 'Failed: $e')));
    getAllTodos();
  }

  Future checkDuplicateRecord(
      {required String title,
      required String description,
      required bool isTodo}) async {
    try {
      final querySnapshot = await fireStore
        .where("title", isEqualTo: title)
        .where("description", isEqualTo: description)
        .where("isTodo", isEqualTo: isTodo)
        .get();
        if (querySnapshot.docs.isNotEmpty) {
          Get.showSnackbar(UI.warningSnackBar(message: 'Record duplicate'));
          return true;
    } else {
      Get.log('we can create new one');
    }
    }catch(e) {
      Get.log('catch checkDuplicateRecord ${e.toString()}');
    }
  }

  Future filterTodo(String query) async {
   try {
     final filter = await fireStore.where('title', isEqualTo: query).get();
      Get.log('allTodoList ${filter.docs}');
      if(filter.docs.isNotEmpty) {
      allTodoList.assignAll(filter.docs);
      }else if(filter.docs.isEmpty && query.isNotEmpty) {
        allTodoList.value = [];
      }
      if(query.isEmpty) {
        await getAllTodos();
      }
   }catch(e) {
    Get.log('filterTodo ${e.toString()}');
   }
  }

  void _clearAll() {
    textTitleForm?.clear();
    textDescriptionForm?.clear();
    Get.back();
  }
}
