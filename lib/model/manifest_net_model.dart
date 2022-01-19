/*
 * @Author: Cao Shixin
 * @Date: 2021-06-29 09:00:11
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-06-29 16:41:44
 * @Description: 
 */
import 'package:json_annotation/json_annotation.dart';

part 'manifest_net_model.g.dart';

@JsonSerializable()
class ManifestNetModel {
  late String bundleArchiveChecksum;
  late String bundleManifestChecksum;
  late String bundlePlatform;
  late String bundleType;
  late String desc;
  late String entireBundleUrl;
  late bool forceUpdate;
  late String patchRootUrl;
  late String version;
  ManifestNetModel(
      this.bundleArchiveChecksum,
      this.bundleManifestChecksum,
      this.bundlePlatform,
      this.bundleType,
      this.desc,
      this.entireBundleUrl,
      this.forceUpdate,
      this.patchRootUrl,
      this.version);

  factory ManifestNetModel.fromJson(Map<String, dynamic> json) =>
      _$ManifestNetModelFromJson(json);

  Map<String, dynamic> toJson() => _$ManifestNetModelToJson(this);
}
