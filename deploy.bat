@echo off
setlocal

REM Nom du fichier WAR genere par Maven dans target
set APP_NAME=Bibliotheque.war

REM Dossier target (Maven)
set TARGET_DIR=target

REM Dossier de deploiement Tomcat (à adapter)
set TOMCAT_WEBAPPS=C:\xampp\tomcat\webapps

REM Verifier si le WAR existe dans target
if not exist %TARGET_DIR%\%APP_NAME% (
    echo ERREUR : Le fichier %APP_NAME% n'existe pas dans %TARGET_DIR%.
    echo Pense a faire 'mvn clean package' avant.
    exit /b 1
)

REM Copier le WAR vers Tomcat
echo Copie de %APP_NAME% vers Tomcat...
copy /Y %TARGET_DIR%\%APP_NAME% %TOMCAT_WEBAPPS%

echo Deploiement termine. Pense a redemarrer Tomcat si necessaire.

endlocal
