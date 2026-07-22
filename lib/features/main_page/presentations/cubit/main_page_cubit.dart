import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/main_page/presentations/cubit/main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageInitial());

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(BottomNavChanged(index));
  }
}
