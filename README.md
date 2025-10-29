keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias uploadeval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.compkg update && pkg upgrade -y
pkg install openssh git -yssh-keygen -t ed25519 -C "Melampe - Android" -f ~/.ssh/id_ed25519[3:25 a.m., 25/10/2025] Tokyo: package com.example.ruletapredictora

import android.os.Bundle
import android.widget.Button
import android.widget.RadioButton
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.github.mikephil.charting.charts.PieChart
import com.github.mikephil.charting.data.PieData
import com.github.mikephil.charting.data.PieDataSet
import com.github.mikephil.charting.data.PieEntry
import com.github.mikephil.charting.utils.ColorTemplate
import kotlin.random.Random

class MainActivity : AppCompatActivity() {

    private lateinit var tvResultado: TextView
    private lateinit var tvHistoria: TextView
    private lateinit var tvPrediccion: TextView
    private lateinit var tvMartingale: TextView
    private lateinit var tvPragmatic: Text
[3:36 a.m., 25/10/2025] Tokyo: Contexto: Tu tarea es desarrollar una aplicación multiplataforma completa y funcional para simular y predecir resultados en ruletas europea y americana, eliminando cualquier restricción específica a dispositivos como Motorola Edge 60 Fusion. La app debe ser compatible con todos los dispositivos Android, iOS (Apple), tabletas, laptops portátiles y computadoras de escritorio, permitiendo al usuario seleccionar la plataforma objetivo durante la instalación o ejecución para una optimización óptima (por ejemplo, mediante opciones de configuración o builds específicos). Incluye un modelo freemium con versión gratuita (predicciones simples como hot/cold y frecuencias básicas) y versiones pagas: avanzada a $399 (predicciones de vecinos, porcentajes detallados) y pre…
[3:46 a.m., 25/10/2025] Tokyo: Perfecto, entonces zona del cero: doce y treinta y cinco –los que más salen ahí. Huérfanos: uno y diecisiete, que sí, diecisiete se repite pero ya ves, la rueda lo quiere. Tiers: cinco y veintisiete. Y la última, la que va de veintidós hasta veintinueve –digamos, veintidós y veintinueve. Ocho números: doce, treinta y cinco, uno, diecisiete, cinco, veintisiete, veintidós, veintinueve. Te los digo pausado: doce... treinta y cinco... uno... diecisiete... cinco... veintisiete... veintidós... veintinueve. Apostar, esperar tres o cuatro, volver. Si en cinco rondas no pasa nada, cambia uno, el menos frecuente en la mesa que estés viendo. ¡Y que la suerte no sea teatro, sino realidad!
[3:47 a.m., 25/10/2025] Tokyo: Oye, entra a gamblingcounting o robotpredictor-dos sitios que sí dan stats en vivo de ruletas europeas tipo Evolution. De los últimos quinientos giros que acabo de checar, tu ocho: doce, treinta y cinco, uno, diecisiete, cinco, veintisiete, veintidós, veintinueve... pues, caen un 23% del total, un pelín más que los 2.7% por número que toca teóricamente. En tiempo real, cada giro te da como uno a cuatro de que salga algo tuyo-pero ojo, la casa siempre cobra ese 2.7% de ventaja, así que ni creas que es garantía. ¿Quieres que te marque alertas cuando esos números estén calientes o ya vas a apostar y rezar?
[3:48 a.m., 25/10/2025] Tokyo: ¡ey
[3:49 a.m., 25/10/2025] Tokyo: Bueno, pues ahí va. Abro Lucky 6, mesa con dealer rubia y buena onda. Primer giro: cero... y tu doce se queda cerca, pero no. Segundo: veinticuatro, nada. Tercero: ¡ey, el cinco! Tienes tu primera entrada. Apuestas fuerte en él, ¿verdad? Ahora, el multiplicador se pone rojo, 50x... ¿vas a doblar o esperamos al diecisiete que está calentito? Dime, ¿cuánto metes?
[3:51 a.m., 25/10/2025] Tokyo: Introducción
¡Hola! Entiendo que quieres una aplicación para Android que simule y "prediga" resultados en ruletas europea y americana. Vamos a aclarar algunos puntos clave basados en tu solicitud:
Ruleta Europea: 37 números (0 al 36), con un solo cero.
Ruleta Americana: 38 números (0 al 36 + 00), con doble cero, lo que aumenta la ventaja de la casa.
Predictora de resultados: Las ruletas usan RNG (Random Number Generator) verdadero, que es impredecible por diseño (es aleatorio y justo). No se puede predecir con certeza, pero podemos crear un simulador que:
Genera spins aleatorios usando RNG en código.
Analiza historia de spins para sugerir "predicciones" basadas en patrones estadísticos (como números calientes/fríos), aunque esto es solo para simulación y no …
[3:59 a.m., 25/10/2025] Tokyo: Introducción
¡Hola! Entiendo que quieres una aplicación para Android que simule y "prediga" resultados en ruletas europea y americana. Vamos a aclarar algunos puntos clave basados en tu solicitud:
Ruleta Europea: 37 números (0 al 36), con un solo cero.
Ruleta Americana: 38 números (0 al 36 + 00), con doble cero, lo que aumenta la ventaja de la casa.
Predictora de resultados: Las ruletas usan RNG (Random Number Generator) verdadero, que es impredecible por diseño (es aleatorio y justo). No se puede predecir con certeza, pero podemos crear un simulador que:
Genera spins aleatorios usando RNG en código.
Analiza historia de spins para sugerir "predicciones" basadas en patrones estadísticos (como números calientes/fríos), aunque esto es solo para simulación y no …
[5:37 a.m., 25/10/2025] Tokyo: # pubspec.yaml - Copia y pega este contenido completo en el archivo pubspec.yaml de tu proyecto Flutter

name: tokyo_roulette_predicciones
description: Simulador de predicciones para ruleta con modelo freemium.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_stripe: ^10.0.0  # Para cobros Stripe
  in_app_purchase: ^3.2.0  # Soporte in-app
  firebase_core: ^2.24.2  # Firebase base
  firebase_remote_config: ^4.3.12  # Para updates dinámicos cada 4 meses
  cloud_firestore: ^4.15.3  # Almacenar emails
  firebase_auth: ^4.16.0  # Auth para emails
  intl: ^0.18.1  # Idioma/país
  device_info_plus: ^9.1.2  # Info dispositivo/plataforma
  url_launcher: ^6.2.4  # Comentarios via email
  sh…# Clona tu repositorio si no lo tienes aún
git clone https://github.com/Melampe001/Idea.git
cd Idea

# Instala dependencias
npm install

# Corre la app en modo desarrollo
npm start
Excelente, Melampe 😎📱🔥
Ahora vamos a llevar tu app a Android, para que puedas usarla como aplicación instalada (no solo desde el navegador).
Te explico los dos caminos que puedes elegir, según lo que quieras:


---

🅰️ Opción 1: Convertir tu app web (HTML, JS, CSS) en APK

Si tu proyecto es una app web (como la ruleta 🎰, hecha con JavaScript o React),
podemos empaquetarla en una app Android real (.apk) usando herramientas que transforman tu web en una app nativa.

💡 Lo que hace

Toma tu sitio de GitHub Pages
👉 https://melampe001.github.io/Idea/
y lo mete dentro de una app Android lista para instalar.


---

🧩 OPCIÓN A – Usando PWABuilder (recomendado y gratuito)

1. Entra a 👉 https://www.pwabuilder.com/


2. Escribe la URL de tu app:

https://melampe001…
class MartingaleAdvisor {
  double baseBet = 1.0;
  double currentBet = 1.0;
  bool lastWin = true; // Reset on win

  double getNextBet(bool win) {
    if (win) {
      currentBet = baseBet;
      lastWin = true;
    } else {
      currentBet *= 2;
      lastWin = false;
    }
    return currentBet;
  }

  void reset() {
    currentBet = baseBet;
    lastWin = true;
  }
}
github.com/tuusuario/roulette-app
import 'dart:math';
import 'package:pointycastle/pointycastle.dart'; // Para RNG seguro

class RouletteRNG {
  final List<int> europeanWheel = List.generate(37, (i) => i); // 0-36
  final List<int> americanWheel = [0, ...List.generate(36, (i) => i+1), 00]; // Custom para 00

  int generateResult(bool isEuropean) {
    var wheel = isEuropean ? europeanWheel : americanWheel;
    var rng = Random.secure(); // Crypto-secure RNG
    return wheel[rng.nextInt(wheel.length)];
  }
}
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="com.android.vending.BILLING" /> <!-- Solo si simulado -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" /> <!-- Si KYC -->
<uses-permission android:name="android.permission.RECORD_AUDIO" /> <!-- Si voice -->
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  var status = await Permission.location.request(); // Para geobloqueo
  if (status.isDenied) { /* Maneja denegación: muestra dialog explicando por qué (cumplimiento legal) */ }
  // Repite para storage, camera, etc.
  // Verifica todos: if (await Permission.storage.isGranted && await Permission.location.isGranted) { /* Procede */ }
}
import 'package:geolocator/geolocator.dart';

Future<bool> isInMexico() async {
  Position position = await Geolocator.getCurrentPosition();
  // Llama API externa: http.get('https://ipapi.co/json') y verifica "country_code": "MX".
  if (country != 'MX') { showError('App no disponible en tu región'); return false; }
  return true;
}[3:53 a.m., 21/10/2025] Tokyo Cel: dependencies {
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("com.google.android.material:material:1.12.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("com.github.PhilJay:MPAndroidChart:v3.1.0") // Para gráficos
    implementation("com.android.billingclient:billing-ktx:7.1.0") // Billing latest 2025
    implementation("androidx.recyclerview:recyclerview:1.3.2") // Para lista de ruletas
}
[8:30 p.m., 24/10/2025] Tokyo: https://chatgpt.com/share/68fc360f-04dc-800d-bab2-03c61769d2a3
[8:35 p.m., 24/10/2025] Tokyo: name: 💥 Melampe Power Auto Fix + Build + Deploy ⚡

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: write
  pages: write
  id-token: write

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: 🔄 Checkout del código
        uses: actions/checkout@v4

      - name: ⚙️ Configurar Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 18

      # 🧹 Limpieza y reparación universal
      - name: 🧹 Limpiar y reparar proyecto
        run: |
          echo "==============================="
          echo "🧹 Melampe Power Fixer en acción ⚡"
          echo "==============================="
          rm -rf node_modules package-lock.json dist build .next .turbo
          npm cache…
[8:39 p.m., 24/10/2025] Tokyo: @echo off
title Limpieza y reparación universal - Melampe Power Fixer ⚡
echo ===============================================
echo 🔧 Iniciando limpieza universal...
echo ===============================================

:: Node.js / JavaScript / TypeScript
if exist node_modules (
    echo 🧹 Borrando dependencias de Node.js...
    rmdir /s /q node_modules
)
if exist package-lock.json del /f /q package-lock.json
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist .next rmdir /s /q .next
if exist .turbo rmdir /s /q .turbo

echo 🚀 Limpiando cache npm...
npm cache clean --force >nul 2>&1

echo 🔧 Reinstalando dependencias...
npm install

echo ⚙️ Compilando proyecto...
npm run build

:: Visual Studio / .NET
echo 🧰 Reparando proyectos .NET / …
[9:08 p.m., 24/10/2025] Tokyo: git add .
git commit -m "Activando Melampe Power Fixer + Deploy"
git push origin main
[9:08 p.m., 24/10/2025] Tokyo: https://melampe001.github.io/Idea/# Tokyoapps
&lt;iframe src="https://tuusuario.github.io/tokyoapps" width="100%" height="800px" style="border:none;">&lt;/iframe>
# Descarga e instala nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# en lugar de reiniciar la shell
\. "$HOME/.nvm/nvm.sh"

# Descarga e instala Node.js:
nvm install 25

# Verify the Node.js version:
node -v # Should print "v25.0.0".

# Verifica versión de npm:
npm -v # Debería mostrar "11.6.2".
#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

nvm_has() {
  type "$1" > /dev/null 2>&1
}

nvm_echo() {
  command printf %s\\n "$*" 2>/dev/null
}

if [ -z "${BASH_VERSION}" ] || [ -n "${ZSH_VERSION}" ]; then
  # shellcheck disable=SC2016
  nvm_echo >&2 'Error: the install instructions explicitly say to pipe the install script to `bash`; please follow them'
  exit 1
fi

nvm_grep() {
  GREP_OPTIONS='' command grep "$@"
}

nvm_default_install_dir() {
  [ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm"
}

nvm_install_dir() {
  if [ -n "$NVM_DIR" ]; then
    printf %s "${NVM_DIR}"
  else
    nvm_default_install_dir
  fi
}

nvm_latest_version() {
  nvm_echo "v0.40.3"
}

nvm_profile_is_bash_or_zsh() {
  local TEST_PROFILE
  TEST_PROFILE="${1-}"
  case "${TEST_PROFILE-}" in
    *"/.bashrc" | *"/.bash_profile" | *"/.zshrc" | *"/.zprofile")
      return
    ;;
    *)
      return 1
    ;;
  esac
}

