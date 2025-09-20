// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompliledTemplateFile _$CompliledTemplateFileFromJson(
    Map<String, dynamic> json) {
  return _CompliledTemplateFile.fromJson(json);
}

/// @nodoc
mixin _$CompliledTemplateFile {
  /// Pascal case name of the template this file belongs too
  String get name => throw _privateConstructorUsedError;

  /// Pascal case name of the template type this file belongs too,
  String get templateType => throw _privateConstructorUsedError;

  /// Pascal case name of the file without the extension
  String get fileName => throw _privateConstructorUsedError;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  String get path => throw _privateConstructorUsedError;

  /// The content as is from the file that was read
  String get content => throw _privateConstructorUsedError;

  /// The type of file to determine how we'll store it
  String get fileType => throw _privateConstructorUsedError;

  /// Serializes this CompliledTemplateFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompliledTemplateFileCopyWith<CompliledTemplateFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompliledTemplateFileCopyWith<$Res> {
  factory $CompliledTemplateFileCopyWith(CompliledTemplateFile value,
          $Res Function(CompliledTemplateFile) then) =
      _$CompliledTemplateFileCopyWithImpl<$Res, CompliledTemplateFile>;
  @useResult
  $Res call(
      {String name,
      String templateType,
      String fileName,
      String path,
      String content,
      String fileType});
}

/// @nodoc
class _$CompliledTemplateFileCopyWithImpl<$Res,
        $Val extends CompliledTemplateFile>
    implements $CompliledTemplateFileCopyWith<$Res> {
  _$CompliledTemplateFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templateType = null,
    Object? fileName = null,
    Object? path = null,
    Object? content = null,
    Object? fileType = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateType: null == templateType
          ? _value.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompliledTemplateFileImplCopyWith<$Res>
    implements $CompliledTemplateFileCopyWith<$Res> {
  factory _$$CompliledTemplateFileImplCopyWith(
          _$CompliledTemplateFileImpl value,
          $Res Function(_$CompliledTemplateFileImpl) then) =
      __$$CompliledTemplateFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String templateType,
      String fileName,
      String path,
      String content,
      String fileType});
}

/// @nodoc
class __$$CompliledTemplateFileImplCopyWithImpl<$Res>
    extends _$CompliledTemplateFileCopyWithImpl<$Res,
        _$CompliledTemplateFileImpl>
    implements _$$CompliledTemplateFileImplCopyWith<$Res> {
  __$$CompliledTemplateFileImplCopyWithImpl(_$CompliledTemplateFileImpl _value,
      $Res Function(_$CompliledTemplateFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templateType = null,
    Object? fileName = null,
    Object? path = null,
    Object? content = null,
    Object? fileType = null,
  }) {
    return _then(_$CompliledTemplateFileImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateType: null == templateType
          ? _value.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompliledTemplateFileImpl implements _CompliledTemplateFile {
  _$CompliledTemplateFileImpl(
      {required this.name,
      required this.templateType,
      required this.fileName,
      required this.path,
      required this.content,
      required this.fileType});

  factory _$CompliledTemplateFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompliledTemplateFileImplFromJson(json);

  /// Pascal case name of the template this file belongs too
  @override
  final String name;

  /// Pascal case name of the template type this file belongs too,
  @override
  final String templateType;

  /// Pascal case name of the file without the extension
  @override
  final String fileName;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  @override
  final String path;

  /// The content as is from the file that was read
  @override
  final String content;

  /// The type of file to determine how we'll store it
  @override
  final String fileType;

  @override
  String toString() {
    return 'CompliledTemplateFile(name: $name, templateType: $templateType, fileName: $fileName, path: $path, content: $content, fileType: $fileType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompliledTemplateFileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.templateType, templateType) ||
                other.templateType == templateType) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, templateType, fileName, path, content, fileType);

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompliledTemplateFileImplCopyWith<_$CompliledTemplateFileImpl>
      get copyWith => __$$CompliledTemplateFileImplCopyWithImpl<
          _$CompliledTemplateFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompliledTemplateFileImplToJson(
      this,
    );
  }
}

abstract class _CompliledTemplateFile implements CompliledTemplateFile {
  factory _CompliledTemplateFile(
      {required final String name,
      required final String templateType,
      required final String fileName,
      required final String path,
      required final String content,
      required final String fileType}) = _$CompliledTemplateFileImpl;

  factory _CompliledTemplateFile.fromJson(Map<String, dynamic> json) =
      _$CompliledTemplateFileImpl.fromJson;

  /// Pascal case name of the template this file belongs too
  @override
  String get name;

  /// Pascal case name of the template type this file belongs too,
  @override
  String get templateType;

  /// Pascal case name of the file without the extension
  @override
  String get fileName;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  @override
  String get path;

  /// The content as is from the file that was read
  @override
  String get content;

  /// The type of file to determine how we'll store it
  @override
  String get fileType;

  /// Create a copy of CompliledTemplateFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompliledTemplateFileImplCopyWith<_$CompliledTemplateFileImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CompiledCreateCommand _$CompiledCreateCommandFromJson(
    Map<String, dynamic> json) {
  return _CompiledCreateCommand.fromJson(json);
}

/// @nodoc
mixin _$CompiledCreateCommand {
  String get name => throw _privateConstructorUsedError;
  List<CompiledTemplate> get templates => throw _privateConstructorUsedError;

  /// Serializes this CompiledCreateCommand to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompiledCreateCommandCopyWith<CompiledCreateCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledCreateCommandCopyWith<$Res> {
  factory $CompiledCreateCommandCopyWith(CompiledCreateCommand value,
          $Res Function(CompiledCreateCommand) then) =
      _$CompiledCreateCommandCopyWithImpl<$Res, CompiledCreateCommand>;
  @useResult
  $Res call({String name, List<CompiledTemplate> templates});
}

/// @nodoc
class _$CompiledCreateCommandCopyWithImpl<$Res,
        $Val extends CompiledCreateCommand>
    implements $CompiledCreateCommandCopyWith<$Res> {
  _$CompiledCreateCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templates = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templates: null == templates
          ? _value.templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<CompiledTemplate>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompiledCreateCommandImplCopyWith<$Res>
    implements $CompiledCreateCommandCopyWith<$Res> {
  factory _$$CompiledCreateCommandImplCopyWith(
          _$CompiledCreateCommandImpl value,
          $Res Function(_$CompiledCreateCommandImpl) then) =
      __$$CompiledCreateCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<CompiledTemplate> templates});
}

