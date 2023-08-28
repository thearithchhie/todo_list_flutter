import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'submit_form.dart';

import '../common/enum/status_form_enum.dart';
import '../controllers/todo_controller.dart';

class CardWidget extends GetView<TodoController> {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.allTodoList.length,
              itemBuilder: (BuildContext context, int index) {
                final todos = controller.allTodoList.elementAt(index);
                final taskId = todos['id'];
                final title = todos['title'];
                final description = todos['description'];
                final isTodo = todos['isTodo'];
                return Card(
                  child: ListTile(
                    title: isTodo
                        ? Text(todos['title'],
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 16))
                        : Text(todos['title']),
                    subtitle: isTodo
                        ? Text(
                            todos['description'],
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                            ),
                          )
                        : Text(todos['description']),
                    trailing: SizedBox(
                      width: 200,
                      // decoration: const BoxDecoration(
                      //   color: Colors.red
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            value: isTodo,
                            onChanged: (bool? value) async {
                              await controller.updateCheckBox(isTodo, taskId);
                            },
                          ),
                          IconButton(
                              onPressed: () async {
                                Get.bottomSheet(SubmitForm(
                                  title: title,
                                  description: description,
                                  isTodo: isTodo,
                                  statusForm: STATUS_FORM_ENUM.UPDATE,
                                  taskId: taskId,
                                ));
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () async =>
                                  await controller.deleteTask(taskId: taskId),
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
