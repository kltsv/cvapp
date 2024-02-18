// ignore_for_file: avoid_print
import 'dart:io';

const _flutterVersion = '3.16.5';

void main() {
  _log('Setup project');
  _log('Installing fvm');
  var output = Process.runSync('dart', ['pub', 'global', 'activate', 'fvm']);
  _handleProcessResult(output);

  const version = _flutterVersion;
  _log('Installing fvm flutter version: $version');
  output = Process.runSync('fvm', ['install', version]);
  _handleProcessResult(output);
  _log('Use flutter version for this project: $version');
  output = Process.runSync('fvm', ['use', version]);
  _handleProcessResult(output);
  _log('fvm is ready');
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
