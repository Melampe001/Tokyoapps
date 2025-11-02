# 🚀 Guía de Despliegue - Tokyo Roulette Predictor

## Estado Actual

✅ **Aplicación completa y lista para producción**

### Lo que se ha creado:

1. **Aplicación Web Funcional**
   - `index.html` - Interfaz de usuario completa
   - `app.js` - Lógica de simulación y predicción
   - `sw.js` - Service Worker para PWA
   - `manifest.json` - Manifiesto de aplicación web

2. **Recursos**
   - Iconos PNG (192x192, 512x512, favicon)
   - SVG fuente para iconos
   - Estilos integrados (glassmorphism)

3. **Infraestructura**
   - GitHub Actions para despliegue automático
   - Configuración de GitHub Pages
   - package.json con scripts npm

## 📋 Pasos para Despliegue

### 1. Habilitar GitHub Pages

1. Ve a tu repositorio: https://github.com/Melampe001/Tokyoapps
2. Click en **Settings** (Configuración)
3. En el menú lateral, click en **Pages**
4. En "Build and deployment":
   - **Source**: selecciona "GitHub Actions"
5. Guarda los cambios

### 2. Hacer Merge del Pull Request

1. Ve a la pestaña **Pull Requests**
2. Abre el PR "Create complete Tokyo Roulette Predictor PWA application"
3. Click en **Merge pull request**
4. Confirma el merge

### 3. Esperar el Despliegue Automático

El workflow de GitHub Actions se ejecutará automáticamente:
- Ve a la pestaña **Actions**
- Verás el workflow "Deploy to GitHub Pages" en ejecución
- Espera a que se complete (≈ 2-3 minutos)

### 4. Verificar la Aplicación

Una vez completado el despliegue:
- URL: **https://melampe001.github.io/Tokyoapps/**
- Debería mostrar la aplicación de ruleta funcionando
- Prueba las funcionalidades:
  - ✅ Girar ruleta
  - ✅ Cambiar entre europea/americana
  - ✅ Ver predicciones
  - ✅ Historial
  - ✅ Auto spin

## 📱 Instalar como PWA

### En Android:
1. Abre la URL en Chrome
2. Aparecerá banner "Agregar a pantalla de inicio"
3. O menú > "Agregar a pantalla de inicio"

### En iOS:
1. Abre la URL en Safari
2. Toca botón "Compartir" (cuadrado con flecha)
3. "Agregar a pantalla de inicio"

### En Desktop (Chrome/Edge):
1. Abre la URL
2. Mira el icono de instalación en la barra de direcciones
3. O menú > "Instalar Tokyo Roulette Predictor"

## 📦 Crear APK para Android

### Opción 1: PWABuilder (Recomendado)

1. Ve a https://www.pwabuilder.com/
2. Ingresa: `https://melampe001.github.io/Tokyoapps/`
3. Click "Start"
4. Espera el análisis
5. Click en "Package For Stores"
6. Selecciona "Android"
7. Click "Generate"
8. Descarga el APK

### Opción 2: Bubblewrap (CLI)

```bash
npm install -g @bubblewrap/cli
bubblewrap init --manifest=https://melampe001.github.io/Tokyoapps/manifest.json
bubblewrap build
```

## 🔧 Desarrollo Local

```bash
# Clonar (si no lo tienes)
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps

# Instalar dependencias
npm install

# Servidor local
npm start
# Abre http://localhost:8080

# O simplemente abre index.html en un navegador
```

## ✅ Checklist de Verificación Post-Despliegue

- [ ] La URL principal carga correctamente
- [ ] La ruleta gira y muestra números
- [ ] Se puede cambiar entre europea/americana
- [ ] Las predicciones funcionan
- [ ] El historial se guarda
- [ ] Los iconos se muestran correctamente
- [ ] Se puede instalar como PWA
- [ ] Funciona offline (después de primera visita)

## 🐛 Solución de Problemas

### La página no carga
- Verifica que GitHub Pages esté habilitado
- Revisa que el workflow haya completado sin errores
- Espera 5-10 minutos para propagación

### Los iconos no se muestran
- Los archivos PNG están en el repositorio
- Verifica que manifest.json apunte correctamente
- Limpia caché del navegador

### PWA no se instala
- Requiere HTTPS (GitHub Pages lo tiene)
- El navegador debe soportar PWA
- manifest.json debe ser válido

## 📊 Monitoreo

### Ver estadísticas de uso:
- Settings > Insights > Traffic
- Ver visitantes y páginas vistas

### Ver logs de despliegue:
- Actions > Seleccionar workflow
- Ver detalles de cada step

## 🔄 Actualizar la Aplicación

1. Hacer cambios en el código
2. Commit y push a `main`
3. GitHub Actions desplegará automáticamente
4. La nueva versión estará disponible en minutos

## 📞 Soporte

Si tienes problemas:
1. Revisa los logs en Actions
2. Verifica la configuración de GitHub Pages
3. Abre un issue en el repositorio

---

**Última actualización:** 2 de Noviembre, 2025
**Estado:** ✅ Listo para producción
