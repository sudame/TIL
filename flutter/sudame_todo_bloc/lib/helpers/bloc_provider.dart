import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/helpers/base_bloc.dart';

class BlocProvider<Bloc extends BaseBloc> extends StatefulWidget {
  final Bloc bloc;
  final Widget child;

  BlocProvider({
    Key key,
    @required this.bloc,
    @required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BlocProviderState<Bloc>();
  }

  static Bloc of<Bloc extends BaseBloc>(BuildContext context) {
    return _BlocProviderInheritedWidget.of<Bloc>(context);
  }
}

class _BlocProviderState<Bloc extends BaseBloc> extends State<BlocProvider> {
  Bloc _bloc;
  Widget _child;

  @override
  void initState() {
    super.initState();

    _bloc = widget.bloc;
    _child = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInheritedWidget<Bloc>(
      bloc: _bloc,
      child: _child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}

@immutable
class _BlocProviderInheritedWidget<Bloc extends BaseBloc>
    extends InheritedWidget {
  final Bloc bloc;

  const _BlocProviderInheritedWidget({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(
          child: child,
        );

  static Bloc of<Bloc extends BaseBloc>(BuildContext context) {
    Type typeOf<T>() => T;

    return (context
            .ancestorInheritedElementForWidgetOfExactType(
                typeOf<_BlocProviderInheritedWidget<Bloc>>())
            .widget as _BlocProviderInheritedWidget<Bloc>)
        .bloc;
  }

  @override
  bool updateShouldNotify(_BlocProviderInheritedWidget oldWidget) {
    return false;
  }
}
