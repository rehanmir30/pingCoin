import 'dart:io';
import 'dart:math';
import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full/log.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AudioCompareService {
  static const int SAMPLE_RATE = 44100;
  static const double IMPACT_THRESHOLD = 0.3; // Threshold for detecting coin impact
  static const int IMPACT_WINDOW_MS = 100; // Analyze 100ms around impact

  Future<String> _convertToWav(String inputPath, String outputPath) async {
    final command = '-y -i "$inputPath" -ar $SAMPLE_RATE -ac 1 -f wav "$outputPath"';
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (!(returnCode?.isValueSuccess() ?? false)) {
      throw Exception('FFmpeg conversion failed');
    }
    return outputPath;
  }

  Future<String> _downloadAndConvertReference(String mp3Url) async {
    final tempDir = await getTemporaryDirectory();
    final mp3Path = '${tempDir.path}/reference_${DateTime.now().millisecondsSinceEpoch}.mp3';
    final wavPath = '${tempDir.path}/reference_${DateTime.now().millisecondsSinceEpoch}.wav';

    await File(mp3Path).writeAsBytes((await http.get(Uri.parse(mp3Url))).bodyBytes);
    return await _convertToWav(mp3Path, wavPath);
  }

  Future<List<double>> _extractNormalizedSamples(String wavPath) async {
    final bytes = await File(wavPath).readAsBytes();
    const headerSize = 44;
    final pcmBytes = bytes.sublist(headerSize);

    final samples = <double>[];
    for (int i = 0; i < pcmBytes.length - 1; i += 2) {
      int sample = pcmBytes[i] | (pcmBytes[i + 1] << 8);
      samples.add(sample.toSigned(16) / 32768.0); // Normalize to [-1, 1]
    }
    return samples;
  }

  int _findImpactPosition(List<double> samples) {
    // Find the first sample exceeding threshold
    for (int i = 0; i < samples.length; i++) {
      if (samples[i].abs() > IMPACT_THRESHOLD) {
        return i;
      }
    }
    return 0;
  }

  List<double> _extractImpactWindow(List<double> samples, int impactPos) {
    final windowSize = (IMPACT_WINDOW_MS * SAMPLE_RATE / 1000).round();
    final start = max(0, impactPos - windowSize ~/ 4);
    final end = min(samples.length, start + windowSize);
    return samples.sublist(start, end);
  }

  double _compareFrequencyContent(List<double> s1, List<double> s2) {
    // Simple FFT comparison (for actual implementation, consider using a proper FFT library)
    final fft1 = _simpleFFT(s1);
    final fft2 = _simpleFFT(s2);

    double error = 0.0;
    final minLength = min(fft1.length, fft2.length);
    for (int i = 0; i < minLength; i++) {
      error += (fft1[i] - fft2[i]).abs();
    }
    return error / minLength;
  }

  List<double> _simpleFFT(List<double> samples) {
    // Simplified frequency analysis - replace with proper FFT in production
    final fft = List<double>.filled(5, 0.0);
    for (int i = 0; i < samples.length; i++) {
      fft[0] += samples[i].abs(); // Overall energy
      fft[1] += samples[i].abs() * sin(i * 0.01); // Low freq
      fft[2] += samples[i].abs() * sin(i * 0.1); // Mid freq
      fft[3] += samples[i].abs() * sin(i * 1.0); // High freq
      fft[4] += samples[i].abs() * (i % 10); // Transient content
    }
    return fft;
  }

  Future<double> compareCoinAudio({
    required String recordedAacPath,
    required String referenceMp3Url,
  }) async {
    try {
      // Convert both audio files to WAV
      final tempDir = await getTemporaryDirectory();
      final recordedWavPath = '${tempDir.path}/recorded_${DateTime.now().millisecondsSinceEpoch}.wav';
      await _convertToWav(recordedAacPath, recordedWavPath);

      final referenceWavPath = await _downloadAndConvertReference(referenceMp3Url);

      // Extract normalized samples
      final recordedSamples = await _extractNormalizedSamples(recordedWavPath);
      final referenceSamples = await _extractNormalizedSamples(referenceWavPath);

      // Find impact positions
      final recordedImpactPos = _findImpactPosition(recordedSamples);
      final referenceImpactPos = _findImpactPosition(referenceSamples);

      // Extract impact windows
      final recordedImpact = _extractImpactWindow(recordedSamples, recordedImpactPos);
      final referenceImpact = _extractImpactWindow(referenceSamples, referenceImpactPos);

      // Compare frequency content
      final freqDifference = _compareFrequencyContent(recordedImpact, referenceImpact);

      // Calculate similarity score (0% = identical, 100% = completely different)
      double similarityScore = (freqDifference * 100).clamp(0.0, 100.0);

      // Clean up temporary files
      await File(recordedWavPath).delete();
      await File(referenceWavPath).delete();

      return 100 - similarityScore;
    } catch (e) {
      print('Audio comparison error: $e');
      return 100.0;
    }
  }
}