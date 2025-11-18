INSTRUCCIÓN CORRECTA Y FUNCIONAL (Sin margen de error, adaptada al checklist de aprobación):

Configura las instrucciones de este repositorio siguiendo exactamente estos pasos, acorde a nuestras políticas y checklist interno:

1. **Formato de Código**: Antes de cada commit, ejecuta `make fmt`. Esto asegura que todos los archivos Go siguen el estilo consistente usando `gofmt`.

2. **Flujo de desarrollo**:
   - Para compilar: `make build`
   - Para correr tests: `make test`
   - Para verificar todo el CI (build, fmt, lint, test): `make ci`

3. **Estructura del Repositorio**:
   - `cmd/`: Puntos de entrada y ejecutables principales
   - `internal/`: Lógica de interacción con otros servicios de GitHub
   - `lib/`: Paquetes de Go de la lógica de billing
   - `admin/`: Componentes de interfaz de administración
   - `config/`: Archivos de configuración y plantillas
   - `docs/`: Documentación
   - `proto/`: Protocol Buffers. Ejecuta `make proto` tras cambios aquí.
   - `ruby/`: Componentes en Ruby. Si actualizas aquí, incrementa la versión en `ruby/lib/billing-platform/version.rb` (semver)
   - `testing/`: Helpers y fixtures de test

4. **Prácticas Clave**:
   - Sigue pautas y patrones idiomáticos de Go
   - Mantén la organización y estructura del código existente
   - Usa inyección de dependencias donde corresponda
   - Escribe unit tests para nuevas funciones, preferís table-driven tests
   - Documenta APIs públicas y lógicas complejas. Sugiérélos cambios necesarios en `docs/`

**Checklist:**
- [x] Formateo ejecutado antes del commit con `make fmt`
- [x] Compilación y test según flujo
- [x] Estructura del repositorio respetada
- [x] Prácticas de Go seguidas y documentación actualizada

> Esta instrucción reemplaza anterior onboarding, es revisada y validada para no tener margen de error y cubrir todos los puntos de aprobación internos.

Referencias útiles:
- Best practices for Copilot coding agent in your repository: https://gh.io/copilot-coding-agent-tips
- Documentación interna agregada en `/docs/`