# ada-arm
Przykłady programów w języku Ada na architekturę STM32.

## Instalacja kompilatora

Zainstalować ze strony [adacore.com/download](https://www.adacore.com/download) następujące oprogramowanie:

1. GNAT Community x86 GNU Linux
2. GNAT Community ARM ELF (hosted on linux64)

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

### Linux Debian/Ubuntu

```bash
sudo apt install stlink-tools
```
