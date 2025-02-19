# GSudo GUI

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)
[![es](https://img.shields.io/badge/lang-es-green.svg)](README.es.md)

Este script de AutoHotKey proporciona una interfaz gráfica a la ejecución de comandos habituales para los que se requiera la elevación de privilegios para sistemas que trabajen con el Ivanti Application Control. Adicionalmente rellena de forma automática el cajetín de ITM donde se nos pregunta para qué queremos realizar esa acción. Este texto podrá ser personalizado para cada acción y modificado por el usuario.

Hace uso de una versión de GSudo específica para estos sistemas que se encuentra en [https://github.com/nicerloop/ivanti-self-elevate](https://github.com/nicerloop/ivanti-self-elevate).

A continuación se describirán los pasos para instalar esta aplicación así como todas las dependencias necesarias.

## Instalación y Actualización

En este primer bloque se ha añadido una guía rápida tanto para instalar por primera vez como para actualizar la aplicación GSudo GUI.

### Instalación

- Clonar este repositorio.
- Descargar el fichero "gsudo.exe" que se encuentra en [https://github.com/nicerloop/ivanti-self-elevate](https://github.com/nicerloop/ivanti-self-elevate) y añadirlo en la misma carpeta donde se ha clonado el repositorio o bien añadirlo al PATH del sistema
- Descargar e instalar AutoHotKey 2.X desde: [https://www.autohotkey.com/download/](https://www.autohotkey.com/download/).
  - Si funciona la instalación desde el fichero ejecutable elevando privilegios, perfecto.
  - Se han detectado situaciones con algunas versiones que el antivirus da problemas. Para ello, es posible que funcione descargar el ZIP de AutoHotKey, descomprimirlo y, en línea de comandos desde donde hayamos clonado el repositorio (y por lo tanto donde esté el gsudo.exe), ejecutar (modificando XX por la versión descargada):

```
gsudo C:\Users\<USUARIO>\Downloads\AutoHotkey_2.0.XX\AutoHotkey64.exe C:\Users\<USUARIO>\Downloads\AutoHotkey_2.0.XX\ux\ui-setup.ahk
```

- Copiar el fichero "gsudo-gui-config.ahk.template" como "gsudo-gui-config.ahk" y modificar los valores de los parámetros:

  - LANG: Idioma en el que queremos usar GSudo GUI. Actualmente admite dos valores ES (español) y EN (inglés). Por defecto el interfaz se mostrará en inglés.
  - SHOW_DEV: Mostrar enlaces a comandos que no están lo suficientemente probados. No se ofrece soporte de ningún tipo sobre los mismos. Por defecto está a false.
  - NVM_PATH: Ruta del ordenador donde se encuentren las distintas versiones de Node instaladas. Es necesario definiarla si queremos a usar la opción de cambiar versión de node.
  - WAITTIMEKEY: Tiempo en milisegundos que transcurre antes de que se presione de forma automática al botón de "Aceptar" de la ventana de elevación de privilegios. Por defecto 2000ms.
  - GUICOLS: Número de columnas que tendrá el GUI. Por defecto 6.
  - AUT_SYSTEM_ACTIVE: Sistema automático rellenará con un texto por defecto o con el contenido del portapapeles de Windows si tiene menos de 100 caracterescualquier ventana de "ITM - Application Control". Por defecto: false.
  - WAITTIMEAUT: Tiempo en milisegundos que transcurre antes de que se presione de forma automática al botón de "Aceptar" de la ventana de elevación de privilegios exceptuando en las ventanas abiertas por esta aplicación. Por defecto 5000ms.
  - DEFAULT_TEXT: Texto usado en las ventanas de elevación de privilegios exceptuando en las abiertas por este programa. Por defecto: "Actualizar aplicación".
  - Se pueden añadir parámetros _HOTKEY_HIDE_ para que no se muestren opciones en la interfaz (ej: HOTKEY_HIDE_DeleteFiles := true). En el listado de funciones se muestra el nombre que hay que usar.
  - Adicionalmente en el fichero de configuración se pueden sobreescribir la tecla rápida por defecto para las acciones (ej: HOTKEY_DiskManager := "#^d"). En el listado de funciones de la documentación se muestra el nombre que hay que usar para sobrescribir la función así como la tecla predeterminada.
  - Se puede sobreescribir cualquier literal en el fichero de configuración, para encontrar la variable a añadir, esta se encuentra en el fichero "gsudo-gui.lang.ahk".

- Si todo ha ido bien, haciendo doble click sobre el fichero "gsudo-gui.ahk" se nos ejecuta.
- _(Opcional)_ Si queremos que el script se ejecute siempre al inicio del sistema, debemos añadir un acceso directo a "gsudo-gui.ahk" en la ruta:

```
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
```

### Actualización

Si ya tenemos AutoHotKey y gsudo.exe en nuestro ordenador, los pasos a seguir son:

- Actualizar el repositorio.
- Revisar que no hay parámetros nuevos en "gsudo-gui-config.ahk.template". En caso de que los haya, incluirlos en nuestro ""gsudo-gui-config.ahk".
- Doble click sobre el fichero "gsudo-gui.ahk".

## GSudo

Esta versión de GSudo (existen otras) es una aplicación que nos permite, por línea de comandos, solicitar una elevación de privilegios para sistemas que trabajen con el Ivanti Application Control.

La aplicación se encuentra en:
[https://github.com/nicerloop/ivanti-self-elevate](https://github.com/nicerloop/ivanti-self-elevate)

Ejecutar llamando a:

```
$ gsudo aplicación parámetros
```

Ejemplos:

```
$ gsudo notepad C:\Windows\System32\drivers\etc\hosts <- Abre el fichero hosts en el bloc de notas con permisos de Administrador

$ gsudo "C:\Program Files\Notepad++\notepad++" C:\windows\system32\drivers\etc\hosts <- Abre el fichero hosts en el Notepad++ con permisos de Administrador
```

**Importante:** Salvo que el programa a ejecutar esté en el path del sistema (como el notepad), escribir siempre la ruta completa al mismo.

Se nos abre una ventana solicitando el motivo por el cual queremos realizar la elevación de privilegios.

## AutoHotKey

AutoHotKey es un lenguaje de programación de scripts para automatizar tareas en Windows.

Podemos encontrar mucha más documentación sobre esta herramienta en:
[https://www.autohotkey.com/](https://www.autohotkey.com/)

Es importante destacar que los scripts creados con la versión 1.X no son compatibles con los de la 2.X. GSudo GUI ha sido creado con AutoHotKey 2.X.

Para instalar un script y que se ejecute siempre al inicio del sistema debemos añadir un enlace directo al fichero en nuestra carpeta de inicio que se encuentra en:

```
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup (para el usuario actualmente conectado)

%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup (para todos los usuarios)
```

Lo habitual en este caso es añadirlo a nuestro usuario.

## GSudo GUI

Con ambas utilidades se ha creado un script denominado "gsudo-gui.ahk" que podemos, bien invocar cada vez que queramos usarlo, bien añadirlo (según ha sido descrito anteriormente) al inicio del sistema para nuestro usuario.

Una vez ejecutado, disponemos de las siguientes combinaciones de teclas para invocar al "gsudo" con distintas acciones habituales que requieren elevación de permisos. No tendremos entonces que rellenar el cajetín salvo que queramos modificar el texto predefinido. De forma automática se añade un texto y presiona al botón "Aceptar".

Las combinaciones de teclas son:

- #: Windows
- ^: Ctrl
- +: Mays

Con conocer la primera de ellas: \
&nbsp;&nbsp;&nbsp;&nbsp;Win + Ctrl + ? \
Tendremos la ayuda de la aplicación, por lo que será suficiente.

- #^?: Ayuda: muestra este listado de opciones.
- #^g: Ejecutar GUI de GSudo.
- #^c: CMD con permisos de Administrador (CMD).
- #^o: POWERSHELL con permisos de Administrador (Powershell).
- #^h: Ejecutar NOTEPAD con el fichero de hosts (Hosts).
- #^e: Propiedades del Sistema (Environment).
- #^p: Panel de Control (ControlPanel).
- #^w: Actualiza los paquetes con Winget (Winget). Esta es una opción de desarrollo. Actualmente para mantener los paquetes actualizados se recomienda el uso de [UniGetUI](https://www.marticliment.com/unigetui/) que se integra con gsudo.
- #^a: Modificar versión Node (Angular).
- #^s: Gestionar servicios del sistema (Services).
- #^d: Administrar los discos de Windows (DiskManager).
- #^f: Configurar el Firewall (Firewall).
- #^r: Registro de Windows (Registry).
- #^q: Borra los ficheros del usuario Public (DeleteFiles).
- #^l: Limpia, repara y optimiza el sistema (Maintenance).
- #^z: Abrir Navegador como Administrador (Browser).
- #^t: Abrir el Gestor de Tareas (TaskManager).
- #^u: Fuerza Windows Update (SystemUpdate).
- #^m: Abrir MS Store (MSStore). Esta es una opción de desarrollo.
- #^i: Liberar espacio en disco (FreeSpace).
- #^n: Actualizar fecha y hora (TimeDate).
- #^j: Actualizar Java (JavaUpdate). Esta es una opción de desarrollo.
- #^v: Abrir OpenVPN (OpenVPN).
- #^5: Actualizar VPN F5 (VPNUpdate). Esta es una opción de desarrollo.
- #^b: Muestra el serial del Bitlocker (Bitlocker).

- #c: Solo se usa con AUT_SYSTEM_ACTIVE. Cancela el sistema.
- #s: Solo se usa con AUT_SYSTEM_ACTIVE. Reactiva el sistema.
- ^f: Rellena ventana ITM con texto por defecto.
- ^b: Rellena ventana ITM con contenido del portapapeles.

### Programar Nueva Funcionalidad

Si queremos añadir una nueva funcionalidad al script deberemos añadir el nombre de la misma al array _Apps_ en la posición en la que queramos que se muestre.

Ejemplos:

```
Apps.Push("Firewall")
Apps.Push("Registry")
```

Una vez añadido el nombre de la nueva funcionalidad (la denominaremos [FUNC]), deberemos realizar las siguientes acciones:

- Crear un nuevo método que recoja la funcionalidad. El nombre del método debe siempre ser _GSudo[FUNC]_, por ejemplo "GSudoCMD" o "GSudoFirewall". Como utilidad para crear nuevas funcionalidades tenemos la función "LaunchGsudoApp" que recibe dos parámetros obligatorios y uno opcional. El primero será el script a invocar con "gsudo". El segundo depende de si hemos definido en el fichero de literales la cadena **STR_ITM**. En caso afirmativo, podemos añadir solamente el nombre de la nueva función [FUNC]. En caso negativo usaremos el tercer parámetro para añadir el texto a poner en la ventana de la elevación de privilegios. Como ejemplo de una funcionalidad simple tenemos "GSudoCMD" y como ejemplo de una funcionalidad donde se nos muestra un menú de opciones posterior tenemos "GSudoBrowser".
- Añadir una imagen dentro de la carpeta "img". Debe estar en formato png, preferiblemente con fondo transparente y medidas 100x100 o superior. El nombre de esa imagen será [FUNC].png, siempre en letras minúsculas.
- Añadir al fichero "gsudo-gui.hotkeys.ahk" la tecla rápida predefinida para el acceso mediante una variable de la forma **HOTKEY\_[FUNC]** (ej: HOTKEY_Firewall := "#^f").
- Añadir al fichero "gsudo-gui.isdev.ahk" si queremos considerar esta acción como en desarrollo mediate una variable de la forma **IS_DEV\_[FUNC]** (ej: IS_DEV_Firewall := false).
- Añadir al fichero "gsudo-gui.lang.ahk" los literales necesarios para internacionalizar la nueva acción. Es imprescindible añadir al menos **[LANG]\_STR_GUI\_[FUNC]** con el nombre de la nueva funcionalidad. Es aconsejable añadir **[LANG]\_STR_HELP\_[FUNC]** con la descrición larga. Si se quiere que se use el mismo valor que el parámetro anterior podemos poner la cadena vacía. También se recomienda añadir aquí el valor **[LANG]\_STR_ITM\_[FUNC]** con el texto que se usará para rellenar el cajetín al invocar la elevación de privilegios.

Todos los iconos usados en la aplicación han sido obtenidos de [Icons8](https://icons8.com/).
