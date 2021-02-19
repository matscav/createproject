# Instalación
1. Clonar el proyecto o descargarlo
```bash
git clone git@github.com:matscav/createproject.git createproject
```
2. Asignar permisos al archivo
```bash
chmod a+x createproject.sh
```
3. Guardar en /usr/local/bin para usar en consola (testeado solo en Debian)
```bash
sudo ln -s /path/to/file/createproject.sh /usr/local/bin/createproject
```

# Uso
Ahora simplemente desde consola llamamos a:
```bash
createproject
```
O si no lo hemos añadido al path, desde la carpeta donde lo tengamos:
```bash
./createproject.sh
```