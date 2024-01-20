// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  _log('Setup project');
  _log('Installing fvm');
  var output = Process.runSync('dart', ['pub', 'global', 'activate', 'fvm']);
  _handleProcessResult(output);

  final env = _extractEnv('.env/vars.env');
  final version = env['FLUTTER_VERSION']!;
  _log('Installing fvm flutter version: $version');
  output = Process.runSync('fvm', ['install', version]);
  _handleProcessResult(output);
  _log('Use flutter version for this project: $version');
  output = Process.runSync('fvm', ['use', version]);
  _handleProcessResult(output);
  _log('fvm is ready');
}

Map<String, String> _extractEnv(String path) {
  final file = File(_path(path));
  final string = file.readAsStringSync();
  final rawProps = string.trim().split('\n');
  return Map.fromEntries(rawProps.map((e) {
    final keyValueRaw = e.split('=');
    return MapEntry(keyValueRaw[0], keyValueRaw[1]);
  }));
}

String? _handleProcessResult(ProcessResult result) {
  final out = (result.stdout as String?)?.trim();
  final err = (result.stdout as String?)?.trim();
  if (result.exitCode == 0) {
    _log('Output: $out');
  } else {
    _log('Error: $err');
    throw Exception('Exit code: ${result.exitCode}\n$err');
  }
  return out;
}

void _log(String message) => print(message);

String _path(String path) => path.replaceAll('/', Platform.pathSeparator);
