#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
fullPath=`pwd`
gitignore="node_modules/\ndist/\nbuild/\n.cache/\n.parcel-cache/\n.vscode/"
stylelint="{\n \"extends\": \"stylelint-config-standard\",\n \"rules\": {}\n}"
eslint="module.exports = {\n  env: {\n    browser: true,\n    es2021: true\n  },\n  extends: [\n    'standard'\n  ],\n  parserOptions: {\n    ecmaVersion: 12,\n    sourceType: 'module'\n  },\n  rules: {}\n}"

read -p "Introduzca nombre del proyecto: " newproject

if [ -d "$newproject" ]
then
    echo "${red}ERROR!!!${reset} ---> El directorio especificado ya existe"
else
    # Creamos carpeta
    echo "Creando estructura de carpetas..."
    `mkdir -p $newproject/{src/css,src/js,dist}`
    echo "${green}Directorios creados${reset}"
    
    #Creamos archivos básicos
    echo "Creando archivos..."
    `touch $newproject/src/index.html $newproject/src/css/index.css $newproject/src/js/index.js`
    echo "${green}Archivos creados${reset}"
    
    #Nos movemos a la carpeta
    cd "${fullPath}/${newproject}"
    
    #Inicializamos un repositorio vacío
    echo "Inicializando git..."
    git init
    echo "${green}Git Inicializado${reset}"
    
    #Creamos gitignore con archivos y carpetas comunes
    echo "Creando gitignore..."
    touch .gitignore
    echo -e $gitignore >> .gitignore
    echo "${green}gitignore creado${reset}"

    #Inicializamos el proyecto con npm y comprobamos
    npm init -y
    
    #Instalamos stylelint, eslint, ghpages y parcel
    npm install -D stylelint stylelint-config-standard eslint eslint-config-standard eslint-plugin-import eslint-plugin-node eslint-plugin-promise parcel-bundler gh-pages
    
    #Config stylelint 
    touch .stylelintrc
    echo -e $stylelint >> .stylelintrc
    
    #Config eslint
    touch .eslintrc.js
    echo -e $eslint >> .eslintrc.js

    echo "${green}NPM: paquetes instalados y configurados${reset}"

    #Reemplazamos scripts
    #scripts="\"start\": \"parcel serve src/index.html\",\n \"build\": \"rm -rf build && parcel build -d build --public-url /${newproject}/ src/index.html\",\n \"deploy\": \"rm -rf build && parcel build -d build --public-url /${newproject}/ src/index.html && gh-pages -d build\""
    #TODO: Reemplazar scripts en package.json con sed o awk

    #Añadimos remote git y dejamos preparado
    read -p "Añadir git remoto?(y,n): " repoUrl

    if [[ "$repoUrl" == "y" ]]; then
        git add .
        git commit -m "Initial Commit"
        git branch -M main
        read -p "Introduzca url de repositorio: " repoUrl
        `git remote add origin $repoUrl`
        git push -u origin main
    fi

    echo "${green}Proceso completado, invitame a una caña${reset}"

fi