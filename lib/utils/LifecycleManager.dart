import 'package:flutter/widgets.dart';

class LifecycleManager with WidgetsBindingObserver {
  static final LifecycleManager _instance = LifecycleManager._internal();

  factory LifecycleManager() => _instance;

  LifecycleManager._internal();

  List<AppLifecycleStateCallback> _listeners = [];

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _listeners.clear();
  }

  /// 添加生命周期监听器
  void addListener(AppLifecycleStateCallback listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// 移除监听器
  void removeListener(AppLifecycleStateCallback listener) {
    _listeners.remove(listener);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    for (var listener in _listeners) {
      listener(state);
    }
  }
}

/// 生命周期回调函数类型
typedef AppLifecycleStateCallback = void Function(AppLifecycleState state);
