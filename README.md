# GSudo GUI

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)
[![es](https://img.shields.io/badge/lang-es-green.svg)](README.es.md)

This AutoHotkey script provides a graphical user interface for executing usual commands that require elevated privileges on systems running Ivanti Application Control. Additionally, it automatically populates the ITM dialog box that asks for the reason for performing the action. This text can be customized for each action and modified by the user.

It uses a version of GSudo specifically designed for these systems, which can be found at [https://github.com/nicerloop/ivanti-self-elevate](https://github.com/nicerloop/ivanti-self-elevate)..

The following steps will describe how to install this application and all the necessary dependencies.

## Installation and Update

In this initial section, a quick guide for the initial installation and updating of the GSudo GUI application has been included.

### Installation

- Clone this repository.
- Download the "gsudo.exe" file from [https://github.com/nicerloop/ivanti-self-elevate](https://github.com/nicerloop/ivanti-self-elevate) and place it in the same folder where you cloned the repository or add it to your system's PATH.
- Download and install AutoHotkey 2.X from: [https://www.autohotkey.com/download/](https://www.autohotkey.com/download/).
  - If the executable installation works with elevated privileges, that's perfect.
  - Some versions have been reported to cause issues with antivirus software. In this case, you might try downloading the AutoHotkey ZIP file, extracting it, and, from the command prompt where you cloned the repository (and therefore where gsudo.exe is located), run the following command (replacing XX with the downloaded version):

```
gsudo C:\Users\<USUARIO>\Downloads\AutoHotkey_2.0.XX\AutoHotkey64.exe C:\Users\<USUARIO>\Downloads\AutoHotkey_2.0.XX\ux\ui-setup.ahk
```

- Copy the file "gsudo-gui-config.ahk.template" as "gsudo-gui-config.ahk" and modify the parameter values:

  - LANG: The language in which you want to use GSudo GUI. Currently, it supports two values: ES (Spanish) and EN (English). By default, the interface will be displayed in English.
  - SHOW_DEV: Show links to functions that are not sufficiently tested. No support of any kind is offered for these. Default value: false.
  - NVM_PATH: Path on the computer where the different installed Node versions are located. It is necessary to define it if you want to use the option to change the Node version.
  - WAITTIMEKEY: Time in milliseconds that elapses before the "Accept" button in the privilege elevation window is automatically pressed. Default value: 2000ms.
  - GUICOLS: Number of columns in the GUI. Default value: 6.
  - AUT_SYSTEM_ACTIVE: Automatic system will fill with a default text or with the content of the clipboard if less than 100 characters any "ITM - Application Control" window. Default value: false.
  - WAITTIMEAUT: Time in milliseconds that elapses before the "Accept" button in the privilege elevation window is automatically pressed when used for any other elevation but those specific for this program. Default value: 5000ms.
  - DEFAULT_TEXT: Default text used in the privilege elevation window when used for any other elevation but those specific for this program. Default value: "Update application".
  - _HOTKEY_HIDE_ parameters can be added to hide options from the interface (e.g., HOTKEY_HIDE_DeleteFiles := true). The list of functions below shows the names to use.
  - Additionally, the default hotkey for actions can be overwritten in the configuration file (e.g., HOTKEY_DiskManager := "#^d"). The documentation's function list shows the name to use to override the function as well as the default key.
  - Any literal can be overwritten in the configuration file. To find the variable to add, look in the file "gsudo-gui.lang.ahk".

- If everything went well, double-clicking the 'gsudo-gui.ahk' file will execute it.
- _(Optional)_ If you want the script to run at system startup, you must add a shortcut to 'gsudo-gui.ahk' in the following path:

```
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
```

### Update

If we already have AutoHotkey and gsudo.exe on our computer, the steps to follow are:

- Update the repository.
- Check that there are no new parameters in "gsudo-gui-config.ahk.template". If there are, include them in your "gsudo-gui-config.ahk".
- Double-click the "gsudo-gui.ahk" file.

## GSudo

This version of GSudo (there are others) is an application that allows us to request, via command line, a privilege escalation for systems that work with Ivanti Application Control.

You can find the application at:
[https://github.com/nicerloop/ivanti-self-elevate](https://github.com/nicerloop/ivanti-self-elevate)

Execute by running the command:

```
$ gsudo application parameters
```

Examples:

```
$ gsudo notepad C:\Windows\System32\drivers\etc\hosts <- Open the hosts file in Notepad with administrative privileges.

$ gsudo "C:\Program Files\Notepad++\notepad++" C:\windows\system32\drivers\etc\hosts <- Open the hosts file in Notepad++ with administrative privileges.
```

**Important:** Always provide the full path to the program, unless it is located in the system path (such as Notepad)

We are prompted with a window asking for the reason for privilege escalation.

## AutoHotKey

AutoHotKey is a scripting language for automating tasks in Windows.

Much more documentation about this tool can be found at:
[https://www.autohotkey.com/](https://www.autohotkey.com/)

It is important to note that scripts created with version 1.X are not compatible with those of 2.X. GSudo GUI has been created with AutoHotKey 2.X.

To install a script and have it run at system startup, you must add a shortcut to the file in your startup folder, which is located at:

```
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup (para el usuario actualmente conectado)

%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup (para todos los usuarios)
```

It is usually added for the current user in this scenario.

## GSudo GUI

With both utilities, a script named 'gsudo-gui.ahk' has been created. We can either invoke it whenever we need it, or add it to the system startup for our user (as described above).

Once executed, we have the following key combinations to invoke "gsudo" with different common actions that require elevated permissions. We won't have to fill in the text box unless we want to modify the predefined text. Automatically, a text is added and the "Accept" button is pressed.

The key combinations are:

- #: Windows
- ^: Ctrl
- +: Shift

It is only neccesary to know the first one: \
&nbsp;&nbsp;&nbsp;&nbsp;Win + Ctrl + ? \
Because it shows the help of the application.

- #^?: Help: Shows this list of options.
- #^g: Executes the GSudo GUI.
- #^c: Opens a Command Prompt with administrative privileges (CMD).
- #^o: Opens PowerShell with administrative privileges (Powershell).
- #^h: Opens Notepad to edit the hosts file (Hosts).
- #^e: Opens the System Properties dialog, allowing you to view and modify system settings (Environment).
- #^p: Opens the Control Panel (ControlPanel).
- #^w: Updates packages using Winget. This is a development option. For general package management, it's recommended to use [UniGetUI](https://www.marticliment.com/unigetui/), which integrates with gsudo.
- #^a: Changes the Node.js version (often used for Angular development) (Angular).
- #^s: Manage system services (Services).
- #^d: Opens Disk Management (DiskManager).
- #^f: Opens the Windows Firewall settings (Firewall).
- #^r: Opens the Registry Editor (Registry).
- #^q: Deletes files from the Public user's profile (DeleteFiles).
- #^l: Performs system maintenance tasks (Maintenance).
- #^z: Open Browser with administrative privileges (Browser).
- #^t: Opens the Task Manager (TaskManager).
- #^u: Forces Windows to check for updates (SystemUpdate).
- #^m: Opens the Microsoft Store (MSStore). This is a development option.
- #^i: Runs disk cleanup tools (FreeSpace).
- #^n: Opens the Date and Time settings (TimeDate).
- #^j: Updates the Java runtime environment (JavaUpdate). This is a development option.
- #^v: Open OpenVPN (OpenVPN).
- #^5: Updates VPN F5 (VPNUpdate). This is a development option.
- #^b: Displays the BitLocker recovery key (Bitlocker).

- #c: Only used with AUT_SYSTEM_ACTIVE. Cancels system.
- #s: Only used with AUT_SYSTEM_ACTIVE. Activates system.
- ^f: Fills ITM window with default text.
- ^b: Fills ITM window with clipboard.

### Adding New Functionality

If we want to add a new functionality to the script, we should add the name of it to the _Apps_ array in the position where we want it to be displayed.

Examples:

```
Apps.Push("Firewall")
Apps.Push("Registry")
```

Once we've added the name of the new functionality (let's call it [FUNC]), we'll need to perform the following actions:

- Create a new method to encapsulate the functionality. The function must always be named GSudo[FUNC], for example "GSudoCMD" or "GSudoFirewall". As a utility for creating new functionalities, we have the function "LaunchGsudoApp" which takes two mandatory parameters and an optional one. The first will be the script to invoke with "gsudo". The second depends on whether we've defined the string **STR_ITM** in the literals file. If so, we can simply add the name of the new function [FUNC]. Otherwise, we'll use the third parameter to add the text to be displayed in the privilege elevation window. As an example of a simple functionality, we have "GSudoCMD", and as an example of a functionality where a menu of options is shown afterwards, we have "GSudoBrowser".
- Add an image inside the "img" folder. It must be in PNG format, preferably with a transparent background and dimensions of 100x100 pixels or larger. The name of this image will be [FUNC].png, always in lowercase.
- Add a hotkey to the file "gsudo-gui.hotkeys.ahk" using a predefined variable in the format **HOTKEY\_[FUNC]** (e.g., HOTKEY_Firewall := "#^f").
- Add a development flag to the file "gsudo-gui.isdev.ahk" if you want to consider this action as under development, using a variable in the format **IS_DEV\_[FUNC]** (e.g., IS_DEV_Firewall := false).
- Add localization strings to the file "gsudo-gui.lang.ahk". It's essential to add at least **[LANG]\_STR_GUI\_[FUNC]** with the name of the new functionality. It's advisable to add **[LANG]\_STR_HELP\_[FUNC]** with a long description. If you want to use the same value as the previous parameter, you can use an empty string. It's also recommended to add the value **[LANG]\_STR_ITM\_[FUNC]** with the text that will be used to fill the input box when invoking privilege elevation.

All icons used in the application have been obtained from [Icons8](https://icons8.com/).
