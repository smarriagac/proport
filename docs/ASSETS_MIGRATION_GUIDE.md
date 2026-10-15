# Guía de Migración de Assets y Despliegue de Backend Propio

Este documento detalla la hoja de ruta técnica, legal y de arquitectura para reemplazar los assets multimedia temporales por contenido propio o libre de derechos, y desplegar la infraestructura en la nube para servir la aplicación en producción.

---

## 1. Objetivo y Visión General

- **Independencia Total**: Desvincular la aplicación de cualquier servicio o servidor de terceros.
- **Cumplimiento Legal**: Garantizar que el 100% de los elementos visuales (animaciones, portadas, logos y videos) sean de propiedad exclusiva o bajo licencias de código abierto compatibles (MIT, Apache 2.0, Creative Commons).
- **Optimización de Rendimiento**: Reducir el tamaño del APK de ~890 MB a menos de ~45 MB mediante streaming bajo demanda con caché local usando `extended_image`.

---

## 2. Fuentes de Contenido Libre de Derechos y Creación Propia

### Opción A: Bases de Datos Open Source (Gratuito e Inmediato)
1. **ExerciseDB (RapidAPI / GitHub)**
   - Más de 1.300 ejercicios clasificados por grupo muscular, equipo y dificultad.
   - Incluye animaciones y GIFs demostrativos de código abierto.
   - Repositorio y documentación: [ExerciseDB en GitHub](https://github.com/yuhonas/free-exercise-db)
2. **Wger (Workout Manager Open Source)**
   - Proyecto maduro bajo licencia AGPL / Creative Commons.
   - API REST completa con imágenes anatómicas e ilustraciones de ejercicios.
   - Catálogo: [wger.de](https://wger.de/en/software/features)

### Opción B: Generación con Modelos 3D e IA (Identidad Visual Exclusiva)
1. **Modelos 3D en Blender**:
   - Usar un maniquí anatómico neutro (estilo minimalista, tecnológico o monocromático).
   - Renderizar animaciones de 3 a 5 segundos por ejercicio.
   - **Formato recomendado**: Exportar en **WebP animado** o **MP4 en loop** (reducen el peso entre un 70% y 85% comparado con GIF tradicional).
2. **Generación Asistida por IA**:
   - Generación de portadas de planes y categorías con Midjourney, Flux o Stable Diffusion.
   - Mantener un prompt maestro (estilo visual, paleta de colores, iluminación) para consistencia de marca.

---

## 3. Arquitectura del Catálogo y Formato de Datos

El archivo base de datos de la aplicación se encuentra en:
`assets/data/exercise_catalog.json`

Estructura de cada ejercicio:
```json
{
  "id": 1826,
  "name": "Fondos en Banco",
  "description": "Explicación detallada de la ejecución.",
  "focusMuscleGroup": "triceps",
  "techniqueVideoURL": "https://cdn.tu-dominio.com/videos/1826.mp4",
  "thumbnailURL": "https://cdn.tu-dominio.com/exercises/1826.webp",
  "exerciseType": "weightAndReps",
  "machineCodes": ["flat_bench"],
  "instructions": "1. Siéntate en el banco...\n2. Baja el cuerpo flexionando los codos...",
  "rankingEligible": true
}
```

---

## 4. Paso a Paso para la Migración

### Paso 1: Estandarización de Archivos
Nombrar los nuevos recursos utilizando el `id` numérico del ejercicio en el catálogo:
- Animaciones: `exercises/<id>.webp` (ejemplo: `101.webp`, `1826.webp`)
- Portadas de Planes: `plans/<slug>.webp` (ejemplo: `push_pull_legs.webp`)
- Videos de Técnica (opcionales): `videos/<id>.mp4`

### Paso 2: Despliegue del Almacenamiento en la Nube (CDN)
1. **Cloudflare R2** (Recomendado):
   - Compatible con la API S3 de AWS.
   - **0 costo por transferencia de datos (Egress gratis)**.
   - 10 GB de almacenamiento mensual sin costo.
2. **Subida de Archivos**:
   ```bash
   # Sincronización con bucket R2 / S3
   aws s3 sync ./nuevos_assets/ s3://tu-bucket-fitness/public/ \
     --endpoint-url https://<account_id>.r2.cloudflarestorage.com
   ```
3. Asociar un dominio o subdominio propio con SSL:
   `https://cdn.tu-app-fitness.com/`

### Paso 3: Script para Actualizar el Catálogo
Ejecutar un script en Python o Node.js para actualizar masivamente las URLs del catálogo hacia tu propio dominio:

```python
import json

CDN_BASE_URL = "https://cdn.tu-app-fitness.com"

with open("assets/data/exercise_catalog.json", "r", encoding="utf-8") as f:
    catalog = json.load(f)

for exercise in catalog:
    eid = exercise["id"]
    exercise["thumbnailURL"] = f"{CDN_BASE_URL}/exercises/{eid}.webp"
    if exercise.get("techniqueVideoURL"):
        exercise["techniqueVideoURL"] = f"{CDN_BASE_URL}/videos/{eid}.mp4"

with open("assets/data/exercise_catalog.json", "w", encoding="utf-8") as f:
    json.dump(catalog, f, indent=2, ensure_ascii=False)

print("Catálogo actualizado con el CDN propio.")
```

---

## 5. Integración Móvil y Caché

La aplicación ya utiliza el widget [`SymmetryExtendedImage`](../lib/core/widgets/symmetry_extended_image.dart) basado en `extended_image`. Este componente:
- Detecta automáticamente si la ruta es local (`assets/...`) o remota (`https://...`).
- Descarga y guarda en caché de disco y memoria en el dispositivo del usuario.
- Muestra indicadores de carga y placeholders fluidos sin bloquear la interfaz.

---

## 6. Checklist Previo al Lanzamiento Comercial

- [ ] Reemplazar la marca ("Symmetry") por el nombre y marca propios.
- [ ] Sustituir los logos vectoriales (`assets/symmetry_logo.svg`, `symmetry_letters_logo.svg`).
- [ ] Reemplazar todos los GIFs y portadas por los nuevos archivos en Cloudflare R2 / S3.
- [ ] Configurar el backend (Node.js / Go / Supabase / Firebase) con los endpoints de sincronización de usuario y rutinas.
- [ ] Ejecutar `flutter build apk --release` y `flutter build appbundle --release` con el bundle liviano final (~40-50 MB).
