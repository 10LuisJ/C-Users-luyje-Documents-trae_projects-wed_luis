# Sitio romántico

## Estructura
- `index.html` redirige a `romantica.html`
- `romantica.html` proyecto principal (HTML, CSS y JS)
- `assets/` música y fotos
- `.nojekyll` desactiva Jekyll en GitHub Pages

## Subir a GitHub
1. Crea un repositorio vacío en GitHub (por ejemplo: `wed-luis`).
2. En PowerShell, dentro de esta carpeta:

```powershell
git config user.name "10LuisJ"
git config user.email "achocachayluisjesus@gmail.com"
git init
git add .
git commit -m "Inicializa sitio romántico"
git branch -M main
git remote add origin https://github.com/10LuisJ/wed-luis.git
git push -u origin main
```

## Publicar en GitHub Pages (rama)
1. Abre el repositorio en GitHub > Settings > Pages.
2. En “Build and deployment”, elige “Deploy from a branch”.
3. Branch: `main`, Folder: `/ (root)`.
4. Guarda. Tu sitio quedará en `https://10LuisJ.github.io/wed-luis/`

## Publicar con GitHub Actions (opcional)
Si prefieres Actions, activa Pages desde Actions > `pages-build-deployment`. Para este sitio estático no hace falta.

## Nota de música
La página intenta reproducir música de `assets/` con nombres comunes. También puedes configurar un enlace desde el botón “Configurar fotos”.

## Google Drive
Usa “Configurar fotos” para pegar enlaces de Drive. Asegura que cada archivo esté compartido como “Cualquiera con el enlace: Lector”.
# C-Usuarios-luyje-Documentos-proyectos_de_trabajo-wed_luis
# C-Usuarios-luyje-Documentos-proyectos_de_trabajo-wed_luis
# C-Usuarios-luyje-Documentos-proyectos_de_trabajo-wed_luis
