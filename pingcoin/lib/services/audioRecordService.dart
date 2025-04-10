import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderService {
  final FlutterSoundRecord _recorder = FlutterSoundRecord();
  String? _currentRecordingPath;
  bool _isRecording = false;  // Track recording state manually

  bool get isRecording => _isRecording;  // Now returns simple bool
  String? get currentRecordingPath => _currentRecordingPath;

  Future<void> dispose() async {
    if (_isRecording) {
      await _recorder.stop();
    }
  }

  Future<bool> _checkPermissions() async {
    final status = await Permission.microphone.status;
    return status.isGranted || (await Permission.microphone.request()).isGranted;
  }

  Future<String> _generateFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
  }

  Future<String?> startRecording() async {
    if (_isRecording) return null;

    if (!await _checkPermissions()) return null;

    try {
      _currentRecordingPath = await _generateFilePath();
      await _recorder.start(
        path: _currentRecordingPath!,
        encoder: AudioEncoder.AAC,
      );
      _isRecording = true;
      return _currentRecordingPath;
    } catch (e) {
      _currentRecordingPath = null;
      throw Exception('Failed to start recording: $e');
    }
  }

  Future<String?> stopRecording() async {
    if (!_isRecording) return null;

    try {
      final path = await _recorder.stop();
      _currentRecordingPath = path;
      _isRecording = false;
      return path;
    } catch (e) {
      throw Exception('Failed to stop recording: $e');
    }
  }
}