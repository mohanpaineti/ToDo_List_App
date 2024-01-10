import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/features/add_task/add_task_ui.dart';
import 'package:to_do_app/features/diaplay_list/todo_ui.dart';
import 'package:to_do_app/routers/error_screen.dart';
import 'package:to_do_app/routers/routes_name.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: AppRouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: AppRouteNames.splash,
        path: AppRouteNames.splash,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ToDoList(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.addTask,
        path: AppRouteNames.addTask,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const AddTaskScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorScreen(
        e: state.error,
      ),
    ),
  );
}
