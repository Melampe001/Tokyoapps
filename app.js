// Tokyo Roulette Predictor - Main Application Logic

let rouletteType = 'european';
let history = [];
let numberFrequency = {};
let martingaleBase = 1;
let currentMartingale = 1;
let lastWin = true;

// Configuración de ruletas
const europeanWheel = Array.from({length: 37}, (_, i) => i); // 0-36
const americanWheel = [0, ...Array.from({length: 36}, (_, i) => i + 1), '00']; // 0, 1-36, 00

// Colores en la ruleta (europea/americana estándar)
const redNumbers = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36];
const blackNumbers = [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35];

// Inicializar la aplicación
function init() {
    loadFromLocalStorage();
    updateDisplay();
    
    // Registrar Service Worker para PWA
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('sw.js')
            .then(reg => console.log('Service Worker registrado'))
            .catch(err => console.log('Error al registrar Service Worker:', err));
    }
}

// Cambiar tipo de ruleta
function setRouletteType(type) {
    rouletteType = type;
    document.getElementById('btnEuropean').classList.toggle('active', type === 'european');
    document.getElementById('btnAmerican').classList.toggle('active', type === 'american');
    
    // Reiniciar historial al cambiar tipo
    if (confirm('¿Deseas limpiar el historial al cambiar de ruleta?')) {
        clearHistory();
    }
}

// Generar número aleatorio usando crypto para mayor seguridad
function generateSecureRandom(max) {
    const array = new Uint32Array(1);
    crypto.getRandomValues(array);
    return array[0] % max;
}

// Girar la ruleta
function spinRoulette() {
    const wheel = rouletteType === 'european' ? europeanWheel : americanWheel;
    const index = generateSecureRandom(wheel.length);
    const result = wheel[index];
    
    // Actualizar historial
    history.unshift(result);
    if (history.length > 100) {
        history = history.slice(0, 100); // Mantener solo últimos 100
    }
    
    // Actualizar frecuencias
    updateFrequency(result);
    
    // Actualizar Martingale
    updateMartingale(result);
    
    // Guardar en localStorage
    saveToLocalStorage();
    
    // Actualizar display con animación
    animateResult(result);
}

// Actualizar frecuencias de números
function updateFrequency(number) {
    const key = String(number);
    numberFrequency[key] = (numberFrequency[key] || 0) + 1;
}

// Actualizar estrategia Martingale
function updateMartingale(result) {
    // Simplificado: considera victoria si sale rojo
    const win = redNumbers.includes(Number(result));
    
    if (win) {
        currentMartingale = martingaleBase;
        lastWin = true;
    } else {
        currentMartingale *= 2;
        lastWin = false;
    }
}

// Animar resultado
function animateResult(result) {
    const resultElement = document.getElementById('resultNumber');
    const colorElement = document.getElementById('resultColor');
    
    // Animación de conteo rápido
    let count = 0;
    const interval = setInterval(() => {
        const wheel = rouletteType === 'european' ? europeanWheel : americanWheel;
        resultElement.textContent = wheel[count % wheel.length];
        count++;
    }, 50);
    
    setTimeout(() => {
        clearInterval(interval);
        resultElement.textContent = result;
        
        // Determinar color
        const numResult = Number(result);
        let color = 'Verde (0)';
        let colorStyle = '#00ff00';
        
        if (result === '00') {
            color = 'Verde (00)';
            colorStyle = '#00ff00';
        } else if (redNumbers.includes(numResult)) {
            color = 'Rojo';
            colorStyle = '#ff0000';
        } else if (blackNumbers.includes(numResult)) {
            color = 'Negro';
            colorStyle = '#000000';
        }
        
        colorElement.textContent = color;
        colorElement.style.color = colorStyle;
        resultElement.style.color = colorStyle;
        
        // Actualizar todo el display
        updateDisplay();
    }, 1500);
}

// Actualizar todo el display
function updateDisplay() {
    updatePredictions();
    updateHotColdNumbers();
    updateHistoryDisplay();
}