/// @nodoc
class __$$CompiledCreateCommandImplCopyWithImpl<$Res>
    extends _$CompiledCreateCommandCopyWithImpl<$Res,
        _$CompiledCreateCommandImpl>
    implements _$$CompiledCreateCommandImplCopyWith<$Res> {
  __$$CompiledCreateCommandImplCopyWithImpl(_$CompiledCreateCommandImpl _value,
      $Res Function(_$CompiledCreateCommandImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templates = null,
  }) {
    return _then(_$CompiledCreateCommandImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templates: null == templates
          ? _value._templates
          : templates // ignore: cast_nullable_to_non_nullable
              as List<CompiledTemplate>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompiledCreateCommandImpl implements _CompiledCreateCommand {
  _$CompiledCreateCommandImpl(
      {required this.name, required final List<CompiledTemplate> templates})
      : _templates = templates;

  factory _$CompiledCreateCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompiledCreateCommandImplFromJson(json);

  @override
  final String name;
  final List<CompiledTemplate> _templates;
  @override
  List<CompiledTemplate> get templates {
    if (_templates is EqualUnmodifiableListView) return _templates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templates);
  }

  @override
  String toString() {
    return 'CompiledCreateCommand(name: $name, templates: $templates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompiledCreateCommandImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._templates, _templates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_templates));

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompiledCreateCommandImplCopyWith<_$CompiledCreateCommandImpl>
      get copyWith => __$$CompiledCreateCommandImplCopyWithImpl<
          _$CompiledCreateCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompiledCreateCommandImplToJson(
      this,
    );
  }
}

abstract class _CompiledCreateCommand implements CompiledCreateCommand {
  factory _CompiledCreateCommand(
          {required final String name,
          required final List<CompiledTemplate> templates}) =
      _$CompiledCreateCommandImpl;

  factory _CompiledCreateCommand.fromJson(Map<String, dynamic> json) =
      _$CompiledCreateCommandImpl.fromJson;

  @override
  String get name;
  @override
  List<CompiledTemplate> get templates;

  /// Create a copy of CompiledCreateCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompiledCreateCommandImplCopyWith<_$CompiledCreateCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CompiledTemplate _$CompiledTemplateFromJson(Map<String, dynamic> json) {
  return _CompiledTemplate.fromJson(json);
}

/// @nodoc
mixin _$CompiledTemplate {
  String get type => throw _privateConstructorUsedError;
  List<CompliledTemplateFile> get files => throw _privateConstructorUsedError;
  List<CompiledFileModification> get modificationFiles =>
      throw _privateConstructorUsedError;

  /// Serializes this CompiledTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompiledTemplateCopyWith<CompiledTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledTemplateCopyWith<$Res> {
  factory $CompiledTemplateCopyWith(
          CompiledTemplate value, $Res Function(CompiledTemplate) then) =
      _$CompiledTemplateCopyWithImpl<$Res, CompiledTemplate>;
  @useResult
  $Res call(
      {String type,
      List<CompliledTemplateFile> files,
      List<CompiledFileModification> modificationFiles});
}

/// @nodoc
class _$CompiledTemplateCopyWithImpl<$Res, $Val extends CompiledTemplate>
    implements $CompiledTemplateCopyWith<$Res> {
  _$CompiledTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? files = null,
    Object? modificationFiles = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      modificationFiles: null == modificationFiles
          ? _value.modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompiledTemplateImplCopyWith<$Res>
    implements $CompiledTemplateCopyWith<$Res> {
  factory _$$CompiledTemplateImplCopyWith(_$CompiledTemplateImpl value,
          $Res Function(_$CompiledTemplateImpl) then) =
      __$$CompiledTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      List<CompliledTemplateFile> files,
      List<CompiledFileModification> modificationFiles});
}

/// @nodoc
class __$$CompiledTemplateImplCopyWithImpl<$Res>
    extends _$CompiledTemplateCopyWithImpl<$Res, _$CompiledTemplateImpl>
    implements _$$CompiledTemplateImplCopyWith<$Res> {
  __$$CompiledTemplateImplCopyWithImpl(_$CompiledTemplateImpl _value,
      $Res Function(_$CompiledTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? files = null,
    Object? modificationFiles = null,
  }) {
    return _then(_$CompiledTemplateImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      modificationFiles: null == modificationFiles
          ? _value._modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompiledTemplateImpl implements _CompiledTemplate {
  _$CompiledTemplateImpl(
      {required this.type,
      required final List<CompliledTemplateFile> files,
      final List<CompiledFileModification> modificationFiles = const []})
      : _files = files,
        _modificationFiles = modificationFiles;

  factory _$CompiledTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompiledTemplateImplFromJson(json);

  @override
  final String type;
  final List<CompliledTemplateFile> _files;
  @override
  List<CompliledTemplateFile> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  final List<CompiledFileModification> _modificationFiles;
  @override
  @JsonKey()
  List<CompiledFileModification> get modificationFiles {
    if (_modificationFiles is EqualUnmodifiableListView)
      return _modificationFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modificationFiles);
  }

  @override
  String toString() {
    return 'CompiledTemplate(type: $type, files: $files, modificationFiles: $modificationFiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompiledTemplateImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._files, _files) &&
            const DeepCollectionEquality()
                .equals(other._modificationFiles, _modificationFiles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_files),
      const DeepCollectionEquality().hash(_modificationFiles));

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompiledTemplateImplCopyWith<_$CompiledTemplateImpl> get copyWith =>
      __$$CompiledTemplateImplCopyWithImpl<_$CompiledTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompiledTemplateImplToJson(
      this,
    );
  }
}

abstract class _CompiledTemplate implements CompiledTemplate {
  factory _CompiledTemplate(
          {required final String type,
          required final List<CompliledTemplateFile> files,
          final List<CompiledFileModification> modificationFiles}) =
      _$CompiledTemplateImpl;

  factory _CompiledTemplate.fromJson(Map<String, dynamic> json) =
      _$CompiledTemplateImpl.fromJson;

  @override
  String get type;
  @override
  List<CompliledTemplateFile> get files;
  @override
  List<CompiledFileModification> get modificationFiles;

  /// Create a copy of CompiledTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompiledTemplateImplCopyWith<_$CompiledTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompiledFileModification _$CompiledFileModificationFromJson(
    Map<String, dynamic> json) {
  return _CompiledFileModification.fromJson(json);
}

/// @nodoc
mixin _$CompiledFileModification {
  /// A short description for what this modiciation does
  String get description => throw _privateConstructorUsedError;

  /// The relative path to the file that needs to be modified
  String get path => throw _privateConstructorUsedError;

  /// The identifier to use to determine location of modifications
  String get identifier => throw _privateConstructorUsedError;

  /// The mustache template to use when rendering the modification
  String get template => throw _privateConstructorUsedError;

  /// The message to show the user of the cli if the modification fails
  String get error => throw _privateConstructorUsedError;

  /// The message to show the user of the cli if the modification succeeds
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CompiledFileModification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompiledFileModificationCopyWith<CompiledFileModification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledFileModificationCopyWith<$Res> {
  factory $CompiledFileModificationCopyWith(CompiledFileModification value,
          $Res Function(CompiledFileModification) then) =
      _$CompiledFileModificationCopyWithImpl<$Res, CompiledFileModification>;
  @useResult
  $Res call(
      {String description,
      String path,
      String identifier,
      String template,
      String error,
      String name});
}

/// @nodoc
class _$CompiledFileModificationCopyWithImpl<$Res,
        $Val extends CompiledFileModification>
    implements $CompiledFileModificationCopyWith<$Res> {
  _$CompiledFileModificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? path = null,
    Object? identifier = null,
    Object? template = null,
    Object? error = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompiledFileModificationImplCopyWith<$Res>
    implements $CompiledFileModificationCopyWith<$Res> {
  factory _$$CompiledFileModificationImplCopyWith(
          _$CompiledFileModificationImpl value,
          $Res Function(_$CompiledFileModificationImpl) then) =
      __$$CompiledFileModificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      String path,
      String identifier,
      String template,
      String error,
      String name});
}

/// @nodoc
class __$$CompiledFileModificationImplCopyWithImpl<$Res>
    extends _$CompiledFileModificationCopyWithImpl<$Res,
        _$CompiledFileModificationImpl>
    implements _$$CompiledFileModificationImplCopyWith<$Res> {
  __$$CompiledFileModificationImplCopyWithImpl(
      _$CompiledFileModificationImpl _value,
      $Res Function(_$CompiledFileModificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? path = null,
    Object? identifier = null,
    Object? template = null,
    Object? error = null,
    Object? name = null,
  }) {
    return _then(_$CompiledFileModificationImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompiledFileModificationImpl implements _CompiledFileModification {
  _$CompiledFileModificationImpl(
      {required this.description,
      required this.path,
      required this.identifier,
      required this.template,
      required this.error,
      required this.name});

  factory _$CompiledFileModificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompiledFileModificationImplFromJson(json);

  /// A short description for what this modiciation does
  @override
  final String description;

  /// The relative path to the file that needs to be modified
  @override
  final String path;

  /// The identifier to use to determine location of modifications
  @override
  final String identifier;

  /// The mustache template to use when rendering the modification
  @override
  final String template;

  /// The message to show the user of the cli if the modification fails
  @override
  final String error;

  /// The message to show the user of the cli if the modification succeeds
  @override
  final String name;

  @override
  String toString() {
    return 'CompiledFileModification(description: $description, path: $path, identifier: $identifier, template: $template, error: $error, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompiledFileModificationImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.template, template) ||
                other.template == template) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, path, identifier, template, error, name);

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompiledFileModificationImplCopyWith<_$CompiledFileModificationImpl>
      get copyWith => __$$CompiledFileModificationImplCopyWithImpl<
          _$CompiledFileModificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompiledFileModificationImplToJson(
      this,
    );
  }
}

abstract class _CompiledFileModification implements CompiledFileModification {
  factory _CompiledFileModification(
      {required final String description,
      required final String path,
      required final String identifier,
      required final String template,
      required final String error,
      required final String name}) = _$CompiledFileModificationImpl;

  factory _CompiledFileModification.fromJson(Map<String, dynamic> json) =
      _$CompiledFileModificationImpl.fromJson;

  /// A short description for what this modiciation does
  @override
  String get description;

  /// The relative path to the file that needs to be modified
  @override
  String get path;

  /// The identifier to use to determine location of modifications
  @override
  String get identifier;

  /// The mustache template to use when rendering the modification
  @override
  String get template;

  /// The message to show the user of the cli if the modification fails
  @override
  String get error;

  /// The message to show the user of the cli if the modification succeeds
  @override
  String get name;

  /// Create a copy of CompiledFileModification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompiledFileModificationImplCopyWith<_$CompiledFileModificationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
