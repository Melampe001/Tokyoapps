# 🎰 Tokyo Apps - Roulette Predictor

[![Deploy to GitHub Pages](https://github.com/Melampe001/Tokyoapps/actions/workflows/blank.yml/badge.svg)](https://github.com/Melampe001/Tokyoapps/actions/workflows/blank.yml)

**Aplicación web progresiva para simulación y predicción de ruleta europea y americana.**

## 🚀 Acceso Rápido

### 🌐 Usar Online
👉 **[https://melampe001.github.io/Tokyoapps/](https://melampe001.github.io/Tokyoapps/)**

### 📱 Instalar como App Móvil
1. Abre el link anterior en tu móvil
2. Busca la opción "Agregar a pantalla de inicio"
3. ¡Listo! Úsala como una app nativa

## ✨ Características

- 🎲 Simulador de ruleta europea (0-36) y americana (0-00-36)
- 📊 Análisis de números calientes y fríos
- 🎯 Predicciones basadas en historial estadístico
- 💰 Asesor de estrategia Martingale
- 📱 PWA - Instalable como aplicación nativa
- 💾 Historial persistente (localStorage)
- ⚡ Sin necesidad de servidor - 100% cliente
- 🔒 Privado - Todo se almacena localmente

## 📦 Uso Local

```bash
# Clonar repositorio
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps

# Opción 1: Abrir directamente
# Abrir index.html en tu navegador

# Opción 2: Con servidor local
npm install
npm start
# Abrir http://localhost:8080
```

## 🛠️ Tecnologías

- HTML5 + CSS3 (Glassmorphism design)
- JavaScript Vanilla (ES6+)
- Web Crypto API (RNG seguro)
- Service Workers (PWA)
- LocalStorage (persistencia)

## 📱 Empaquetado para Móviles

### Android (APK)
Usa [PWABuilder](https://www.pwabuilder.com/):
1. Ve a https://www.pwabuilder.com/
2. Ingresa: `https://melampe001.github.io/Tokyoapps/`
3. Genera APK para Android

### iOS
La app es instalable directamente desde Safari:
1. Abre la app en Safari
2. Toca el botón "Compartir"
3. Selecciona "Agregar a pantalla de inicio"

## 📚 Documentación

- [APP_README.md](./APP_README.md) - Guía completa de la aplicación
- [NOTES.md](./NOTES.md) - Notas de desarrollo y código de referencia

## 📁 Estructura del Proyecto

```
Tokyoapps/
├── index.html          # Página principal
├── app.js             # Lógica de la aplicación
├── sw.js              # Service Worker (PWA)
├── manifest.json      # Manifiesto PWA
├── package.json       # Dependencias npm
├── icon-*.png         # Iconos de la app
├── .github/
│   └── workflows/
│       └── blank.yml  # CI/CD para GitHub Pages
└── assets/
    └── ruleta 001/    # Assets adicionales
```

## 🎮 Cómo Jugar

1. **Selecciona** tipo de ruleta (europea o americana)
2. **Gira** la ruleta con el botón
3. **Observa** las predicciones y números calientes/fríos
4. **Revisa** el historial de giros
5. **Usa** la función Auto Spin para simular múltiples giros

## ⚠️ Importante

Esta aplicación es **solo para entretenimiento y educación**. Las ruletas reales usan RNG (Random Number Generators) verdaderos que son impredecibles por diseño. Ninguna predicción puede garantizar resultados.

🎲 **Juega con responsabilidad**

## 🤝 Contribuir

¡Las contribuciones son bienvenidas!

1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

MIT License - Ver [LICENSE](LICENSE) para más detalles

## 👤 Autor

**Melampe001**
- GitHub: [@Melampe001](https://github.com/Melampe001)

---

Hecho con ❤️ por Melampe001 | 2025
