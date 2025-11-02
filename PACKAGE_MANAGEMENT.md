# Package Management Guide (Guía de Gestión de Paquetes)

## Overview / Resumen

This document explains how package dependencies are managed in this Flutter project.
Este documento explica cómo se gestionan las dependencias de paquetes en este proyecto Flutter.

## Cerrar Paquetes (Closing/Locking Packages)

"Cerrar paquetes" refers to the process of locking package versions to ensure consistent builds across all environments.
"Cerrar paquetes" se refiere al proceso de bloquear las versiones de los paquetes para garantizar compilaciones consistentes en todos los entornos.

### What is pubspec.lock? / ¿Qué es pubspec.lock?

The `pubspec.lock` file contains the exact versions of all dependencies used in the project. It ensures:
El archivo `pubspec.lock` contiene las versiones exactas de todas las dependencias utilizadas en el proyecto. Garantiza:

- **Consistency**: All developers and CI/CD systems use the same package versions
  **Consistencia**: Todos los desarrolladores y sistemas CI/CD usan las mismas versiones de paquetes
  
- **Reproducibility**: Builds are reproducible across different environments
  **Reproducibilidad**: Las compilaciones son reproducibles en diferentes entornos
  
- **Stability**: Prevents unexpected breaking changes from automatic updates
  **Estabilidad**: Previene cambios inesperados por actualizaciones automáticas

### Why Commit pubspec.lock? / ¿Por qué confirmar pubspec.lock?

For application projects (like this one), `pubspec.lock` MUST be committed to version control because:
Para proyectos de aplicaciones (como este), `pubspec.lock` DEBE confirmarse en el control de versiones porque:

1. It ensures all team members work with identical dependencies
   Garantiza que todos los miembros del equipo trabajen con dependencias idénticas

2. CI/CD pipelines build with the exact tested versions
   Las canalizaciones CI/CD construyen con las versiones exactas probadas

3. It prevents "works on my machine" problems
   Previene problemas de "funciona en mi máquina"

**Note**: Only package/library projects should exclude `pubspec.lock` from version control.
**Nota**: Solo los proyectos de paquetes/bibliotecas deben excluir `pubspec.lock` del control de versiones.

## Managing Dependencies / Gestión de Dependencias

### Adding a New Package / Agregar un Nuevo Paquete

```bash
# Add to pubspec.yaml, then:
# Agregar a pubspec.yaml, luego:
flutter pub get
```

This will:
Esto hará:
- Download the package / Descargará el paquete
- Update `pubspec.lock` / Actualizará `pubspec.lock`
- Commit the updated `pubspec.lock` / Confirmar el `pubspec.lock` actualizado

### Updating Packages / Actualizar Paquetes

```bash
# Update all packages to latest compatible versions
# Actualizar todos los paquetes a las últimas versiones compatibles
flutter pub upgrade

# Update a specific package
# Actualizar un paquete específico
flutter pub upgrade package_name
```

Always test thoroughly after upgrading packages!
¡Siempre pruebe exhaustivamente después de actualizar paquetes!

### Checking for Outdated Packages / Verificar Paquetes Desactualizados

```bash
flutter pub outdated
```

## CI/CD Integration / Integración CI/CD

The GitHub Actions workflow (`.github/workflows/blank.yml`) automatically:
El flujo de trabajo de GitHub Actions (`.github/workflows/blank.yml`) automáticamente:

1. Sets up Flutter environment / Configura el entorno Flutter
2. Runs `flutter pub get` / Ejecuta `flutter pub get`
3. Verifies `pubspec.lock` exists / Verifica que `pubspec.lock` existe
4. Runs tests with locked dependencies / Ejecuta pruebas con dependencias bloqueadas
5. Builds the application / Construye la aplicación

## Current Dependencies / Dependencias Actuales

See `pubspec.yaml` for the list of direct dependencies:
Ver `pubspec.yaml` para la lista de dependencias directas:

### Core Dependencies / Dependencias Principales
- **Firebase**: Authentication, Firestore, Storage, Remote Config
- **Flutter Stripe**: Payment processing
- **Google ML Kit**: Text recognition/OCR
- **Camera & Image Picker**: Media capture
- **Provider**: State management (MVVM)
- **FL Chart**: Data visualization
- **Geolocator**: Location services

### Development / Desarrollo
- **flutter_lints**: Code quality checks

## Troubleshooting / Solución de Problemas

### Conflict Resolution / Resolución de Conflictos

If you encounter dependency conflicts:
Si encuentra conflictos de dependencias:

```bash
# Clean and reinstall
# Limpiar y reinstalar
flutter clean
flutter pub get
```

### Cache Issues / Problemas de Caché

```bash
# Clear pub cache
# Limpiar caché de pub
flutter pub cache repair
```

## Best Practices / Mejores Prácticas

1. ✅ **Always commit** `pubspec.lock` for application projects
   **Siempre confirme** `pubspec.lock` para proyectos de aplicaciones

2. ✅ **Run tests** after updating dependencies
   **Ejecute pruebas** después de actualizar dependencias

3. ✅ **Review changes** in `pubspec.lock` before committing
   **Revise cambios** en `pubspec.lock` antes de confirmar

4. ✅ **Use specific versions** for critical dependencies
   **Use versiones específicas** para dependencias críticas

5. ✅ **Document** any manual version pinning
   **Documente** cualquier fijación manual de versiones

6. ⚠️ **Avoid** manually editing `pubspec.lock`
   **Evite** editar manualmente `pubspec.lock`

7. ⚠️ **Be cautious** with major version upgrades
   **Sea cauteloso** con actualizaciones de versiones principales

## Status / Estado

✅ **Packages are now closed/locked** (Paquetes ahora cerrados/bloqueados)
- `pubspec.lock` created and committed
- CI/CD configured to validate dependencies
- All package versions are locked and reproducible

---

For more information, see:
Para más información, consulte:
- [Dart Packages](https://dart.dev/tools/pub/packages)
- [Flutter Dependencies](https://docs.flutter.dev/development/packages-and-plugins/using-packages)
