// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompliledTemplateFileImpl _$$CompliledTemplateFileImplFromJson(
        Map<String, dynamic> json) =>
    _$CompliledTemplateFileImpl(
      name: json['name'] as String,
      templateType: json['templateType'] as String,
      fileName: json['fileName'] as String,
      path: json['path'] as String,
      content: json['content'] as String,
      fileType: json['fileType'] as String,
    );

Map<String, dynamic> _$$CompliledTemplateFileImplToJson(
        _$CompliledTemplateFileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'templateType': instance.templateType,
      'fileName': instance.fileName,
      'path': instance.path,
      'content': instance.content,
      'fileType': instance.fileType,
    };

_$CompiledCreateCommandImpl _$$CompiledCreateCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$CompiledCreateCommandImpl(
      name: json['name'] as String,
      templates: (json['templates'] as List<dynamic>)
          .map((e) => CompiledTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CompiledCreateCommandImplToJson(
        _$CompiledCreateCommandImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'templates': instance.templates.map((e) => e.toJson()).toList(),
    };

_$CompiledTemplateImpl _$$CompiledTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$CompiledTemplateImpl(
      type: json['type'] as String,
      files: (json['files'] as List<dynamic>)
          .map((e) => CompliledTemplateFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      modificationFiles: (json['modificationFiles'] as List<dynamic>?)
              ?.map((e) =>
                  CompiledFileModification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CompiledTemplateImplToJson(
        _$CompiledTemplateImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'files': instance.files.map((e) => e.toJson()).toList(),
      'modificationFiles':
          instance.modificationFiles.map((e) => e.toJson()).toList(),
    };

_$CompiledFileModificationImpl _$$CompiledFileModificationImplFromJson(
        Map<String, dynamic> json) =>
    _$CompiledFileModificationImpl(
      description: json['description'] as String,
      path: json['path'] as String,
      identifier: json['identifier'] as String,
      template: json['template'] as String,
      error: json['error'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CompiledFileModificationImplToJson(
        _$CompiledFileModificationImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'path': instance.path,
      'identifier': instance.identifier,
      'template': instance.template,
      'error': instance.error,
      'name': instance.name,
    };
