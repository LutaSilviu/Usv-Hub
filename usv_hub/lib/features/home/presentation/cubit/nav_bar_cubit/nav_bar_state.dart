part of 'nav_bar_cubit.dart';

final class NavBarState extends Equatable {
  const NavBarState(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}
