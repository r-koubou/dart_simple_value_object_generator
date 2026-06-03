# CHANGELOG

## 1.0.3

Added `empty` field when the type is `String` and added allowEmpty is `true` or minLength is `0`.

## 1.0.2

Updated dependencies.

## 1.0.1

Modified the generator to always create an alias with `<right-hand side alias name>`.

Before:

```dart
@ValueObject<int>
typedef Id = $Id; // Generated alias name is _$Id (=compile error)
```

After:

```dart
@ValueObject<int>
typedef Id = $Id; // Generated alias name is $Id
```


## 1.0.0

- Initial version.
