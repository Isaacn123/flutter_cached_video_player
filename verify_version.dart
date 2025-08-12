import 'dart:io';

void main() {
  print('Checking cached_video_player plugin version...');
  
  // Check if the local path exists
  final localPath = '/Users/nsambaisaac/REPOS/flutter_cached_video_player';
  if (Directory(localPath).existsSync()) {
    print('✅ Local plugin path exists: $localPath');
    
    // Check the pubspec.yaml version
    final pubspecFile = File('$localPath/pubspec.yaml');
    if (pubspecFile.existsSync()) {
      final content = pubspecFile.readAsStringSync();
      final versionMatch = RegExp(r'version:\s*([^\s]+)').firstMatch(content);
      if (versionMatch != null) {
        print('✅ Local plugin version: ${versionMatch.group(1)}');
      }
    }
    
    // Check if the fixed CachedVideoPlayer.java exists
    final javaFile = File('$localPath/android/src/main/java/com/lazyarts/vikram/cached_video_player/CachedVideoPlayer.java');
    if (javaFile.existsSync()) {
      final content = javaFile.readAsStringSync();
      if (content.contains('C.CONTENT_TYPE_OTHER')) {
        print('✅ Fixed CachedVideoPlayer.java found (uses CONTENT_TYPE_OTHER)');
      } else if (content.contains('C.TYPE_OTHER')) {
        print('❌ Old CachedVideoPlayer.java found (uses TYPE_OTHER)');
      }
    }
  } else {
    print('❌ Local plugin path does not exist: $localPath');
  }
  
  // Check pub cache
  final pubCacheDir = Directory('${Platform.environment['HOME']}/.pub-cache/git');
  if (pubCacheDir.existsSync()) {
    final cachedDirs = pubCacheDir.listSync().where((e) => e.path.contains('flutter_cached_video_player'));
    if (cachedDirs.isNotEmpty) {
      print('⚠️  Found cached versions:');
      for (final dir in cachedDirs) {
        print('   - ${dir.path}');
      }
    } else {
      print('✅ No cached versions found');
    }
  }
} 