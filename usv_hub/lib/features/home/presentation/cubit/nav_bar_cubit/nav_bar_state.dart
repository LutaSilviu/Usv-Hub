part of 'nav_bar_cubit.dart';

final class NavBarState extends Equatable {
  final int index;

  const NavBarState(this.index);

  @override
  List<Object> get props => [index];
}
