// lib/config/constants.dart
const String apiServerHost = String.fromEnvironment('API_SERVER_HOST',
    defaultValue: 'http://localhost:8080');

const bool enableLogging =
    bool.fromEnvironment('ENABLE_LOGGING', defaultValue: false);

// 家系図ノードサイズ
const double nodeSize = 200.0;
