# Memoria Practica 7 CIU - Prototipo gráficos y síntesis de sonido
Creado por Marco Nehuen Hernández Abba

![gif](https://user-images.githubusercontent.com/47418876/160251955-14160b19-f4a9-4a32-8c1a-dc230e4bb14c.gif)

### Contenido
- Trabajo realizado
- Herramientas y Referencias

## Trabajo realizado
Esta aplicación genera circurferencias con el click izquierdo y el derecho, estos se expanden y si tocan alguna parte del centro, genera un sonido.
Tiene diversos modos de generacion de sonido y velocidad de expansión de la circunferencia.

**Interfaz**

![image](https://user-images.githubusercontent.com/47418876/160292425-21c0351f-7dea-4218-9050-a78c06f85a44.png)

Inicialmente tenemos una pantalla de warning, creada por muchas funciones tipo text()
En la pantalla principal, disponemos en la esquina super izquierda dos visaulizaciones, una de modo y otra de velocidad,
debajo los controles para el tipo de circunferencia.

Al lado del raton tenemos tambien los dos tipos de notas que se pueden crear cuando hace interaccion con el centro.

**Sonido**

Cuando la circunferencia toca el centro, se genera un sonido, esto se puede hacer con la clase que hay en el ejemplo de [Minim](https://code.compartmental.net/minim/instrument_instrument.html) con una pequeña modificacion con los diferentes modos

```
   switch (modo){
      case 0:
      wave   = new Oscil( frequency, 0, Waves.PHASOR );
      break;
      case 1:
      wave   = new Oscil( frequency, 0, Waves.QUARTERPULSE );
      break;
      case 2:
      wave   = new Oscil( frequency, 0, Waves.SAW );
      break;
      case 3:
      wave   = new Oscil( frequency, 0, Waves.SINE );
      break;
      case 4:
      wave   = new Oscil( frequency, 0, Waves.SQUARE );
      break;
      case 5:
      wave   = new Oscil( frequency, 0, Waves.TRIANGLE );
      break;
    }
```

### Herramientas y referencias

**Herramientas**

-[Minim](https://code.compartmental.net/minim/index.html): Libreria de audio

-[ezgif](https://ezgif.com/): Creacion de gif faciles

**Referencias**

Libreria de Minim

[Guia de la practica 7](https://github.com/otsedom/otsedom.github.io/blob/main/CIU/P7/README.md)

[Icono advertencia](https://www.freeiconspng.com/img/2766)
