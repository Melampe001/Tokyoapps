# 🎰 Tokyo Roulette Predictor

Una aplicación web progresiva (PWA) para simular y predecir resultados de ruleta europea y americana.

## 🚀 Características

- ✅ Simulador de ruleta europea (0-36) y americana (0-00-36)
- 📊 Análisis de números calientes y fríos
- 🎯 Predicciones basadas en historial
- 💰 Asesor de estrategia Martingale
- 📱 PWA instalable en dispositivos móviles
- 💾 Almacenamiento local del historial
- ⚡ Interfaz rápida y responsive

## 📦 Instalación y Uso

### Opción 1: Usar en línea
Visita: [https://melampe001.github.io/Tokyoapps/](https://melampe001.github.io/Tokyoapps/)

### Opción 2: Instalar como PWA
1. Abre la aplicación en tu navegador móvil
2. Busca la opción "Agregar a pantalla de inicio" o "Instalar app"
3. La app se instalará y podrás usarla como una aplicación nativa

### Opción 3: Desarrollo local
```bash
# Clonar el repositorio
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps

# Instalar dependencias (opcional, solo para servidor local)
npm install

# Iniciar servidor de desarrollo
npm start

# O simplemente abrir index.html en tu navegador
```

## 🛠️ Tecnologías Utilizadas

- HTML5
- CSS3 (con efectos de glassmorphism)
- JavaScript vanilla (ES6+)
- Web Crypto API para generación segura de números aleatorios
- Service Workers para funcionalidad PWA
- LocalStorage para persistencia de datos

## 📱 Compatibilidad

- ✅ Chrome/Edge (Desktop y Mobile)
- ✅ Firefox (Desktop y Mobile)
- ✅ Safari (Desktop y Mobile)
- ✅ Opera
- ✅ Samsung Internet

## 🎮 Cómo Usar

1. **Seleccionar tipo de ruleta**: Elige entre ruleta europea o americana
2. **Girar la ruleta**: Haz clic en "Girar Ruleta" para generar un resultado
3. **Ver predicciones**: Observa los números calientes, fríos y predicciones
4. **Historial**: Revisa los últimos 20 giros en el panel de historial
5. **Auto Spin**: Usa la función de auto spin para simular 5 giros rápidos

## 📊 Características Avanzadas

### Números Calientes y Fríos
- **Calientes**: Números que han salido con mayor frecuencia
- **Fríos**: Números que han salido con menor frecuencia

### Estrategia Martingale
La app sugiere apuestas siguiendo la estrategia Martingale:
- Duplica la apuesta después de cada pérdida
- Vuelve a la apuesta base después de una victoria

### Predicciones
Las predicciones se basan en análisis estadístico del historial de giros.
**Nota**: Las ruletas usan RNG (generadores de números aleatorios) verdaderos, 
por lo que ninguna predicción puede garantizar resultados.

## 🔒 Privacidad y Seguridad

- Toda la información se almacena localmente en tu dispositivo
- No se recopilan ni envían datos a servidores externos
- Usa Web Crypto API para generación criptográficamente segura de números

## 📝 Licencia

MIT License - Ver archivo LICENSE para más detalles

## 👤 Autor

**Melampe001**
- GitHub: [@Melampe001](https://github.com/Melampe001)

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## ⚠️ Descargo de Responsabilidad

Esta aplicación es solo para fines educativos y de entretenimiento. 
El juego debe ser responsable. No garantizamos resultados y no nos 
hacemos responsables de pérdidas financieras.

---

🎲 ¡Diviértete y juega con responsabilidad! 🎰
