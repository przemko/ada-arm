# ada-arm
Przykłady programów w języku Ada na architekturę STM32.

## Instalacja sterowników

W katalogu ada-arm należy zainstalować aktualną wersję sterowników:

```bash
cd ada-arm
git clone --recursive https://github.com/AdaCore/Ada_Drivers_Library.git
```

## Aktualizacja sterowników

```bash
cd ada-arm
cd Ada_Drivers_Library
git pull
```

## Przygotowanie narzędzi do komunikacji z urządzeniami

### Linux/Debian/Ubuntu

```bash
sudo apt install stlink-tools
```