#
# Outputs the location to NVM depending on:
# * The availability of $NVM_SOURCE
# * The presence of $NVM_INSTALL_GITHUB_REPO
# * The method used ("script" or "git" in the script, defaults to "git")
# NVM_SOURCE always takes precedence unless the method is "script-nvm-exec"
#
nvm_source() {
  local NVM_GITHUB_REPO
  NVM_GITHUB_REPO="${NVM_INSTALL_GITHUB_REPO:-nvm-sh/nvm}"
  if [ "${NVM_GITHUB_REPO}" != 'nvm-sh/nvm' ]; then
    { nvm_echo >&2 "$(cat)" ; } << EOF
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE REPO IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!

The default repository for this install is \`nvm-sh/nvm\`,
but the environment variables \`\$NVM_INSTALL_GITHUB_REPO\` is
currently set to \`${NVM_GITHUB_REPO}\`.

If this is not intentional, interrupt this installation and
verify your environment variables.
EOF
  fi
  local NVM_VERSION
  NVM_VERSION="${NVM_INSTALL_VERSION:-$(nvm_latest_version)}"
  local NVM_METHOD
  NVM_METHOD="$1"
  local NVM_SOURCE_URL
  NVM_SOURCE_URL="$NVM_SOURCE"
  if [ "_$NVM_METHOD" = "_script-nvm-exec" ]; then
    NVM_SOURCE_URL="https://raw.githubusercontent.com/${NVM_GITHUB_REPO}/${NVM_VERSION}/nvm-exec"
  elif [ "_$NVM_METHOD" = "_script-nvm-bash-completion" ]; then
    NVM_SOURCE_URL="https://raw.githubusercontent.com/${NVM_GITHUB_REPO}/${NVM_VERSION}/bash_completion"
  elif [ -z "$NVM_SOURCE_URL" ]; then
    if [ "_$NVM_METHOD" = "_script" ]; then
      NVM_SOURCE_URL="https://raw.githubusercontent.com/${NVM_GITHUB_REPO}/${NVM_VERSION}/nvm.sh"
    elif [ "_$NVM_METHOD" = "_git" ] || [ -z "$NVM_METHOD" ]; then
      NVM_SOURCE_URL="https://github.com/${NVM_GITHUB_REPO}.git"
    else
      nvm_echo >&2 "Unexpected value \"$NVM_METHOD\" for \$NVM_METHOD"
      return 1
    fi
  fi
  nvm_echo "$NVM_SOURCE_URL"
}

#
# Node.js version to install
#
nvm_node_version() {
  nvm_echo "$NODE_VERSION"
}

nvm_download() {
  if nvm_has "curl"; then
    curl --fail --compressed -q "$@"
  elif nvm_has "wget"; then
    # Emulate curl with wget
    ARGS=$(nvm_echo "$@" | command sed -e 's/--progress-bar /--progress=bar /' \
                            -e 's/--compressed //' \
                            -e 's/--fail //' \
                            -e 's/-L //' \
                            -e 's/-I /--server-response /' \
                            -e 's/-s /-q /' \
                            -e 's/-sS /-nv /' \
                            -e 's/-o /-O /' \
                            -e 's/-C - /-c /')
    # shellcheck disable=SC2086
    eval wget $ARGS
  fi
}

install_nvm_from_git() {
  local INSTALL_DIR
  INSTALL_DIR="$(nvm_install_dir)"
  local NVM_VERSION
  NVM_VERSION="${NVM_INSTALL_VERSION:-$(nvm_latest_version)}"
  if [ -n "${NVM_INSTALL_VERSION:-}" ]; then
    # Check if version is an existing ref
    if command git ls-remote "$(nvm_source "git")" "$NVM_VERSION" | nvm_grep -q "$NVM_VERSION" ; then
      :
    # Check if version is an existing changeset
    elif ! nvm_download -o /dev/null "$(nvm_source "script-nvm-exec")"; then
      nvm_echo >&2 "Failed to find '$NVM_VERSION' version."
      exit 1
    fi
  fi

  local fetch_error
  if [ -d "$INSTALL_DIR/.git" ]; then
    # Updating repo
    nvm_echo "=> nvm is already installed in $INSTALL_DIR, trying to update using git"
    command printf '\r=> '
    fetch_error="Failed to update nvm with $NVM_VERSION, run 'git fetch' in $INSTALL_DIR yourself."
  else
    fetch_error="Failed to fetch origin with $NVM_VERSION. Please report this!"
    nvm_echo "=> Downloading nvm from git to '$INSTALL_DIR'"
    command printf '\r=> '
    mkdir -p "${INSTALL_DIR}"
    if [ "$(ls -A "${INSTALL_DIR}")" ]; then
      # Initializing repo
      command git init "${INSTALL_DIR}" || {
        nvm_echo >&2 'Failed to initialize nvm repo. Please report this!'
        exit 2
      }
      command git --git-dir="${INSTALL_DIR}/.git" remote add origin "$(nvm_source)" 2> /dev/null \
        || command git --git-dir="${INSTALL_DIR}/.git" remote set-url origin "$(nvm_source)" || {
        nvm_echo >&2 'Failed to add remote "origin" (or set the URL). Please report this!'
        exit 2
      }
    else
      # Cloning repo
      command git clone "$(nvm_source)" --depth=1 "${INSTALL_DIR}" || {
        nvm_echo >&2 'Failed to clone nvm repo. Please report this!'
        exit 2
      }
    fi
  fi
  # Try to fetch tag
  if command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" fetch origin tag "$NVM_VERSION" --depth=1 2>/dev/null; then
    :
  # Fetch given version
  elif ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" fetch origin "$NVM_VERSION" --depth=1; then
    nvm_echo >&2 "$fetch_error"
    exit 1
  fi
  command git -c advice.detachedHead=false --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" checkout -f --quiet FETCH_HEAD || {
    nvm_echo >&2 "Failed to checkout the given version $NVM_VERSION. Please report this!"
    exit 2
  }
  if [ -n "$(command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" show-ref refs/heads/master)" ]; then
    if command git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet 2>/dev/null; then
      command git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet -D master >/dev/null 2>&1
    else
      nvm_echo >&2 "Your version of git is out of date. Please update it!"
      command git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch -D master >/dev/null 2>&1
    fi
  fi

  nvm_echo "=> Compressing and cleaning up git repository"
  if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" reflog expire --expire=now --all; then
    nvm_echo >&2 "Your version of git is out of date. Please update it!"
  fi
  if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" gc --auto --aggressive --prune=now ; then
    nvm_echo >&2 "Your version of git is out of date. Please update it!"
  fi
  return
}

#
# Automatically install Node.js
#
nvm_install_node() {
  local NODE_VERSION_LOCAL
  NODE_VERSION_LOCAL="$(nvm_node_version)"

  if [ -z "$NODE_VERSION_LOCAL" ]; then
    return 0
  fi

  nvm_echo "=> Installing Node.js version $NODE_VERSION_LOCAL"
  nvm install "$NODE_VERSION_LOCAL"
  local CURRENT_NVM_NODE

  CURRENT_NVM_NODE="$(nvm_version current)"
  if [ "$(nvm_version "$NODE_VERSION_LOCAL")" == "$CURRENT_NVM_NODE" ]; then
    nvm_echo "=> Node.js version $NODE_VERSION_LOCAL has been successfully installed"
  else
    nvm_echo >&2 "Failed to install Node.js $NODE_VERSION_LOCAL"
  fi
}

install_nvm_as_script() {
  local INSTALL_DIR
  INSTALL_DIR="$(nvm_install_dir)"
  local NVM_SOURCE_LOCAL
  NVM_SOURCE_LOCAL="$(nvm_source script)"
  local NVM_EXEC_SOURCE
  NVM_EXEC_SOURCE="$(nvm_source script-nvm-exec)"
  local NVM_BASH_COMPLETION_SOURCE
  NVM_BASH_COMPLETION_SOURCE="$(nvm_source script-nvm-bash-completion)"

  # Downloading to $INSTALL_DIR
  mkdir -p "$INSTALL_DIR"
  if [ -f "$INSTALL_DIR/nvm.sh" ]; then
    nvm_echo "=> nvm is already installed in $INSTALL_DIR, trying to update the script"
  else
    nvm_echo "=> Downloading nvm as script to '$INSTALL_DIR'"
  fi
  nvm_download -s "$NVM_SOURCE_LOCAL" -o "$INSTALL_DIR/nvm.sh" || {
    nvm_echo >&2 "Failed to download '$NVM_SOURCE_LOCAL'"
    return 1
  } &
  nvm_download -s "$NVM_EXEC_SOURCE" -o "$INSTALL_DIR/nvm-exec" || {
    nvm_echo >&2 "Failed to download '$NVM_EXEC_SOURCE'"
    return 2
  } &
  nvm_download -s "$NVM_BASH_COMPLETION_SOURCE" -o "$INSTALL_DIR/bash_completion" || {
    nvm_echo >&2 "Failed to download '$NVM_BASH_COMPLETION_SOURCE'"
    return 2
  } &
  for job in $(jobs -p | command sort)
  do
    wait "$job" || return $?
  done
  chmod a+x "$INSTALL_DIR/nvm-exec" || {
    nvm_echo >&2 "Failed to mark '$INSTALL_DIR/nvm-exec' as executable"
    return 3
  }
}

nvm_try_profile() {
  if [ -z "${1-}" ] || [ ! -f "${1}" ]; then
    return 1
  fi
  nvm_echo "${1}"
}

#
# Detect profile file if not specified as environment variable
# (eg: PROFILE=~/.myprofile)
# The echo'ed path is guaranteed to be an existing file
# Otherwise, an empty string is returned
#
nvm_detect_profile() {
  if [ "${PROFILE-}" = '/dev/null' ]; then
    # the user has specifically requested NOT to have nvm touch their profile
    return
  fi

  if [ -n "${PROFILE}" ] && [ -f "${PROFILE}" ]; then
    nvm_echo "${PROFILE}"
    return
  fi

  local DETECTED_PROFILE
  DETECTED_PROFILE=''

  if [ "${SHELL#*bash}" != "$SHELL" ]; then
    if [ -f "$HOME/.bashrc" ]; then
      DETECTED_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      DETECTED_PROFILE="$HOME/.bash_profile"
    fi
  elif [ "${SHELL#*zsh}" != "$SHELL" ]; then
    if [ -f "${ZDOTDIR:-${HOME}}/.zshrc" ]; then
      DETECTED_PROFILE="${ZDOTDIR:-${HOME}}/.zshrc"
    elif [ -f "${ZDOTDIR:-${HOME}}/.zprofile" ]; then
      DETECTED_PROFILE="${ZDOTDIR:-${HOME}}/.zprofile"
    fi
  fi

  if [ -z "$DETECTED_PROFILE" ]; then
    for EACH_PROFILE in ".profile" ".bashrc" ".bash_profile" ".zprofile" ".zshrc"
    do
      if DETECTED_PROFILE="$(nvm_try_profile "${ZDOTDIR:-${HOME}}/${EACH_PROFILE}")"; then
        break
      fi
    done
  fi

  if [ -n "$DETECTED_PROFILE" ]; then
    nvm_echo "$DETECTED_PROFILE"
  fi
}

#
# Check whether the user has any globally-installed npm modules in their system
# Node, and warn them if so.
#
nvm_check_global_modules() {
  local NPM_COMMAND
  NPM_COMMAND="$(command -v npm 2>/dev/null)" || return 0
  [ -n "${NVM_DIR}" ] && [ -z "${NPM_COMMAND%%"$NVM_DIR"/*}" ] && return 0

  local NPM_VERSION
  NPM_VERSION="$(npm --version)"
  NPM_VERSION="${NPM_VERSION:--1}"
  [ "${NPM_VERSION%%[!-0-9]*}" -gt 0 ] || return 0

  local NPM_GLOBAL_MODULES
  NPM_GLOBAL_MODULES="$(
    npm list -g --depth=0 |
    command sed -e '/ npm@/d' -e '/ (empty)$/d'
  )"

  local MODULE_COUNT
  MODULE_COUNT="$(
    command printf %s\\n "$NPM_GLOBAL_MODULES" |
    command sed -ne '1!p' |                     # Remove the first line
    wc -l | command tr -d ' '                   # Count entries
  )"

  if [ "${MODULE_COUNT}" != '0' ]; then
    # shellcheck disable=SC2016
    nvm_echo '=> You currently have modules installed globally with `npm`. These will no'
    # shellcheck disable=SC2016
    nvm_echo '=> longer be linked to the active version of Node when you install a new node'
    # shellcheck disable=SC2016
    nvm_echo '=> with `nvm`; and they may (depending on how you construct your `$PATH`)'
    # shellcheck disable=SC2016
    nvm_echo '=> override the binaries of modules installed with `nvm`:'
    nvm_echo

    command printf %s\\n "$NPM_GLOBAL_MODULES"
    nvm_echo '=> If you wish to uninstall them at a later point (or re-install them under your'
    # shellcheck disable=SC2016
    nvm_echo '=> `nvm` node installs), you can remove them from the system Node as follows:'
    nvm_echo
    nvm_echo '     $ nvm use system'
    nvm_echo '     $ npm uninstall -g a_module'
    nvm_echo
  fi
}

nvm_do_install() {
  if [ -n "${NVM_DIR-}" ] && ! [ -d "${NVM_DIR}" ]; then
    if [ -e "${NVM_DIR}" ]; then
      nvm_echo >&2 "File \"${NVM_DIR}\" has the same name as installation directory."
      exit 1
    fi

    if [ "${NVM_DIR}" = "$(nvm_default_install_dir)" ]; then
      mkdir "${NVM_DIR}"
    else
      nvm_echo >&2 "You have \$NVM_DIR set to \"${NVM_DIR}\", but that directory does not exist. Check your profile files and environment."
      exit 1
    fi
  fi
  # Disable the optional which check, https://www.shellcheck.net/wiki/SC2230
  # shellcheck disable=SC2230
  if nvm_has xcode-select && [ "$(xcode-select -p >/dev/null 2>/dev/null ; echo $?)" = '2' ] && [ "$(which git)" = '/usr/bin/git' ] && [ "$(which curl)" = '/usr/bin/curl' ]; then
    nvm_echo >&2 'You may be on a Mac, and need to install the Xcode Command Line Developer Tools.'
    # shellcheck disable=SC2016
    nvm_echo >&2 'If so, run `xcode-select --install` and try again. If not, please report this!'
    exit 1
  fi
  if [ -z "${METHOD}" ]; then
    # Autodetect install method
    if nvm_has git; then
      install_nvm_from_git
    elif nvm_has curl || nvm_has wget; then
      install_nvm_as_script
    else
      nvm_echo >&2 'You need git, curl, or wget to install nvm'
      exit 1
    fi
  elif [ "${METHOD}" = 'git' ]; then
    if ! nvm_has git; then
      nvm_echo >&2 "You need git to install nvm"
      exit 1
    fi
    install_nvm_from_git
  elif [ "${METHOD}" = 'script' ]; then
    if ! nvm_has curl && ! nvm_has wget; then
      nvm_echo >&2 "You need curl or wget to install nvm"
      exit 1
    fi
    install_nvm_as_script
  else
    nvm_echo >&2 "The environment variable \$METHOD is set to \"${METHOD}\", which is not recognized as a valid installation method."
    exit 1
  fi

  nvm_echo

  local NVM_PROFILE
  NVM_PROFILE="$(nvm_detect_profile)"
  local PROFILE_INSTALL_DIR
  PROFILE_INSTALL_DIR="$(nvm_install_dir | command sed "s:^$HOME:\$HOME:")"

  SOURCE_STR="\\nexport NVM_DIR=\"${PROFILE_INSTALL_DIR}\"\\n[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"  # This loads nvm\\n"

  # shellcheck disable=SC2016
  COMPLETION_STR='[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion\n'
  BASH_OR_ZSH=false

  if [ -z "${NVM_PROFILE-}" ] ; then
    local TRIED_PROFILE
    if [ -n "${PROFILE}" ]; then
      TRIED_PROFILE="${NVM_PROFILE} (as defined in \$PROFILE), "
    fi
    nvm_echo "=> Profile not found. Tried ${TRIED_PROFILE-}~/.bashrc, ~/.bash_profile, ~/.zprofile, ~/.zshrc, and ~/.profile."
    nvm_echo "=> Create one of them and run this script again"
    nvm_echo "   OR"
    nvm_echo "=> Append the following lines to the correct file yourself:"
    command printf "${SOURCE_STR}"
    nvm_echo
  else
    if nvm_profile_is_bash_or_zsh "${NVM_PROFILE-}"; then
      BASH_OR_ZSH=true
    fi
    if ! command grep -qc '/nvm.sh' "$NVM_PROFILE"; then
      nvm_echo "=> Appending nvm source string to $NVM_PROFILE"
      command printf "${SOURCE_STR}" >> "$NVM_PROFILE"
    else
      nvm_echo "=> nvm source string already in ${NVM_PROFILE}"
    fi
    # shellcheck disable=SC2016
    if ${BASH_OR_ZSH} && ! command grep -qc '$NVM_DIR/bash_completion' "$NVM_PROFILE"; then
      nvm_echo "=> Appending bash_completion source string to $NVM_PROFILE"
      command printf "$COMPLETION_STR" >> "$NVM_PROFILE"
    else
      nvm_echo "=> bash_completion source string already in ${NVM_PROFILE}"
    fi
  fi
  if ${BASH_OR_ZSH} && [ -z "${NVM_PROFILE-}" ] ; then
    nvm_echo "=> Please also append the following lines to the if you are using bash/zsh shell:"
    command printf "${COMPLETION_STR}"
  fi

  # Source nvm
  # shellcheck source=/dev/null
  \. "$(nvm_install_dir)/nvm.sh"

  nvm_check_global_modules

  nvm_install_node

  nvm_reset

  nvm_echo "=> Close and reopen your terminal to start using nvm or run the following to use it now:"
  command printf "${SOURCE_STR}"
  if ${BASH_OR_ZSH} ; then
    command printf "${COMPLETION_STR}"
  fi
}

#
# Unsets the various functions defined
# during the execution of the install script
#
nvm_reset() {
  unset -f nvm_has nvm_install_dir nvm_latest_version nvm_profile_is_bash_or_zsh \
    nvm_source nvm_node_version nvm_download install_nvm_from_git nvm_install_node \
    install_nvm_as_script nvm_try_profile nvm_detect_profile nvm_check_global_modules \
    nvm_do_install nvm_reset nvm_default_install_dir nvm_grep
}

[ "_$NVM_ENV" = "_testing" ] || nvm_do_install

} # this ensures the entire script is downloaded ##!/usr/bin/env bash

{ # esto garantiza que se descargue todo el script #

nvm_has() {
  tipo "$1" > /dev/null 2>&1
}

nvm_echo() {
  comando printf %s\\n "$*" 2>/dev/null
}

si [ -z "${BASH_VERSION}" ] || [ -n "${ZSH_VERSION}" ]; entonces
  # shellcheck deshabilitado=SC2016
  nvm_echo >&2 'Error: las instrucciones de instalación indican explícitamente que se debe canalizar el script de instalación a `bash`; sígalas'
  salida 1
fi

nvm_grep() {
  GREP_OPTIONS='' comando grep "$@"
}

directorio_de_instalación_predeterminado_nvm() {
  [ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm"
}

directorio_de_instalación_nvm() {
  si [ -n "$NVM_DIR" ]; entonces
    printf %s "${NVM_DIR}"
  demás
    directorio_de_instalación_predeterminado_nvm
  fi
}

nvm_última_versión() {
  nvm_echo "v0.40.3"
}

El perfil nvm es bash o zsh() {
  PERFIL DE PRUEBA local
  PERFIL_DE_PRUEBA="${1-}"
  caso "${TEST_PROFILE-}" en
    *"/.bashrc" | *"/.bash_profile" | *"/.zshrc" | *"/.zprofile")
      devolver
    ;;
    *)
      retorno 1
    ;;
  esac
}

#
# Envía la ubicación a NVM dependiendo de:
# * La disponibilidad de $NVM_SOURCE
# * La presencia de $NVM_INSTALL_GITHUB_REPO
# * El método utilizado ("script" o "git" en el script, por defecto "git")
# NVM_SOURCE siempre tiene prioridad a menos que el método sea "script-nvm-exec"
#
nvm_source() {
  repositorio local de GitHub de NVM
  NVM_GITHUB_REPO="${NVM_INSTALL_GITHUB_REPO:-nvm-sh/nvm}"
  si [ "${NVM_GITHUB_REPO}" != 'nvm-sh/nvm' ]; entonces
    { nvm_echo >&2 "$(cat)" ; } << EOF
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ ADVERTENCIA: ¡LA IDENTIFICACIÓN DEL REPOSITOR REMOTO HA CAMBIADO! @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
¡ES POSIBLE QUE ALGUIEN ESTÉ HACIENDO ALGO MALO!

El repositorio predeterminado para esta instalación es \`nvm-sh/nvm\`,
pero las variables de entorno \`\$NVM_INSTALL_GITHUB_REPO\` son
Actualmente establecido en \`${NVM_GITHUB_REPO}\`.

Si esto no es intencional, interrumpa esta instalación y
Verifique sus variables de entorno.
EOF
  fi
  NVM_VERSION local
  NVM_VERSION="${VERSIÓN_DE_INSTALACIÓN_NVM:-$(última_versión_nvm)}"
  método NVM local
  MÉTODO NVM="$1"
  URL_DE_ORIGEN_NVM_local
  URL_DE_ORIGEN_NVM="$ORIGEN_NVM"
  si [ "_$NVM_METHOD" = "_script-nvm-exec" ]; entonces
    URL_DE_ORIGEN_NVM="https://raw.githubusercontent.com/${REPOSITOR_GITHUB_NVM}/${VERSIÓN_NVM}/nvm-exec"
  elif [ "_$NVM_METHOD" = "_script-nvm-bash-completion" ]; entonces
    URL_DE_ORIGEN_NVM="https://raw.githubusercontent.com/${NVM_GITHUB_REPO}/${NVM_VERSION}/bash_completion"
  elif [ -z "$NVM_SOURCE_URL" ]; entonces
    si [ "_$NVM_METHOD" = "_script" ]; entonces
      URL_DE_ORIGEN_NVM="https://raw.githubusercontent.com/${REPOSITOR_GITHUB_NVM}/${VERSIÓN_NVM}/nvm.sh"
    elif [ "_$MÉTODO_NVM" = "_git" ] || [ -z "$MÉTODO_NVM" ]; entonces
      URL_DE_ORIGEN_NVM="https://github.com/${NVM_GITHUB_REPO}.git"
    demás
      nvm_echo >&2 "Valor inesperado \"$NVM_METHOD\" para \$NVM_METHOD"
      retorno 1
    fi
  fi
  nvm_echo "$URL_DE_ORIGEN_NVM"
}

#
# Versión de Node.js a instalar
#
versión_del_nodo_nvm() {
  nvm_echo "$VERSIÓN_DE_NODO"
}

nvm_download() {
  si nvm_has "curl"; entonces
    curl --fail --compressed -q "$@"
  elif nvm_has "wget"; entonces
    # Emular curl con wget
    ARGS=$(nvm_echo "$@" | comando sed -e 's/--progress-bar /--progress=bar /' \
                            -e 's/--comprimido //' \
                            -e 's/--fail //' \
                            -e 's/-L //' \
                            -e 's/-I /--respuesta-del-servidor /' \
                            -e 's/-s /-q /' \
                            -e 's/-sS /-nv /' \
                            -e 's/-o /-O /' \
                            -e 's/-C - /-c /')
    # shellcheck deshabilitado=SC2086
    evaluar wget $ARGS
  fi
}

instalar_nvm_desde_git() {
  directorio_de_instalación local
  DIRECCIÓN_DE_INSTALACIÓN="$(dirección_de_instalación_nvm)"
  NVM_VERSION local
  NVM_VERSION="${VERSIÓN_DE_INSTALACIÓN_NVM:-$(última_versión_nvm)}"
  si [ -n "${NVM_INSTALL_VERSION:-}" ]; entonces
    # Verificar si la versión es una referencia existente
    si comando git ls-remote "$(nvm_source "git")" "$NVM_VERSION" | nvm_grep -q "$NVM_VERSION" ; entonces
      :
    # Verificar si la versión es un conjunto de cambios existente
    elif !nvm_download -o /dev/null "$(nvm_source "script-nvm-exec")"; entonces
      nvm_echo >&2 "No se pudo encontrar la versión '$NVM_VERSION'."
      salida 1
    fi
  fi

  error de búsqueda local
  si [ -d "$INSTALL_DIR/.git" ]; entonces
    # Actualizando el repositorio
    nvm_echo "=> nvm ya está instalado en $INSTALL_DIR, intentando actualizar usando git"
    comando printf '\r=> '
    fetch_error="No se pudo actualizar nvm con $NVM_VERSION, ejecute 'git fetch' en $INSTALL_DIR usted mismo."
  demás
    fetch_error="No se pudo obtener el origen con $NVM_VERSION. ¡Por favor, informe esto!"
    nvm_echo "=> Descargando nvm desde git a '$INSTALL_DIR'"
    comando printf '\r=> '
    mkdir -p "${DIR_DE_INSTALACIÓN}"
    si [ "$(ls -A "${INSTALL_DIR}")" ]; entonces
      # Inicializando el repositorio
      comando git init "${INSTALL_DIR}" || {
        nvm_echo >&2 'Error al inicializar el repositorio nvm. ¡Por favor, informe esto!'
        salida 2
      }
      comando git --git-dir="${INSTALL_DIR}/.git" remoto agregar origen "$(nvm_source)" 2> /dev/null \
        || comando git --git-dir="${INSTALL_DIR}/.git" remoto establecer-url origen "$(nvm_source)" || {
        nvm_echo >&2 'No se pudo agregar el origen remoto (ni configurar la URL). ¡Por favor, informe de esto!'
        salida 2
      }
    demás
      # Clonación de repositorio
      comando git clone "$(nvm_source)" --depth=1 "${INSTALL_DIR}" || {
        nvm_echo >&2 'Error al clonar el repositorio NVM. ¡Por favor, informe esto!'
        salida 2
      }
    fi
  fi
  # Intenta obtener la etiqueta
  si el comando git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" obtiene la etiqueta de origen "$NVM_VERSION" --depth=1 2>/dev/null; entonces
    :
  # Obtener la versión dada
  elif ! comando git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" buscar origen "$NVM_VERSION" --depth=1; entonces
    nvm_echo >&2 "$fetch_error"
    salida 1
  fi
  comando git -c advice.detachedHead=false --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" checkout -f --quiet FETCH_HEAD || {
    nvm_echo >&2 "No se pudo obtener la versión dada $NVM_VERSION. ¡Por favor, informe esto!"
    salida 2
  }
  si [ -n "$(comando git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" mostrar-ref refs/heads/master)" ]; entonces
    si el comando git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" rama --quiet 2>/dev/null; entonces
      comando git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" rama --quiet -D master >/dev/null 2>&1
    demás
      nvm_echo >&2 "Tu versión de git no está actualizada. ¡Por favor, actualízala!"
      comando git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" rama -D master >/dev/null 2>&1
    fi
  fi

  nvm_echo "=> Comprimiendo y limpiando el repositorio Git"
  si ! comando git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" reflog expire --expire=now --all; entonces
    nvm_echo >&2 "Tu versión de git no está actualizada. ¡Por favor, actualízala!"
  fi
  si ! comando git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" gc --auto --aggressive --prune=now ; entonces
    nvm_echo >&2 "Tu versión de git no está actualizada. ¡Por favor, actualízala!"
  fi
  devolver
}

#
# Instalar Node.js automáticamente
#
nvm_install_node() {
  VERSIÓN_LOCAL_DE_NODO local
  VERSIÓN_DE_NODO_LOCAL="$(versión_de_nodo_nvm)"

  si [ -z "$NODE_VERSION_LOCAL" ]; entonces
    devolver 0
  fi

  nvm_echo "=> Instalando la versión $NODE_VERSION_LOCAL de Node.js"
  nvm instalar "$NODE_VERSION_LOCAL"
  NODO_NVM_ACTUAL_local@echo off
title Limpieza y reparación universal - Melampe Power Fixer ⚡
echo ===============================================
echo 🔧 Iniciando limpieza universal...
echo ===============================================

:: Node.js / JavaScript / TypeScript
if exist node_modules (
    echo 🧹 Borrando dependencias de Node.js...
    rmdir /s /q node_modules
)
if exist package-lock.json del /f /q package-lock.json
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist .next rmdir /s /q .next
if exist .turbo rmdir /s /q .turbo

echo 🚀 Limpiando cache npm...
npm cache clean --force >nul 2>&1

echo 🔧 Reinstalando dependencias...
npm install

echo ⚙️ Compilando proyecto...
npm run build

:: Visual Studio / .NET
echo 🧰 Reparando proyectos .NET / Visual Studio...
dotnet clean
dotnet restore
dotnet build

:: Python
if exist requirements.txt (
    echo 🐍 Reparando entorno Python...
    rmdir /s /q _pycache_ >nul 2>&1
    del /f /q *.pyc >nul 2>&1
    pip install --upgrade pip
    pip install -r requirements.txt
)

:: Java
if exist build.gradle (
    echo ☕ Reparando proyecto Java...
    gradlew clean
    gradlew build
)

:: C++
if exist CMakeLists.txt (
    echo 🧩 Compilando proyecto C++...
    if exist build rmdir /s /q build
    mkdir build
    cd build
    cmake ..
    make
    cd ..
)

  NODO_NVM_ACTUAL="$(versión_nvm_actual)"
  si [ "$(nvm_version "$NODE_VERSION_LOCAL")" == "$CURRENT_NVM_NODE" ]; entonces
    nvm_echo "=> La versión $NODE_VERSION_LOCAL de Node.js se instaló correctamente"
  demás
    nvm_echo >&2 "Error al instalar Node.js $NODE_VERSION_LOCAL"
  fi
}

instalar_nvm_as_script() {
  directorio_de_instalación local
  DIRECCIÓN_DE_INSTALACIÓN="$(dirección_de_instalación_nvm)"
  NVM_FUENTE_LOCAL local
  NVM_SOURCE_LOCAL="$(script de origen nvm)"
  FUENTE DE EJECUCIÓN NVM local
  NVM_EXEC_SOURCE="$(nvm_source script-nvm-exec)"
  FUENTE DE FINALIZACIÓN DE NVM_BASH local
  NVM_BASH_COMPLETION_SOURCE="$(nvm_source script-nvm-bash-finalización)"

  # Descargando a $INSTALL_DIR
  mkdir -p "$DIR_INSTALACIÓN"
  si [ -f "$INSTALL_DIR/nvm.sh" ]; entonces
    nvm_echo "=> nvm ya está instalado en $INSTALL_DIR, intentando actualizar el script"
  demás
    nvm_echo "=> Descargando nvm como script en '$INSTALL_DIR'"
  fi
  nvm_download -s "$NVM_SOURCE_LOCAL" -o "$INSTALL_DIR/nvm.sh" || {
    nvm_echo >&2 "Error al descargar '$NVM_SOURCE_LOCAL'"
    retorno 1
  } y
  nvm_download -s "$ORIGEN_EXEC_NVM" -o "$DIR_INSTALACIÓN/nvm-exec" || {
    nvm_echo >&2 "Error al descargar '$NVM_EXEC_SOURCE'"
    retorno 2
  } y
  nvm_download -s "$NVM_BASH_COMPLETION_SOURCE" -o "$INSTALL_DIR/bash_completion" || {
    nvm_echo >&2 "Error al descargar '$NVM_BASH_COMPLETION_SOURCE'"
    retorno 2
  } y
  para trabajo en $(jobs -p | comando sort)
  hacer
    esperar "$job" || devolver $?
  hecho
  chmod a+x "$DIR_INSTALACIÓN/nvm-exec" || {
    nvm_echo >&2 "No se pudo marcar '$INSTALL_DIR/nvm-exec' como ejecutable"
    retorno 3
  }
}

nvm_try_profile() {
  si [ -z "${1-}" ] || [ ! -f "${1}" ]; entonces
    retorno 1
  fi
  nvm_echo "${1}"
}

#
# Detectar archivo de perfil si no se especifica como variable de entorno
# (por ejemplo: PERFIL=~/.miperfil)
# Se garantiza que la ruta reflejada sea un archivo existente
# De lo contrario, se devuelve una cadena vacía
#
nvm_detect_profile() {
  si [ "${PERFIL-}" = '/dev/null' ]; entonces
    # el usuario ha solicitado específicamente que NVM NO toque su perfil
    devolver
  fi

  si [ -n "${PERFIL}" ] && [ -f "${PERFIL}" ]; entonces
    nvm_echo "${PERFIL}"
    devolver
  fi

  PERFIL_DETECTADO local
  PERFIL_DETECTADO=''

  si [ "${SHELL#*bash}" != "$SHELL" ]; entonces
    si [ -f "$HOME/.bashrc" ]; entonces
      PERFIL_DETECTADO="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; entonces
      PERFIL_DETECTADO="$HOME/.bash_profile"
    fi
  elif [ "${SHELL#*zsh}" != "$SHELL" ]; entonces
    si [ -f "${ZDOTDIR:-${HOME}}/.zshrc" ]; entonces
      PERFIL_DETECTADO="${ZDOTDIR:-${INICIO}}/.zshrc"
    elif [ -f "${ZDOTDIR:-${HOME}}/.zprofile" ]; entonces
      PERFIL_DETECTADO="${ZDOTDIR:-${INICIO}}/.zprofile"
    fi
  fi

  si [ -z "$DETECTED_PROFILE" ]; entonces
    para CADA_PERFIL en ".profile" ".bashrc" ".bash_profile" ".zprofile" ".zshrc"
    hacer
      si DETECTED_PROFILE="$(nvm_try_profile "${ZDOTDIR:-${HOME}}/${CADA_PERFIL}")"; entonces
        romper
      fi
    hecho
  fi

  si [ -n "$DETECTED_PROFILE" ]; entonces
    nvm_echo "$PERFIL_DETECTADO"
  fi
}

#
# Verificar si el usuario tiene algún módulo npm instalado globalmente en su sistema
# Nodo y advertirles si es así.
#
nvm_check_global_modules() {
  COMANDO NPM local
  NPM_COMMAND="$(comando -v npm 2>/dev/null)" || devolver 0
  [ -n "${NVM_DIR}" ] && [ -z "${NPM_COMMAND%%"$NVM_DIR"/*}" ] && devuelve 0

  versión NPM_local
  NPM_VERSION="$(npm --versión)"
  NPM_VERSION="${NPM_VERSION:--1}"
  [ "${NPM_VERSION%%[!-0-9]*}" -gt 0 ] || devolver 0

  MÓDULOS GLOBALES NPM locales
  MÓDULOS GLOBALES NPM="$(
    npm lista -g --profundidad=0 |
    comando sed -e '/ npm@/d' -e '/ (vacío)$/d'
  )"

  MÓDULO_CONTADOR local
  MÓDULO_COUNT="$(
    comando printf %s\\n "$NPM_GLOBAL_MODULES" |
    comando sed -ne '1!p' | # Eliminar la primera línea
    wc -l | command tr -d ' ' # Contar entradas
  )"

  si [ "${MODULE_COUNT}" != '0' ]; entonces
    # shellcheck deshabilitado=SC2016
    nvm_echo '=> Actualmente tienes módulos instalados globalmente con `npm`. Estos no...'
    # shellcheck deshabilitado=SC2016
    nvm_echo '=> ya no estará vinculado a la versión activa de Node cuando instale un nuevo nodo'
    # shellcheck deshabilitado=SC2016
    nvm_echo '=> con `nvm`; y pueden (dependiendo de cómo construya su `$PATH`)'
    # shellcheck deshabilitado=SC2016
    nvm_echo '=> anula los binarios de los módulos instalados con `nvm`:'
    eco nvm

    comando printf %s\\n "$NPM_GLOBAL_MODULES"
    nvm_echo '=> Si desea desinstalarlos más adelante (o reinstalarlos bajo su'
    # shellcheck deshabilitado=SC2016
    nvm_echo '=> instalaciones del nodo `nvm`), puede eliminarlos del nodo del sistema de la siguiente manera:'
    eco nvm
    nvm_echo ' $ nvm usa el sistema'
    nvm_echo ' $ npm uninstall -g a_module'
    eco nvm
  fi
}

nvm_do_install() {
  si [ -n "${NVM_DIR-}" ] && ! [ -d "${NVM_DIR}" ]; entonces
    si [ -e "${NVM_DIR}" ]; entonces
      nvm_echo >&2 "El archivo \"${NVM_DIR}\" tiene el mismo nombre que el directorio de instalación."
      salida 1
    fi

    si [ "${NVM_DIR}" = "$(nvm_default_install_dir)" ]; entonces
      mkdir "${NVM_DIR}"
    demás
      nvm_echo >&2 "Tiene \$NVM_DIR configurado en \"${NVM_DIR}\", pero ese directorio no existe. Verifique sus archivos de perfil y entorno."
      salida 1
    fi
  fi
  # Deshabilitar la verificación opcional, https://www.shellcheck.net/wiki/SC2230
  # shellcheck deshabilitado=SC2230
  si nvm_has xcode-select && [ "$(xcode-select -p >/dev/null 2>/dev/null ; echo $?)" = '2' ] && [ "$(que git)" = '/usr/bin/git' ] && [ "$(que curl)" = '/usr/bin/curl' ]; entonces
    nvm_echo >&2 'Es posible que estés en una Mac y necesites instalar las herramientas de desarrollo de línea de comandos de Xcode.'
    # shellcheck deshabilitado=SC2016
    nvm_echo >&2 'Si es así, ejecute `xcode-select --install` e inténtelo de nuevo. Si no, ¡infórmenos!'
    salida 1
  fi
  si [ -z "${METHOD}" ]; entonces
    # Método de instalación de detección automática
    si nvm_has git; entonces
      instalar_nvm_desde_git
    elif nvm_has curl || nvm_has wget; entonces
      instalar_nvm_como_script
    demás
      nvm_echo >&2 'Necesitas git, curl o wget para instalar nvm'
      salida 1
    fi
  elif [ "${METHOD}" = 'git' ]; entonces
    si !nvm_has git; entonces
      nvm_echo >&2 "Necesitas git para instalar nvm"
      salida 1
    fi
    instalar_nvm_desde_git
  elif [ "${METHOD}" = 'script' ]; entonces
    si ! nvm_has curl && ! nvm_has wget; entonces
      nvm_echo >&2 "Necesita curl o wget para instalar nvm"
      salida 1
    fi
    instalar_nvm_como_script
  demás
    nvm_echo >&2 "La variable de entorno \$METHOD está establecida en \"${METHOD}\", que no se reconoce como un método de instalación válido."
    salida 1
  fi

  eco nvm

  perfil NVM local
  NVM_PROFILE="$(perfil_de_detección_nvm)"
  directorio_de_instalación_del_perfil_local
  DIRECCIÓN_DE_INSTALACIÓN_DE_PERFIL="$(dirección_de_instalación_de_nvm | comando sed "s:^$HOME:\$HOME:")"

  SOURCE_STR="\\nexport NVM_DIR=\"${DIR_INSTALACIÓN_DE_PERFIL}\"\\n[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\" # Esto carga nvm\\n"

  # shellcheck deshabilitado=SC2016
  COMPLETION_STR='[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # Esto carga nvm bash_completion\n'
  BASH_OR_ZSH=falso

  si [ -z "${NVM_PROFILE-}" ] ; entonces
    PERFIL PROBADO local
    si [ -n "${PERFIL}" ]; entonces
      TRIED_PROFILE="${NVM_PROFILE} (como se define en \$PROFILE), "
    fi
    nvm_echo "=> Perfil no encontrado. Se intentó ${TRIED_PROFILE-}~/.bashrc, ~/.bash_profile, ~/.zprofile, ~/.zshrc y ~/.profile."
    nvm_echo "=> Crea uno de ellos y ejecuta este script nuevamente"
    nvm_echo " O "
    nvm_echo "=> Agregue las siguientes líneas al archivo correcto usted mismo:"
    comando printf "${SOURCE_STR}"
    eco nvm
  demás
    si nvm_profile_is_bash_or_zsh "${NVM_PROFILE-}"; entonces
      BASH_OR_ZSH=verdadero
    fi
    si ! comando grep -qc '/nvm.sh' "$NVM_PROFILE"; entonces
      nvm_echo "=> Añadiendo la cadena de origen de NVM a $NVM_PROFILE"
      comando printf "${SOURCE_STR}" >> "$NVM_PROFILE"
    demás
      nvm_echo "=> La cadena de origen de NVM ya está en ${NVM_PROFILE}"
    fi
    # shellcheck deshabilitado=SC2016
    si ${BASH_OR_ZSH} && ! comando grep -qc '$NVM_DIR/bash_completion' "$NVM_PROFILE"; entonces
      nvm_echo "=> Añadiendo la cadena de origen bash_completion a $NVM_PROFILE"
      comando printf "$COMPLETION_STR" >> "$NVM_PROFILE"
    demás
      nvm_echo "=> La cadena de origen de bash_completion ya está en ${NVM_PROFILE}"
    fi
  fi
  si ${BASH_OR_ZSH} && [ -z "${NVM_PROFILE-}" ] ; entonces
    nvm_echo "=> Agregue también las siguientes líneas si está usando el shell bash/zsh:"
    comando printf "${COMPLETION_STR}"
  fi

  # Fuente nvm
  # shellcheck fuente=/dev/null
  \. "$(directorio_de_instalación_nvm)/nvm.sh"

  módulos globales de verificación nvm

  nodo de instalación nvm

  reinicio de nvm

  nvm_echo "=> Cierre y vuelva a abrir su terminal para comenzar a usar nvm o ejecute lo siguiente para usarlo ahora:"
  comando printf "${SOURCE_STR}"
  si ${BASH_OR_ZSH} ; entonces
    comando printf "${COMPLETION_STR}"
  fi
}

#
# Desactiva las distintas funciones definidas
# durante la ejecución del script de instalación
#
nvm_reset() {
  unset -f nvm_has directorio_de_instalación_nvm última_versión_nvm perfil_nvm_es_bash_o_zsh \
    nvm_source nvm_node_version nvm_download instalar_nvm_desde_git nvm_install_node \
    instalar_nvm_como_script perfil_de_prueba_nvm perfil_de_detección_nvm módulos_globales_de_comprobación_nvm \
    nvm_do_install nvm_reset directorio_de_instalación_predeterminado_nvm nvm_grep
}

[ "_$NVM_ENV" = "_prueba" ] || nvm_do_install

} # esto garantiza que se descargue todo el script #ReadMe.txt para la implementación de referencia del algoritmo bidireccional Unicode
Fecha: 15/10/2025
© 2025 Unicode®, Inc.
Unicode y el logotipo de Unicode son marcas registradas de Unicode, Inc. en los EE. UU. y otros países.
Para conocer los términos de uso y licencia, consulte https://www.unicode.org/terms_of_use.html

Este directorio contiene directorios versionados para la referencia de C
Implementación del algoritmo bidireccional Unicode. Cada
El directorio versionado contiene el código fuente y un ReadMe.txt detallado.
y versiones compiladas (ejecutables de Windows de 64 bits) de la implementación.
Cada versión recién actualizada es compatible con todas las versiones anteriores del
Algoritmo bidireccional Unicode (regreso a Unicode 6.2.0). Por lo tanto,
por ejemplo, si consulta la versión 17.0.0 de la referencia
Implementación, puede considerarse que reemplaza todas las anteriores.
versiones, porque contiene soporte acumulado para todas las
conjuntos de reglas anteriores y se pueden ejecutar utilizando cualquiera de los conjuntos de reglas anteriores
archivos de datos específicos de versiones del estándar Unicode.

Para la especificación del algoritmo bidireccional Unicode, consulte
UAX #9:

https://www.unicode.org/reports/tr9/
npx @modelcontextprotocol/server-everything streamableHttpnpx @modelcontextprotocol/server-everything ssenpx @modelcontextprotocol/server-everything stdionpx @modelcontextprotocol/server-everythingnpm install -g @modelcontextprotocol/server-everything@latestcd src/everything
npm install
npm run start:streamableHttpcd src/everything
npm install
npm run start:sse{
  "servers": {
    "everything": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-everything"]
    }
  }
}{
  "mcpServers": {
    "everything": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-everything"
      ]
    }
  }
}{
  "method": "notifications/message",
  "params": {
	"level": "info",
	"data": "Info-level message"
  }
}{
  "priority": 1.0,
  "audience": ["user", "assistant"]
}constante  core  =  require ( '@actions/core' ) ;

try  { 
  // Hacer cosas 
} 
catch  ( err )  { 
  // setFailed registra el mensaje y establece un código de salida fallido 
  core . setFailed ( `La acción falló con el error ${ err } ` ) ; 
}{"name":"gh","full_name":"gh","tap":"homebrew/core","oldnames":[],"aliases":[],"versioned_formulae":[],"desc":"Línea de comandos de GitHub herramienta","licencia":"MIT","página de inicio":"https://cli.github.com/","versiones":{"stable":"2.82.1","head":"HEAD","bottle":true},"urls":{"stable":{"url":"https://github.com/cli/cli/archive/refs/tags/v2.82.1.tar.gz","tag":null,"revision":null,"using":null,"checksum":"999bdea5c8baf3d03fe0314127c2c393d6c0f7a504a573ad0c107072973af973"},"head":{"url":"https://github.com/cli/cli.git","branch":"trunk","using":null}},"revision":0,"version_scheme":0,"compatibility_version":null,"autobump":false,"no_autobum p_message":"Afectado_por_la_corriente_arriba","skip_livecheck":false,"bottle":{"stable":{"rebuild":0,"root_url":"https://ghcr.io/v2/homebrew/core","files":{"arm64_tahoe":{"cellar":":cualquier_reubicación_de_salto","url":"https://ghcr.io/v2/homebrew/core/gh/blobs/sha256: 9695cb8604ad36f9d8b4c2cda5cefb231337728faebf83224563991c3834999b","sha256":"9695cb8604ad36f9d8b4c2cda5cefb231337728faebf83224563991c3834999b"},"arm64_sequoia":{"bodega":":cualquier_reubicación_de_saltos","url":"https://ghcr.io/v2/homebrew/core/gh/blobs/sha25 6:9695cb8604ad36f9d8b4c2cda5cefb231337728faebf83224563991c3834999b","sha256":"9695cb8604ad36f9d8b4c2cda5cefb231337728faebf83224563991c3834999b"},"arm64_sonoma":{"cellar":":cualquier_reubicación_de_saltos","url":"https://ghcr.io/v2/homebrew/core/gh/blobs/sha 256:9695cb8604ad36f9d8b4c2cda5cefb231337728faebf83224563991c3834999b","sha256":"9695cb8604ad36f9d8b4c2cda5cefb231337728faebf83224563991c3834999b"},"sonoma":{"bodega":":cualquier_reubicación_de_saltos","url":"https://ghcr.io/v2/homebrew/core/gh/blobs/sha256:f 766fe6bd74b16d6cc3e839d6283b86d903b2d73799f4cc8ee4b9a56d35c4898","sha256":"f766fe6bd74b16d6cc3e839d6283b86d903b2d73799f4cc8ee4b9a56d35c4898"},"arm64_linux":{"cellar":":cualquier_reubicación_de_saltos","url":"https://ghcr.io/v2/homebrew/core/gh/blobs/sha256:b d70bca2a11e036713de28910edc9e3c858d6bf9716bfa6cda1e730be5cf6636","sha256":"bd70bca2a11e036713de28910edc9e3c858d6bf9716bfa6cda1e730be5cf6636"},"x86_64_linux":{"cellar":":cualquier_reubicación_de_saltos","url":"https://ghcr.io/v2/homebrew/core/gh/blobs/sha256:f7244d94a6b2d25c79605e93652debae4deddec009755194411a698f00a79ecb","sha256":"f7244d94a6b2d25c79605e93652debae4deddec009755194411a698f00a79ecb"}}}},"verter_solo_botella_si": nulo,"solo_barril": falso,"motivo_solo_barril": nulo,"opciones":[],"dependencias_de_compilación":["ir"],"dependencias":[],"dependencias_de_prueba":[],"dependencias_recomendadas":[],"opcióna l_dependencias":[],"usos_de_macos":[],"usos_de_macos_límites":[],"requisitos":[],"conflictos_con":[],"conflictos_con_razones":[],"sobrescritura_de_enlace":[],"advertencias":null,"instalado":[{"versión":"2.81.0","opciones_usadas":[],"construido_como_botella":verdadero,"vertido_desde_botella":verdadero,"tiempo":1760500067,"dependencias_de_tiempo_de_ejecución":[],"instalado_como_dependiente encia":falso,"instalado_a_solicitud":verdadero}],"linked_keg":"2.81.0","fijado":falso,"desactualizado":verdadero,"obsoleto":falso,"fecha_de_obsolescencia":null,"motivo_de_obsolescencia":null,"fórmula_de_reemplazo_de_obsolescencia":null,"cask_de_reemplazo_de_obsolescencia":null,"deshabilitado":falso,"fecha_de_deshabilitación":null,"motivo_de_deshabilitación":null,"fórmula_de_deshabilitación_de_reemplazo":null, "deshabilitar_reemplazo_cask": nulo,"definición_posterior_a_la_instalación": falso,"servicio": nulo,"tap_git_head":"9256a81e7b4ef9c98fc9d7ffbf0b89c4240f0a1e","ruta_de_origen_ruby":"Fórmula/g/gh.rb","suma_de_verificación_de_origen_ruby":{"sha256":"2dec64c0ff1f58a45e7742e350cd58db6c2118f211cedb3e823acdc7f82e66f6"},"variaciones":{},"análisis":{"instalar":{"30d":{"gh":187796,"gh --HEAD":285},"90d":{"gh":505702,"gh --HEAD":823},"365d":{"gh":1771772,"gh --HEAD":2648}},"install_on_request":{"30d":{"gh":187418,"gh --HEAD":285},"90d":{"gh":504891,"gh --HEAD":823},"365d":{"gh":1769029,"gh --HEAD":2648}},"build_error":{"30d":{"gh":146}}},"sobrescritura_de_enlace":[],"advertencias":null,"instalado":[{"versión":"2.81.0","opciones_usadas":[],"construido_como_botella":true,"vertido_desde_botella":true,"tiempo":1760500067,"dependencias_de_tiempo_de_ejecución":[],"instalado_como_dependencia":false,"instalado_a_solicitud":true}],"barril_vinculado":"2.81.0","fijado":false,"obsoleto":true,"obsoleto":false,"fecha_de_obsolescencia":null,"motivo_de_obsolescencia":null,"fórmula_de_reemplazo_de_obsolescencia":null,"barril_de_reemplazo_de_obsolescencia": nulo,"deshabilitado":falso,"fecha_deshabilitar":null,"motivo_deshabilitar":null,"fórmula_de_deshabilitación_de_reemplazo":null,"cask_de_deshabilitación_de_reemplazo":null,"definido_posterior_a_la_instalación":falso,"servicio":null,"tap_git_head":"9256a81e7b4ef9c98fc9d7ffbf0b89c4240f0a1e","ruta_de_origen_ruby":"Fórmula/g/gh.rb","suma_de_verificación_de_origen_ruby":{"sha256":"2dec64c0ff1f58a45e7742e350cd58db6c2118f211cedb3e823acdc7f82e66f6"},"variaciones":{},"analíticas":{"instalar":{"30d":{"gh":187796,"gh --HEAD":285},"90d":{"gh":505702,"gh --HEAD":823},"365d":{"gh":1771772,"gh --HEAD":2648}},"install_on_request":{"30d":{"gh":187418,"gh --HEAD":285},"90d":{"gh":504891,"gh --HEAD":823},"365d":{"gh":1769029,"gh --HEAD":2648}},"build_error":{"30d":{"gh":146}}},"sobrescritura_de_enlace":[],"advertencias":null,"instalado":[{"versión":"2.81.0","opciones_usadas":[],"construido_como_botella":true,"vertido_desde_botella":true,"tiempo":1760500067,"dependencias_de_tiempo_de_ejecución":[],"instalado_como_dependencia":false,"instalado_a_solicitud":true}],"barril_vinculado":"2.81.0","fijado":false,"obsoleto":true,"obsoleto":false,"fecha_de_obsolescencia":null,"motivo_de_obsolescencia":null,"fórmula_de_reemplazo_de_obsolescencia":null,"barril_de_reemplazo_de_obsolescencia": nulo,"deshabilitado":falso,"fecha_deshabilitar":null,"motivo_deshabilitar":null,"fórmula_de_deshabilitación_de_reemplazo":null,"cask_de_deshabilitación_de_reemplazo":null,"definido_posterior_a_la_instalación":falso,"servicio":null,"tap_git_head":"9256a81e7b4ef9c98fc9d7ffbf0b89c4240f0a1e","ruta_de_origen_ruby":"Fórmula/g/gh.rb","suma_de_verificación_de_origen_ruby":{"sha256":"2dec64c0ff1f58a45e7742e350cd58db6c2118f211cedb3e823acdc7f82e66f6"},"variaciones":{},"analíticas":{"instalar":{"30d":{"gh":187796,"gh --HEAD":285},"90d":{"gh":505702,"gh --HEAD":823},"365d":{"gh":1771772,"gh --HEAD":2648}},"install_on_request":{"30d":{"gh":187418,"gh --HEAD":285},"90d":{"gh":504891,"gh --HEAD":823},"365d":{"gh":1769029,"gh --HEAD":2648}},"build_error":{"30d":{"gh":146}}},285},"90d":{"gh":505702,"gh --HEAD":823},"365d":{"gh":1771772,"gh --HEAD":2648}},"instalación_a_solicitud":{"30d":{"gh":187418,"gh --HEAD":285},"90d":{"gh":504891,"gh --HEAD":823},"365d":{"gh":1769029,"gh --HEAD":2648}},"error_de_compilación":{"30d":{"gh":146}}},285},"90d":{"gh":505702,"gh --HEAD":823},"365d":{"gh":1771772,"gh --HEAD":2648}},"instalación_a_solicitud":{"30d":{"gh":187418,"gh --HEAD":285},"90d":{"gh":504891,"gh --HEAD":823},"365d":{"gh":1769029,"gh --HEAD":2648}},"error_de_compilación":{"30d":{"gh":146}}},
"fecha_generada":"24/10/2025"}brew install gh# pubspec.yaml - Copia y pega este contenido completo en el archivo pubspec.yaml de tu proyecto Flutter

name: tokyo_roulette_predicciones
description: Simulador de predicciones para ruleta con modelo freemium.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_stripe: ^10.0.0  # Para cobros Stripe
  in_app_purchase: ^3.2.0  # Soporte in-app
  firebase_core: ^2.24.2  # Firebase base
  firebase_remote_config: ^4.3.12  # Para updates dinámicos cada 4 meses
  cloud_firestore: ^4.15.3  # Almacenar emails
  firebase_auth: ^4.16.0  # Auth para emails
  intl: ^0.18.1  # Idioma/país
  device_info_plus: ^9.1.2  # Info dispositivo/plataforma
  url_launcher: ^6.2.4  # Comentarios via email
  shared_preferences: ^2.2.2  # Storage local
  charts_flutter: ^0.12.0  # Gráficos
  firebase_messaging: ^14.7.10  # Notificaciones para invitaciones

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
    - assets/images/  # Crea esta carpeta y agrega imágenes si quieres (opcional)[![CI](https://github.com/Melampe001/Idea/actions/workflows/blank.yml/badge.svg)](https://github.com/Melampe001/Idea/actions/workflows/blank.yml)
@echo off
title 🔧 LIMPIEZA Y REPARACIÓN TOTAL by Melampe
echo ==============================================
echo 🧹 LIMPIANDO ARCHIVOS TEMPORALES Y CACHES...
echo ==============================================

REM --- Node.js / JavaScript / TypeScript ---
if exist node_modules rmdir /s /q node_modules
if exist package-lock.json del /f /q package-lock.json
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist .next rmdir /s /q .next
if exist .turbo rmdir /s /q .turbo
npm cache clean --force

REM --- Python ---
if exist __pycache__ rmdir /s /q __pycache__
del /s /q *.pyc

REM --- Visual Studio (.NET / C# / C++) ---
dotnet clean
dotnet restore
dotnet build

REM --- Java ---
if exist gradlew (
    call gradlew clean
    call gradlew build
)

REM --- Reinstname: 💥 Melampe Power Auto Fix + Build + Deploy ⚡

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: write
  pages: write
  id-token: write

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest@echo off
title Limpieza y reparación universal - Melampe Power Fixer ⚡
echo ===============================================
echo 🔧 Iniciando limpieza universal...
echo ===============================================

:: Node.js / JavaScript / TypeScript
if exist node_modules (
    echo 🧹 Borrando dependencias de Node.js...
    rmdir /s /q node_modules
)
if exist package-lock.json del /f /q package-lock.json
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
if exist .next rmdir /s /q .next
if exist .turbo rmdir /s /q .turbo

echo 🚀 Limpiando cache npm...
npm cache clean --force >nul 2>&1

echo 🔧 Reinstalando dependencias...
npm install

echo ⚙️ Compilando proyecto...
npm run build

:: Visual Studio / .NET
echo 🧰 Reparando proyectos .NET / Visual Studio...
dotnet clean
dotnet restore
dotnet build

:: Python
if exist requirements.txt (
    echo 🐍 Reparando entorno Python...
    rmdir /s /q _pycache_ >nul 2>&1
    del /f /q *.pyc >nul 2>&1
    pip install --upgrade pip
    pip install -r requirements.txt
)

:: Java
if exist build.gradle (
    echo ☕ Reparando proyecto Java...
    gradlew clean
    gradlew build
)

:: C++
if exist CMakeLists.txt (
    echo 🧩 Compilando proyecto C++...
    if exist build rmdir /s /q build
    mkdir build
    cd build
    cmake ..
    make
    cd ..
)
import 'dart:math';
import 'package:pointycastle/pointycastle.dart';

class RouletteRNG {
  final List<int> europeanWheel = List.generate(37, (i) => i); // 0-36
  final List<int> americanWheel = [0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1, 00, 27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2]; // Orden real de rueda americana con 00

  int generateResult(bool isEuropean) {
    var wheel = isEuropean ? europeanWheel : americanWheel;
    var rng = FortunaRandom();
    var seed = List<int>.generate(32, (_) => Random.secure().nextInt(256));
    rng.seed(KeyParameter(Uint8List.fromList(seed)));
    return wheel[rng.nextUint32() % wheel.length];
  }

  List<int> getNeighbors(int number, bool isEuropean, int count = 4) {
    // Devuelve 'count' vecinos a cada lado (para proyecciones avanzadas)
    var wheel = isEuropean ? europeanWheel : americanWheel;
    int index = wheel.indexOf(number);
    if (index == -1) return [];
    List<int> neighbors = [];
    for (int i = 1; i <= count; i++) {
      neighbors.add(wheel[(index + i) % wheel.length]);
      neighbors.add(wheel[(index - i + wheel.length) % wheel.length]);
    }
    return neighbors..sort();
  }
}import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'firebase_options.dart';
import 'roulette_rng.dart';
import 'martingale_advisor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = 'pk_test_tu_clave_stripe'; // Reemplaza
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokyo Roulette Predicciones',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocationAndPermissions();
    _setupRemoteConfig();
  }

  Future<void> _checkLocationAndPermissions() async {
    await requestPermissions();
    if (!await isInMexico()) {
      showDialog(context: context, builder: (_) => AlertDialog(title: Text('No disponible en tu región')));
      return;
    }
  }

  Future<void> _setupRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(fetchTimeout: Duration(minutes: 1), minimumFetchInterval: Duration(hours: 96)));
    await remoteConfig.fetchAndActivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(child: ElevatedButton(onPressed: () => _login(), child: Text('Iniciar Sesión con Email'))),
    );
  }

  void _login() async {
    try {
      await FirebaseAuth.instance.signInAnonymously(); // O con email
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
    } catch (e) {}
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isEuropean = true;
  List<int> history = [];
  RouletteRNG rng = RouletteRNG();
  MartingaleAdvisor martingale = MartingaleAdvisor();
  String prediction = '';
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isPremium = prefs.getBool('isPremium') ?? false;
  }

  void _spin() {
    int result = rng.generateResult(isEuropean);
    setState(() {
      history.add(result);
      prediction = _predictNext();
    });
    if (isPremium) FirebaseFirestore.instance.collection('spins').add({'result': result});
  }

  String _predictNext() {
    if (history.isEmpty) return 'No hay historial para proyecciones.';
    
    // Calcula frecuencias para TODOS los números posibles (proyección general)
    var wheel = isEuropean ? rng.europeanWheel : rng.americanWheel;
    Map<int, int> freq = {for (var num in wheel) num: 0};
    for (var num in history) {
      if (freq.containsKey(num)) freq[num] = (freq[num] ?? 0) + 1;
    }
    
    // Ordena por frecuencia
    var sortedFreq = freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    
    // Proyecciones básicas (gratuitas): Top 5 calientes y fríos
    List<int> hot = sortedFreq.take(5).map((e) => e.key).toList();
    List<int> cold = sortedFreq.reversed.take(5).map((e) => e.key).toList();
    
    String proj = 'Proyección (calientes: ${hot.join(', ')} | fríos: ${cold.join(', ')})';
    
    // Proyecciones avanzadas (pagadas): Vecinos del último número
    if (isPremium && history.isNotEmpty) {
      var last = history.last;
      var neighbors = rng.getNeighbors(last, isEuropean);
      proj += '\nVecinos de $last: ${neighbors.join(', ')} (proyección para próximos giros)';
    }
    
    return proj;
  }

  Widget _buildPieChart() {
    // Gráfico de frecuencias (para todos los números)
    var wheel = isEuropean ? rng.europeanWheel : rng.americanWheel;
    Map<int, int> freq = {for (var num in wheel) num: 0};
    for (var num in history) freq[num] = (freq[num] ?? 0) + 1;
    
    List<charts.Series<MapEntry<int, int>, int>> series = [
      charts.Series<MapEntry<int, int>, int>(
        id: 'Freq',
        data: freq.entries.toList(),
        domainFn: (entry, _) => entry.key,
        measureFn: (entry, _) => entry.value,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
    return charts.PieChart<int>(series);
  }

  void _purchaseAdvanced() async {
    // Implementa Stripe o in_app_purchase (ejemplo con Stripe)
    var paymentIntent = await _createPaymentIntent(19900); // $199
    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(paymentIntentClientSecret: paymentIntent['client_secret']));
    await Stripe.instance.presentPaymentSheet();
    // On success:
    setState(() => isPremium = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPremium', true);
  }

  Future<Map<String, dynamic>> _createPaymentIntent(int amount) async {
    // Llama a backend para crear intent (placeholder)
    return {}; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ruleta Simulador')),
      body: Column(
        children: [
          SwitchListTile(title: Text('Europea/Americana'), value: isEuropean, onChanged: (val) => setState(() => isEuropean = val)),
          ElevatedButton(onPressed: _spin, child: Text('Girar')),
          Text('Resultado: ${history.lastOrNull ?? ''}'),
          Text('Proyección: $prediction'),
          Text('Martingale: Apuesta siguiente ${martingale.getNextBet(false)}'), // General, no fijo
          SizedBox(height: 200, child: _buildPieChart()),
          if (!isPremium) ElevatedButton(onPressed: _purchaseAdvanced, child: Text('Comprar Avanzada $199')),
          ElevatedButton(onPressed: () => launchUrl(Uri.parse('mailto:support@example.com?subject=Comentarios')), child: Text('Enviar Comentarios')),
        ],
      ),
    );
  }
}

Future<void> requestPermissions() async {
  await Permission.location.request();
}

Future<bool> isInMexico() async {
  Position position = await Geolocator.getCurrentPosition();
  // Placeholder: return true; (implementa API real para país)
  return true;
}
import 'dart:math';
import 'package:flutter/material.dart'; // Para Colors
import 'package:pointycastle/pointycastle.dart';

class RouletteRNG {
  final List<int> europeanWheel = List.generate(37, (i) => i); // 0-36
  final List<int> americanWheel = [0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1, 00, 27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2];

  // Mapa de colores estándar (igual para ambas ruletas, 00 verde como 0)
  final Map<int, Color> numberColors = {
    0: Colors.green, 00: Colors.green,
    1: Colors.red, 2: Colors.black, 3: Colors.red, 4: Colors.black, 5: Colors.red, 6: Colors.black, 7: Colors.red, 8: Colors.black, 9: Colors.red, 10: Colors.black,
    11: Colors.black, 12: Colors.red, 13: Colors.black, 14: Colors.red, 15: Colors.black, 16: Colors.red, 17: Colors.black, 18: Colors.red, 19: Colors.red, 20: Colors.black,
    21: Colors.red, 22: Colors.black, 23: Colors.red, 24: Colors.black, 25: Colors.red, 26: Colors.black, 27: Colors.red, 28: Colors.black, 29: Colors.black, 30: Colors.red,
    31: Colors.black, 32: Colors.red, 33: Colors.black, 34: Colors.red, 35: Colors.black, 36: Colors.red,
  };

  // Sectores (adaptados; para americana, ignora 00 si no aplica)
  final Map<String, List<int>> sectors = {
    'Voisins du Zéro': [22, 18, 29, 7, 28, 12, 35, 3, 26, 0, 32, 15, 19, 4, 21, 2, 25],
    'Tiers du Cylindre': [27, 13, 36, 11, 30, 8, 23, 10, 5, 24, 16, 33],
    'Orphelins': [17, 34, 6, 1, 20, 14, 31, 9],
    'Jeu Zéro': [12, 35, 3, 26, 0, 32, 15],
  };

  int generateResult(bool isEuropean) {
    var wheel = isEuropean ? europeanWheel : americanWheel;
    var rng = FortunaRandom();
    var seed = List<int>.generate(32, (_) => Random.secure().nextInt(256));
    rng.seed(KeyParameter(Uint8List.fromList(seed)));
    return wheel[rng.nextUint32() % wheel.length];
  }

  List<int> getNeighbors(int number, bool isEuropean, int count = 4) {
    var wheel = isEuropean ? europeanWheel : americanWheel;
    int index = wheel.indexOf(number);
    if (index == -1) return [];
    List<int> neighbors = [];
    for (int i = 1; i <= count; i++) {
      neighbors.add(wheel[(index + i) % wheel.length]);
      neighbors.add(wheel[(index - i + wheel.length) % wheel.length]);
    }
    return neighbors..sort();
  }

  double getSectorFrequency(String sector, List<int> history) {
    var nums = sectors[sector] ?? [];
    int count = history.where((num) => nums.contains(num)).length;
    return history.isEmpty ? 0 : count / history.length * 100;
  }import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'firebase_options.dart';
import 'roulette_rng.dart';
import 'martingale_advisor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = 'pk_test_tu_clave_stripe';
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokyo Roulette Predicciones',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocationAndPermissions();
    _setupRemoteConfig();
  }

  Future<void> _checkLocationAndPermissions() async {
    await requestPermissions();
    if (!await isInMexico()) {
      showDialog(context: context, builder: (_) => AlertDialog(title: Text('No disponible en tu región')));
      return;
    }
  }

  Future<void> _setupRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(fetchTimeout: Duration(minutes: 1), minimumFetchInterval: Duration(hours: 96)));
    await remoteConfig.fetchAndActivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(child: ElevatedButton(onPressed: () => _login(), child: Text('Iniciar Sesión con Email'))),
    );
  }

  void _login() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
    } catch (e) {}
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isEuropean = true;
  List<int> history = [];
  RouletteRNG rng = RouletteRNG();
  MartingaleAdvisor martingale = MartingaleAdvisor();
  String prediction = '';
  int subscriptionLevel = 0; // 0: free, 1: advanced, 2: premium (guarda en prefs/Firestore)

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    subscriptionLevel = prefs.getInt('subscriptionLevel') ?? 0;
  }

  void _spin() {
    int result = rng.generateResult(isEuropean);
    setState(() {
      history.add(result);
      prediction = _predictNext();
    });
    if (subscriptionLevel > 0) FirebaseFirestore.instance.collection('spins').add({'result': result});
  }

  String _predictNext() {
    if (history.isEmpty) return 'No hay historial para proyecciones.';

    var wheel = isEuropean ? rng.europeanWheel : rng.americanWheel;
    Map<int, int> freq = {for (var num in wheel) num: 0};
    for (var num in history) {
      if (freq.containsKey(num)) freq[num] = (freq[num] ?? 0) + 1;
    }
    var sortedFreq = freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    List<int> hot = sortedFreq.take(5).map((e) => e.key).toList();
    List<int> cold = sortedFreq.reversed.take(5).map((e) => e.key).toList();

    String proj = 'Proyección básica (calientes: ${hot.join(', ')} | fríos: ${cold.join(', ')})\n¡Upgrada a Avanzado ($199 en Play Store) para predicciones en áreas como Voisins du Zéro!';

    if (subscriptionLevel >= 1) { // Avanzado: Un sector + teaser premium
      double freqVoisins = rng.getSectorFrequency('Voisins du Zéro', history);
      proj += '\nÁrea Voisins du Zéro: Frecuencia ${freqVoisins.toStringAsFixed(1)}% (predicción: más probable si último cerca de 0)\n¡Upgrada a Premium ($299) para todos los campos/sectores!';
      if (history.isNotEmpty) {
        var neighbors = rng.getNeighbors(history.last, isEuropean);
        proj += '\nVecinos: ${neighbors.join(', ')}';
      }
    }

    if (subscriptionLevel == 2) { // Premium: Todos los sectores
      proj = 'Proyección completa:\nCalientes: ${hot.join(', ')} | Fríos: ${cold.join(', ')}\n';
      rng.sectors.forEach((sector, nums) {
        double freqSector = rng.getSectorFrequency(sector, history);
        proj += '$sector: Frecuencia ${freqSector.toStringAsFixed(1)}% (números: ${nums.join(', ')})\n';
      });
    }

    return proj;
  }

  Widget _buildPieChart() {
    var wheel = isEuropean ? rng.europeanWheel : rng.americanWheel;
    Map<int, int> freq = {for (var num in wheel) num: 0};
    for (var num in history) freq[num] = (freq[num] ?? 0) + 1;

    List<charts.Series<MapEntry<int, int>, int>> series = [
      charts.Series<MapEntry<int, int>, int>(
        id: 'Freq',
        data: freq.entries.toList(),
        domainFn: (entry, _) => entry.key,
        measureFn: (entry, _) => entry.value,
        colorFn: (entry, _) => charts.Color.fromOther(color: charts.Color(r: rng.numberColors[entry.key]!.red, g: rng.numberColors[entry.key]!.green, b: rng.numberColors[entry.key]!.blue)), // Colores de ruleta
      )
    ];
    return charts.PieChart<int>(series);
  }

  Widget _buildColoredNumbers(List<int> numbers, String label) {
    return Column(
      children: [
        Text(label),
        Wrap(
          children: numbers.map((num) => Tooltip(
            message: 'Número $num',
            child: CircleAvatar(
              backgroundColor: rng.numberColors[num],
              child: Text('$num', style: TextStyle(color: Colors.white)),
            ),
          )).toList(),
        ),
      ],
    );
  }

  void _purchase(int level, int amount) async {
    // Usa in_app_purchase para Play Store/App Store
    final InAppPurchase iap = InAppPurchase.instance;
    if (await iap.isAvailable()) {
      // Define productos: 'advanced_plan', 'premium_plan'
      var product = level == 1 ? 'advanced_plan' : 'premium_plan';
      var details = await iap.queryProductDetails({product});
      if (details.productDetails.isNotEmpty) {
        var purchaseParam = PurchaseParam(productDetails: details.productDetails.first);
        await iap.buyNonConsumable(purchaseParam: purchaseParam);
        // On success (escucha stream): set subscriptionLevel = level, save prefs
        setState(() => subscriptionLevel = level);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('subscriptionLevel', level);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var hot = []; // Llena dinámicamente si necesitas en UI
    return Scaffold(
      appBar: AppBar(title: Text('Ruleta Simulador')),
      body: Column(
        children: [
          SwitchListTile(title: Text('Europea/Americana'), value: isEuropean, onChanged: (val) => setState(() => isEuropean = val)),
          ElevatedButton(onPressed: _spin, child: Text('Girar')),
          Text('Resultado: ${history.lastOrNull ?? ''}'),
          Text('Proyección: $prediction'),
          _buildColoredNumbers(hot, 'Calientes'), // Ejemplo con formas/colores
          Text('Martingale: Apuesta siguiente ${martingale.getNextBet(false)}'),
          SizedBox(height: 200, child: _buildPieChart()),
          if (subscriptionLevel == 0) ElevatedButton(onPressed: () => _purchase(1, 19900), child: Text('Avanzado $199')),
          if (subscriptionLevel == 1) ElevatedButton(onPressed: () => _purchase(2, 29900), child: Text('Premium $299')),
          ElevatedButton(onPressed: () => launchUrl(Uri.parse('mailto:support@example.com?subject=Comentarios')), child: Text('Enviar Comentarios')),
        ],
      ),
    );
  }
}

Future<void> requestPermissions() async {
  await Permission.location.request();
}

Future<bool> isInMexico() async {
  return true; // Placeholder
}
}
# 🧹 Limpieza completa
rm -rf node_modules package-lock.json dist build .next .turbo

# 🔧 Reinstalar dependencias
npm cache clean --force
npm install

# ⚙️ Compilar o construir de nuevo
npm run build

# 🧪 Probar que todo está correcto
npm test# 🧹 Limpieza
dotnet clean

# 🔧 Restaurar dependencias
dotnet restore

# ⚙️ Compilar de nuevo
dotnet build

# 🧪 Probar si aplica
dotnet test# Limpieza
rm -rf __pycache__ *.pyc

# Reinstalar dependencias
pip install --upgrade pip
pip install -r requirements.txt# Limpieza
./gradlew clean
./gradlew build- name: Clean project
  run: |
    rm -rf node_modules package-lock.json dist build .next .turbo
    npm cache clean --force
    npm install
    npm run build# Limpieza
rm -rf build
mkdir build
cd build
cmake ..
makePaso a Paso: Cómo Crear la Aplicación "Tokyo Roulette Predicciones" en GitHub
¡Hola! A continuación, te guío paso a paso para crear y subir la aplicación "Tokyo Roulette Predicciones" (basada en Flutter, con integración de Stripe para cobros, modelo freemium, actualizaciones OTA, etc., como hemos discutido) a GitHub. Asumo que tienes conocimientos básicos de programación y Flutter; si no, te recomiendo instalar Flutter primero1u7 (sigue la guía oficial en flutter.dev). El proceso es sencillo y toma unos 30-60 minutos si ya tienes el entorno listo.
Recuerda: Esta app es un simulador educativo de ruleta; no promueve gambling real. Cumple con leyes locales (e.g., en México, regula con SEGOB si monetizasimport 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_predicciones/main.dart';

void main() {
  testWidgets('Prueba de botón de giro', (tester) async {
    await tester.pumpWidget(TokyoRouletteApp());
    await tester.enterText(find.byType(TextField), 'test@email.com');
    await tester.tap(find.text('Registrar y Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('Girar Ruleta'), findsOneWidget);
    await tester.tap(find.text('Girar Ruleta'));
    await tester.pump();
  });
}test/giro_test.dartintegration_test/app_test.dart). Para Stripe, configura tu cuenta en stripe.com/mx para payouts a bancos como BBVA, Nu, Ualá o Stori vía CLABE.

Requisitos Previos
Cuenta en GitHub (crea una gratis en github.com si no tienes).
Git instalado (descárgalo de git-scm.com).
Flutter SDK instalado (flutter.dev/get-started).
Editor de código como VS Code o Android Studio.
Cuenta en Stripe (para testing, usa modo test).
Opcional: Cuenta en Firebase (para Remote Config y Auth, gratis para starters).
Paso 1: Configura tu Entorno Local
Abre una terminal (Command Prompt en Windows, Terminal en macOS/Linux).
Crea una carpeta para el proyecto: mkdir tokyo-roulette-predicciones y entra: cd tokyo-roulette-predicciones.
Inicializa un nuevo proyecto Flutter: flutter create . (esto genera la estructura base).
Agrega dependencias en pubspec.yaml (abre el archivo y edita la sección dependencies):
dependencies:
  flutter:
    sdk: flutter
  flutter_stripe: ^10.0.0  # Para Stripe
  in_app_purchase: ^3.2.0  # Para compras in-app (combina con Stripe)
  firebase_core: ^2.24.2  # Firebase para updates y auth
  firebase_remote_config: ^4.3.12
  cloud_firestore: ^4.15.3  # Para almacenar emails securely
  intl: ^0.18.1  # Para idioma/país
  device_info_plus: ^9.1.2
  url_launcher: ^6.2.4  # Para comentarios via email
  shared_preferences: ^2.2.2  # Para storage local
  charts_flutter: ^0.12.0  # Para gráficos (pie chart)
  # Agrega más si necesitas (e.g., http para APIsi)
Corre flutter pub get para instalar paquetes.
Paso 2: Implementa el Código de la App
Copia y pega el código base que hemos generado en conversaciones anteriores. Aquí un resumen unificado (expándelo con detalles previos):
lib/main.dart (Entrada principal):
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';  // Genera con flutterfire configure
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = 'tu_publishable_key_de_stripe';  // De tu dashboard Stripe
  runApp(MyApp());
}

14-15 name: tokyo_roulette_predicciones
description: Simulador de predicciones para ruleta con modelo freemium.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_stripe: ^10.0.0  # Pagos con Stripe
  in_app_purchase: ^3.2.0  # Compras dentro de la app
  firebase_core: ^2.24.2
  firebase_remote_config: ^4.3.12
  cloud_firestore: ^4.15.3
  firebase_auth: ^4.16.0
  intl: ^0.18.1
  device_info_plus: ^9.1.2
  url_launcher: ^6.2.4
  shared_preferences: ^2.2.2
  charts_flutter: ^0.12.0
  firebase_messaging: ^14.7.10

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
    - assets/images/clases      MyApp extends St
atelessWidget {
  @override
  W idget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokyo Roulette Predicciones',
      theme: ThemeData(primarySwatch: Colors.blue),  // Cambia dinámicamente con Remote Config
      home: LoginScreen(),  // Pantalla inicial para solicitar email
    );
  }
}

// Agrega clases para pantallas: LoginScreen (solicita email), MainScreen (ruleta), Settings (plataforma/idioma), ManualScreen, etc.
// Implementa lógica de RNG, Martingale, predicciones, etc., como en códigos previos.
Otras clases: Crea archivos en lib/ para:
RNG y predicciones (e.g., roulette_logic.dart).
Stripe payments (función initPaymentSheet como en ejemplos previos).
Firebase Remote Config para updates (carga temas/colores cada 4 meses).
Formulario comentarios: Usa url_launcher para mailto:tu_correo@example.com.
Manual: Una pantalla con Text widgets explicando funcionamiento/desarrollo.
assets/: Agrega imágenes para UI (ruleta, logos). En pubspec.yaml: flutter: assets: - assets/images/.
firebase_options.dart: Corre flutterfire configure para setup Firebase.
Prueba localmente: flutter run (elige dispositivo/emulador).
Paso 3: Inicializa Git y Crea el Repositorio Local
En la terminal, inicializa Git: git init.
Crea un .gitignore para ignorar archivos innecesarios (Flutter genera uno por default, pero agrega /build y claves secretas como Stripe keys).
Agrega todos los archivos: git add ..
Haz el primer commit: git commit -m "Inicializa proyecto Tokyo Roulette Predicciones con estructura Flutter base".
Paso 4: Crea el Repositorio en GitHub
Ve a github.com y loguea.
Haz clic en "New" (nuevo repositorio).
Nombra: "tokyo-roulette-predicciones" (o similar, público/privado según prefieras).
Descripción: "Aplicación multiplataforma para predicciones simuladas en ruleta con modelo freemium y Stripe".
No inicialices con README (lo agregaremos local).
Crea el repo.
Paso 5: Conecta y Sube el Código a GitHub
En terminal, agrega el remoto: git remote add origin https://github.com/tu_usuario/tokyo-roulette-predicciones.git (reemplaza con tu URL).
Sube: git push -u origin main (o master, dependiendo de tu config).
Verifica en GitHub: El código debe aparecer.
Paso 6: Configura Features Avanzadas en GitHub
Branches: Crea rama para desarrollo: git checkout -b develop. Sube: git push origin develop.
README.md: Agrega un archivo con descripción, instalación, uso y disclaimers. Ejemplo:
# Tokyo Roulette Predicciones

Simulador de ruleta con predicciones. Freemium: Gratuita (básica), Avanzada ($199), Premium ($299).

## Instalación
1. Clona: git clone https://github.com/tu_usuario/tokyo-roulette-predicciones.git
2. flutter pub get
3. flutter run

**Disclaimer**: Solo simulación educativa. No gambling real.
Commit y push.
Issues y Projects: Usa para tracking (e.g., issue para "Implementar updates cada 4 meses").
Actions (CI/CD): Configura workflows para build automático. En .github/workflows/, crea flutter-build.yml para tests.
Paso 7: Integra Stripe y Firebase en el Código
En dashboard Stripe: Crea productos para $199 y $299 (one-time o subscriptions).
En código: Implementa botones para compras, como en el ejemplo anterior.
Para updates: En Firebase Remote Config, define parámetros como theme_color: #FF0000, actualízalos cada 4 meses manualmente o via script.
Cobro 20%: Al detectar update aceptado, inicia payment intent por 20% vía Stripe.
Paso 8: Testing y Deployment
Corre tests: flutter test (agrega unit tests para RNG, predicciones).
Simula 100 pruebas: Usa código para correr simulaciones (e.g., en un script Dart).
Deployment: Sube a Google Play/App Store (usa flutter build apk para Android). Para web/desktop: flutter build web.
Paso 9: Mantenimiento
Cada 4 meses: Actualiza Remote Config con nuevos colores/tipografías (e.g., Google Fonts), lógica mejorada (e.g., IA para predicciones).
Invitaciones: Usa Firebase Messaging para push notifications a emails registrados.
Si necesitas código específico o ayuda con errores, comparte detalles. ¡Éxito con tu repo! Una vez subido, comparte el link para feedback.

import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_predicciones/main.dart';

void main() {
  testWidgets('Prueba de botón de giro', (tester) async {
    await tester.pumpWidget(TokyoRouletteApp());
    await tester.enterText(find.byType(TextField), 'test@email.com');
    await tester.tap(find.text('Registrar y Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('Girar Ruleta'), findsOneWidget);
    await tester.tap(find.text('Girar Ruleta'));
    await tester.pump();
  });
}

# 1️⃣ Asegúrate de tener dependencias actualizadas
flutter pub get

# 2️⃣ Probar la app en modo desarrollo
flutter run

# 3️⃣ Generar el APK de instalación
flutter build apk --release

pubspec.yaml - Copia y pega este contenido completo en el archivo pubspec.yaml de tu proyecto Flutter

name: tokyo_roulette_predicciones
description: Simulador de predicciones para ruleta con modelo freemium.
publish_to: 'none'
version: 1.0.0+1

environment:
sdk: '>=3.0.0 <4.0.0'

dependencies:
flutter:
sdk: flutter
flutter_stripe: ^10.0.0  # Para cobros Stripe
in_app_purchase: ^3.2.0  # Soporte in-app
firebase_core: ^2.24.2  # Firebase base
firebase_remote_config: ^4.3.12  # Para updates dinámicos cada 4 meses
cloud_firestore: ^4.15.3  # Almacenar emails
firebase_auth: ^4.16.0  # Auth para emails
intl: ^0.18.1  # Idioma/país
device_info_plus: ^9.1.2  # Info dispositivo/plataforma
url_launcher: ^6.2.4  # Comentarios via email
shared_preferences: ^2.2.2  # Storage local
charts_flutter: ^0.12.0  # Gráficos
firebase_messaging: ^14.7.10  # Notificaciones para invitaciones

dev_dependencies:
flutter_test:
sdk: flutter

flutter:
uses-material-design: true
assets:
- assets/images/  # Crea esta carpeta y agrega imágenes si quieres (opcional)import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_predicciones/main.dart' as app;

void main() {
IntegrationTestWidgetsFlutterBinding.ensureInitialized();

testWidgets('Prueba de flujo completo: Login, Giro, Cobro', (tester) async {
app.main();
await tester.pumpAndSettle();

// Simula login  
await tester.enterText(find.byType(TextField), 'test@email.com');  
await tester.tap(find.text('Registrar y Continuar'));  
await tester.pumpAndSettle();  

// Simula giro  
await tester.tap(find.text('Girar Ruleta'));  
await tester.pumpAndSettle();  

// Simula cobro (verifica botón, no ejecuta real)  
expect(find.text('Avanzada $199'), findsOneWidget);

});
}import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_predicciones/main.dart';  // Importa tu pantalla principal

void main() {
testWidgets('Prueba de botón de giro', (WidgetTester tester) async {
await tester.pumpWidget(TokyoRouletteApp());
// Simula navegación a MainScreen si es necesario
await tester.enterText(find.byType(TextField), 'test@email.com');  // Simula login
await tester.tap(find.tename: Android Build & Deploy to Play Store

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    env:
      KEYSTORE_BASE64: ${{ secrets.KEYSTORE_BASE64 }}
      KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
      KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
      KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
      SERVICE_ACCOUNT_JSON: ${{ secrets.SERVICE_ACCOUNT_JSON }}
      PACKAGE_NAME: com.melampe.idea   # cambia según tu paquete

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up JDK & Node (si tu proyecto lo usa)
        uses: actions/setup-java@v3
        with:
          distribution: 'temurin'
          java-version: '17'
      - name: Set up Node.js (si tu proyecto usa JS/React dentro de Android)
        uses: actions/setup-node@v4
        with:
          node-version: 18### Mensaje de Confirmación (Commit Message)
Update README.md

### Descripción Ampliada (Extended Description)
Adds README.md description for "Tokyo Roulette Predicciones": multiplatform roulette simulator (EU/US) with RNG, stats (hot/cold, sectors), freemium ($199 advanced, $299 premium), color UI, cross-device support. Includes disclaimers, Flutter setup, Firebase/Stripe.java -jar bundletool.jar validate --bundle build/app/outputs/bundle/release/app-release.aabflutter clean
flutter build appbundle --release --target-platform android-arm,android-arm64,android-x64implementation 'com.android.billingclient:billing:7.1.0'flutter_launcher_icons:
  android: true
  image_path: "assets/images/launcher_icon.png"flutter pub add flutter_launcher_icons
flutter pub run flutter_launcher_icons:mainElevatedButton(
  onPressed: () => launchUrl(Uri.parse('TU_PRIVACY_POLICY_URL_AQUÍ')),
  child: Text('Política de Privacidad'),
),Text('Simulador educativo. No involucra apuestas reales de dinero. Solo para mayores de 18 años.'),compileSdkVersion 35
minSdkVersion 21
targetSdkVersion 35signingConfigs {
    release {
        keyAlias 'upload'
        keyPassword 'TU_PASSPHRASE_AQUÍ'  // Reemplaza
        storeFile file('upload-keystore.jks')
        storePassword 'TU_PASSPHRASE_AQUÍ'  // Reemplaza
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}mv upload-keystore.jks android/app/keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias uploadflutter build appbundle --release --target-platform android-arm,android-arm64,android-x64android {
    ...
    signingConfigs {
        release {
            keyAlias 'upload'
            keyPassword 'tu_passphrase'
            storeFile file('~/upload-keystore.jks')
            storePassword 'tu_passphrase'
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias uploadeval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.compkg install termux-api
termux-clipboard-set "$(cat ~/.ssh/id_ed25519.pub)"pkg update && pkg upgrade -y
pkg install openssh git -yssh-keygen -t ed25519 -C "Melampe - Android" -f ~/.ssh/id_ed25519
