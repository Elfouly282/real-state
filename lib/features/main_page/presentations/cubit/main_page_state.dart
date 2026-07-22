abstract class MainPageState {}

class MainPageInitial extends MainPageState {}

class BottomNavChanged extends MainPageState {
  final int currentIndex;

  BottomNavChanged(this.currentIndex);
}
