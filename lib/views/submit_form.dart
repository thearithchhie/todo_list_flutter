// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/enum/status_form_enum.dart';
import '../common/widgets/input_widget.dart';
import '../controllers/todo_controller.dart';

class SubmitForm extends StatelessWidget {
  String? taskId;
  String? title;
  String? description;
  dynamic isTodo;
  dynamic statusForm;
  SubmitForm({super.key, this.title, this.description, this.isTodo, this.statusForm, this.taskId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoController());
    final size = Get.size;
    return Form(
         key: controller.fromKey,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                InputWidget(
                  controller: controller.textTitleForm,
                  hintText: title,
                ),
                InputWidget(
                  controller: controller.textDescriptionForm,
                  hintText: description,
                ),
                statusForm == STATUS_FORM_ENUM.ADD
                ? 
                TextButton(
                    onPressed: () {
                      controller.addTodo();
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.0095,
                            horizontal: size.width * 0.04),
                        child: const Text('ADD',
                            style: TextStyle(color: Colors.black))))
                : TextButton(
                    onPressed: () {
                      final updateTitle = controller.textTitleForm?.value.text;
                      final updateDescription = controller.textDescriptionForm?.value.text;
                      if(updateTitle!.isNotEmpty && updateDescription!.isNotEmpty) {
                        title = updateTitle;
                        description = updateDescription;
                      }else if(updateTitle.isNotEmpty) {
                        title = updateTitle;
                      }else if(updateDescription!.isNotEmpty) {
                        description = updateDescription;
                      }

                      controller.updateTasks(
                        taskId: taskId,
                        title: title,
                        description: description,
                        isTodo: isTodo!
                      );
              
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.0095,
                            horizontal: size.width * 0.04),
                        child: const Text('Update',
                            style: TextStyle(color: Colors.black))))
              ],
            )),
      );
  }
}
