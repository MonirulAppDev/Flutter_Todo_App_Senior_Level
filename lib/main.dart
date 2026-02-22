import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/bloc/todo_event.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/presentation/bloc/profile_event.dart';
import 'features/todo/presentation/pages/main_navigation_page.dart';
import 'features/profile/presentation/pages/login_page.dart';
import 'features/profile/presentation/bloc/profile_state.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              sl<TodoBloc>()..add(GetTodosForDateEvent(DateTime.now())),
        ),
        BlocProvider(create: (_) => sl<ProfileBloc>()..add(LoadProfileEvent())),
      ],
      child: MaterialApp(
        title: 'Premium Todo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is Authenticated || state is ProfileLoaded) {
              return const MainNavigationPage();
            } else if (state is Unauthenticated) {
              return const LoginPage();
            } else if (state is ProfileLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else {
              // Initial or Error
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