// Actualizar predicciones
function updatePredictions() {
    if (history.length < 5) {
        document.getElementById('nextPrediction').textContent = 'Necesitas más giros';
        document.getElementById('probability').textContent = 'N/A';
        document.getElementById('martingale').textContent = `Apuesta: $${currentMartingale}`;
        return;
    }
    
    // Predicción basada en números calientes
    const hotNumbers = getHotNumbers(5);
    const prediction = hotNumbers[0] || '-';
    
    // Calcular probabilidad
    const totalSpins = history.length;
    const frequency = numberFrequency[String(prediction)] || 0;
    const probability = ((frequency / totalSpins) * 100).toFixed(1);
    
    document.getElementById('nextPrediction').textContent = prediction;
    document.getElementById('probability').textContent = `${probability}%`;
    document.getElementById('martingale').textContent = `Apuesta: $${currentMartingale}`;
}

// Obtener números calientes
function getHotNumbers(count) {
    const sorted = Object.entries(numberFrequency)
        .sort((a, b) => b[1] - a[1])
        .slice(0, count)
        .map(entry => entry[0]);
    return sorted;
}

// Obtener números fríos
function getColdNumbers(count) {
    const wheel = rouletteType === 'european' ? europeanWheel : americanWheel;
    const allNumbers = wheel.map(n => String(n));
    
    // Números que no han salido o han salido poco
    const coldNums = allNumbers
        .map(num => ({num, freq: numberFrequency[num] || 0}))
        .sort((a, b) => a.freq - b.freq)
        .slice(0, count)
        .map(item => item.num);
    
    return coldNums;
}

// Actualizar números calientes y fríos
function updateHotColdNumbers() {
    const hotNumbers = getHotNumbers(8);
    const coldNumbers = getColdNumbers(8);
    
    const hotContainer = document.getElementById('hotNumbers');
    const coldContainer = document.getElementById('coldNumbers');
    
    hotContainer.innerHTML = hotNumbers.map(num => 
        `<span class="number-badge hot">${num}</span>`
    ).join('');
    
    coldContainer.innerHTML = coldNumbers.map(num => 
        `<span class="number-badge cold">${num}</span>`
    ).join('');
}

// Actualizar display de historial
function updateHistoryDisplay() {
    const historyContainer = document.getElementById('history');
    
    if (history.length === 0) {
        historyContainer.innerHTML = '<p style="opacity: 0.5;">No hay giros aún...</p>';
        return;
    }
    
    historyContainer.innerHTML = history.slice(0, 20).map(num => {
        const numVal = Number(num);
        let className = '';
        
        if (num === '00') {
            className = 'hot';
        } else if (redNumbers.includes(numVal)) {
            className = 'hot';
        } else if (blackNumbers.includes(numVal)) {
            className = 'cold';
        }
        
        return `<span class="history-item ${className}">${num}</span>`;
    }).join('');
}

// Limpiar historial
function clearHistory() {
    if (history.length === 0 || confirm('¿Estás seguro de limpiar todo el historial?')) {
        history = [];
        numberFrequency = {};
        currentMartingale = martingaleBase;
        lastWin = true;
        saveToLocalStorage();
        updateDisplay();
    }
}

// Auto spin
function autoSpin() {
    let count = 0;
    const interval = setInterval(() => {
        spinRoulette();
        count++;
        
        if (count >= 5) {
            clearInterval(interval);
        }
    }, 2000);
}

// Guardar en localStorage
function saveToLocalStorage() {
    try {
        localStorage.setItem('rouletteHistory', JSON.stringify(history));
        localStorage.setItem('rouletteFrequency', JSON.stringify(numberFrequency));
        localStorage.setItem('rouletteType', rouletteType);
        localStorage.setItem('martingale', currentMartingale);
    } catch (e) {
        console.error('Error guardando en localStorage:', e);
    }
}

// Cargar desde localStorage
function loadFromLocalStorage() {
    try {
        const savedHistory = localStorage.getItem('rouletteHistory');
        const savedFrequency = localStorage.getItem('rouletteFrequency');
        const savedType = localStorage.getItem('rouletteType');
        const savedMartingale = localStorage.getItem('martingale');
        
        if (savedHistory) history = JSON.parse(savedHistory);
        if (savedFrequency) numberFrequency = JSON.parse(savedFrequency);
        if (savedType) {
            rouletteType = savedType;
            setRouletteType(savedType);
        }
        if (savedMartingale) currentMartingale = Number(savedMartingale);
    } catch (e) {
        console.error('Error cargando desde localStorage:', e);
    }
}

// Inicializar cuando carga la página
window.addEventListener('DOMContentLoaded', init);
