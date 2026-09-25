# Lion Flowers

Primera versión móvil de una tienda local de arreglos florales, desarrollada con Flutter y Dart.

## Ejecutar

Desde la raíz del proyecto:

```powershell
flutter pub get
flutter run
```

## Validar

```powershell
flutter test
flutter analyze
```

## Funciones

- Splash screen con el nombre Lion Flowers durante dos segundos.
- Catálogo desplazable de diez arreglos, con búsqueda y filtro por categoría.
- Secciones de Inicio, Categorías, Favoritos y Perfil en la navegación inferior.
- Acciones de favoritos y bolsa con confirmación mediante SnackBar.

## Organización

- `lib/models`: modelo de producto floral.
- `lib/data`: catálogo y categorías iniciales.
- `lib/screens`: bienvenida y pantallas principales.
- `lib/widgets`: componentes reutilizables del catálogo.
- `lib/theme`: colores y tema de la aplicación.
- `test`: pruebas de los flujos principales.