// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manifest_net_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManifestNetModel _$ManifestNetModelFromJson(Map<String, dynamic> json) {
  return ManifestNetModel(
    json['bundleArchiveChecksum'] as String,
    json['bundleManifestChecksum'] as String,
    json['bundlePlatform'] as String,
    json['bundleType'] as String,
    json['desc'] as String,
    json['entireBundleUrl'] as String,
    json['forceUpdate'] as bool,
    json['patchRootUrl'] as String,
    json['version'] as String,
  );
}

Map<String, dynamic> _$ManifestNetModelToJson(ManifestNetModel instance) =>
    <String, dynamic>{
      'bundleArchiveChecksum': instance.bundleArchiveChecksum,
      'bundleManifestChecksum': instance.bundleManifestChecksum,
      'bundlePlatform': instance.bundlePlatform,
      'bundleType': instance.bundleType,
      'desc': instance.desc,
      'entireBundleUrl': instance.entireBundleUrl,
      'forceUpdate': instance.forceUpdate,
      'patchRootUrl': instance.patchRootUrl,
      'version': instance.version,
    };
