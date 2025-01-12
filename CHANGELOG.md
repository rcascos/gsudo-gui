# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.1] - 2025-01-10

### Added

- New option to Open OpenVPN.

### Fixed

- Removed duplicate variable IS_DEV_Bitlocker := false

## [2.0.0] - 2024-10-24

### Added

- Externalization of texts to be able to perform localization. Spanish and English languages are added.
- Externalization of ALL hotkeys to a file.
- Because of externalization of texts and hotkeys, all of them can be overwritten in config file.
- New "IS_DEV" set of variables for all the functions.
- New "LANG" (EN, ES) and "SHOW_DEV" (false, true) variables in the configuraton file.
- Not neccesary to configure NVM_PATH if it nvm is installed in the default path.
- Refactoring of the Applications array so that it only has one parameter, the name of the functionality. All of the other parameters (hotkey, texts and image) are located through that name.
- New "AUT_SYSTEM_ACTIVE" ("WAITTIMEAUT_CUSTOM", "DEFAULT_TEXT") variables to start and control an automatic system which will fill any ITM - Application Control window with the content of the clipboard if less than 100 characters or with a default text.
- New hotkeys to fill any ITM - Application Control box with default text or text in clipboard.
- All icons used in the application have been changed and the new ones obtained from [Icons8](https://icons8.com/).

### Changed

- README has been almost completely rewritten, there is now a version in Spanish and another one in English (default version).
- CHANGELOG has been translated into English.
- "WaitTimeKeyC" and "GuiColsC" variables in the config file have been renamed into "WAITTIMEKEY" and "GUICOLS".

### Removed

- HOTKEY_OVERWRITE variables in the configuration file. The same functionality can be obtained by using the HOTKEY variables.

## [1.9] - 2024-07-19

### Added

- Ability to hide options by using the configuration file (HOTKEY_HIDE).

### Changed

- In Winget, when there are no applications to update, show the appropriate message.

## [1.8] - 2024-06-25

### Added

- Possibility to overwrite the hotkey for accessing functions using the configuration file (HOTKEY_OVERWRITE).

### Changed

- Removed the configuration file and added a template with parameters to avoid overwriting user-defined parameters.

## [1.7.2] - 2024-06-21

### Fixed

- Updated documentation.

## [1.7.1] - 2024-06-20

### Fixed

- In Winget, fixed the behavior of the "update all applications" checkbox so that it unchecks other selected options.

## [1.7] - 2024-06-18

### Fixed

- Improvements in Winget handling.
- Order in which nvm use versions are displayed.

## [1.6] - 2024-04-07

### Added

- Option to update all applications (if possible) with Winget.

### Changed

- All hotkeys have been changed to reduce the possibility of conflicts with other applications. Now all of them start with Windows + Ctrl.
- Added an icon to the application.

## [1.5] - 2024-04-01

### Added

- New option to manage system services.

### Changed

- Default key for deleting files from the Public folder.

## [1.4] - 2024-03-18

### Fixed

- Fixed an issue with deleting files from the Public folder when they have spaces in their names.

## [1.3] - 2024-03-10

### Added

- New option to switch between installed versions of node (as long as the computer has "nvm").

### Changed

- Extraction of variables to a configuration file.

## [1.2] - 2024-02-23

### Added

- Show a generic image if the specific image is not found.

### Changed

- Code refactoring so that hotkeys are generated from the Applications array.
- Code refactoring and file names so that the image has the identifier of the script to be invoked as its name.
- Added instructions to the README file for adding new functionalities.
- Default key for updating F5 VPN.

## [1.1] - 2024-02-22

### Added

- New option to open browsers with admin privileges.
- Added a CHANGELOG file.

### Fixed

- Operation with different DPI in monitor settings.

### Changed

- Default key for Firewall.
- Application installation and update instructions.

## [1.0] - 2024-02-20

### Added

- Initial version of the application.
