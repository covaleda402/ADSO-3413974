# 📘 Cómo hacer un Commit en GitHub desde Visual Studio Code

Este manual explica paso a paso cómo realizar un **commit y subir
cambios a GitHub usando la terminal de Visual Studio Code**.

------------------------------------------------------------------------

## 📌 Requisitos

Antes de comenzar necesitas tener instalado:

-   Git\
-   Visual Studio Code\
-   Una cuenta en GitHub

Para verificar que Git está instalado ejecuta:

``` bash
git version
```

------------------------------------------------------------------------

# 1️⃣ Abrir el proyecto en Visual Studio Code

1.  Abre tu carpeta de proyecto en **Visual Studio Code**.
2.  Abre la terminal integrada:

Terminal → New Terminal

O usa el atajo:

    Ctrl + ñ

------------------------------------------------------------------------

# 2️⃣ Inicializar Git en el proyecto

Si tu proyecto aún no tiene Git inicializado ejecuta:

``` bash
git init
```

Esto creará un repositorio Git dentro de la carpeta del proyecto.

------------------------------------------------------------------------

# 3️⃣ Verificar los cambios en el proyecto

Para ver los archivos modificados escribe:

``` bash
git status
```

Este comando mostrará:

-   Archivos modificados
-   Archivos nuevos
-   Archivos listos para commit

------------------------------------------------------------------------

# 4️⃣ Agregar archivos al área de preparación (stage)

Para agregar **todos los archivos**:

``` bash
git add .
```

Para agregar **un archivo específico**:

``` bash
git add nombre-del-archivo
```

------------------------------------------------------------------------

# 5️⃣ Crear un commit

Para guardar los cambios en el historial del proyecto usa:

``` bash
git commit -m "mensaje del commit"
```

Ejemplo:

``` bash
git commit -m "Agrega archivo README"
```

Un **commit** es un registro de los cambios realizados en el proyecto.

------------------------------------------------------------------------

# 6️⃣ Conectar el proyecto con GitHub (solo la primera vez)

Primero crea un repositorio en GitHub.

Luego conecta tu proyecto con el repositorio remoto:

``` bash
git remote add origin https://github.com/usuario/repositorio.git
```

------------------------------------------------------------------------

# 7️⃣ Subir los cambios a GitHub

Para enviar el commit al repositorio remoto:

``` bash
git push origin main
```

Si la rama principal es **master**:

``` bash
git push origin master
```

------------------------------------------------------------------------

# 🔄 Flujo básico de trabajo

Normalmente trabajarás usando estos comandos:

``` bash
git status
git add .
git commit -m "mensaje"
git push
```

------------------------------------------------------------------------

# 📊 Resumen de comandos

  Comando         Función
  --------------- -----------------------
  git init        Inicializa Git
  git status      Muestra cambios
  git add .       Agrega archivos
  git commit -m   Guarda cambios
  git push        Sube cambios a GitHub

------------------------------------------------------------------------

# ✅ Buenas prácticas para commits

Escribe mensajes claros y descriptivos, por ejemplo:

-   Agrega página de inicio
-   Corrige error en formulario
-   Actualiza estilos CSS

⭐ **Tip:** Haz commits pequeños y frecuentes para mantener un historial
claro del proyecto.
