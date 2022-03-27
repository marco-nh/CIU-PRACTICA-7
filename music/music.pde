//Basado en el ejemplo de Minim CreateAnInstrument
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

float cirx;
float ciry;
float acc;

//imagenes
PImage lfarrow;
PImage updarrow;
PImage clickd;
PImage clicki;
PImage warning;

//ayuda
boolean ayudaC;
boolean ayudaW;

int modo;

ArrayList<Circle> cir = new ArrayList<Circle>();


// Clase que describe la interfaz del instrumento, idéntica al ejemplo
//Modifcar para nuevos instrumentos
class SineInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;

  SineInstrument( float frequency,int modo )
  {
    // Oscilador sinusoidal con envolvente
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
    
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }

  // Secuenciador de notas
  void noteOn( float duration )
  {
    // Amplitud de la envolvente
    ampEnv.activate( duration, 0.5f, 0 );
    // asocia el oscilador a la salida
    wave.patch( out );
  }

  // Final de la nota
  void noteOff()
  {
    wave.unpatch( out );
  }
}


void setup(){
  size(1000,600,P2D);
  background(255);
  minim = new Minim(this);
  // Línea de salida
  out = minim.getLineOut();
  acc = 5;
  
  lfarrow = loadImage("larrow.png");
  updarrow = loadImage("uparrow.png");
  clicki = loadImage("clicki.png");
  clickd = loadImage("clickd.png");
  warning = loadImage("warning.png");
  
  ayudaC = true;
  ayudaW = true;
}

void draw(){
  background(255);
  if(ayudaW){
    warning();
  } else{
    //interfaz
    gui();
    
    int i = 0;
    for(Circle circ: cir){
      i++;
      circ.inter();
      if(int(circ.getPos()) > width/2 - 5 && int(circ.getPos()) < width/2 + 5){
        fill(255,0,0);
        circ.parar();
        if(circ.getF()){
          sonar(circ,0.0,1);
        } else{
          sonar(circ,0.0,2);  
        }
        
      }
      //print(circ.getPos() + "\n");
    }
    
    line(width/2,0,width/2,height);
    rect(width/2-2.5,height/2,5,5);
    fill(255);
  }
}
void mousePressed(){
  //se hace click, se crea circulo
  if(mouseButton == LEFT){
    cir.add(new Circle(mouseX,mouseY,acc,true));
  } else{
    cir.add(new Circle(mouseX,mouseY,acc,false)); 
    ayudaC = false;
  }
  
}
void keyPressed(){
  if(keyCode == UP){
    if(acc < 5) acc += 0.5;
  }
  if(keyCode == DOWN){
    if(acc > 0.5) acc -= 0.5;
  }
  if(keyCode == LEFT){
    modo--;
    if (modo < 0) modo = 5;
  }
  if(keyCode == RIGHT){
    modo++;
    if (modo > 5) modo = 0;
  }
  if(key == ' '){
    ayudaW = false;  
  }
}
class Circle{
  float x;
  float y;
  float tam;
  float yang;
  float acc;
  boolean inter;
  boolean f;
  
  color col;
  Circle(float x_,float y_,float acc_, boolean f_){
    x = x_;
    y = y_;
    tam = 10;
    acc = acc_;
    inter = false;
    
    f = f_;
    
    col = color(random(255),random(255),random(255));
  }
  void inter(){
    stroke(col);
    float pos = x-2.5;
    noFill();
    tam += acc;
    circle(x,y,tam);
    
    //tam/2
    if(x-2.5 > width/2){
      pos = x-2.5-(tam/2);
    }
    stroke(0);
    
    fill(255);
  }
  float getTam(){
    return tam;  
  }
  float getPos(){
    if(inter == true){
      return 0;
    } else{
      if(x-2.5 > width/2){
        return x-2.5-(tam/2)*((x-2.5-tam/2)/(width/2));
      }
      return x-2.5+(tam/2)*((x-2.5+tam/2)/(width/2));  
    }
  }
  boolean getF(){
    return f;  
  }
  
  void parar(){
    inter = true;
  }
}

void gui(){
  fill(0);
  //texto
  text("Velocidad: " + acc,10,10);
  if(acc == 5) text("(max)",90,10);
  if(acc == 0.5) text("(min)",90,10);
  String mod = toMode(modo);
  text("Modo: " + mod,10,20);
  image(lfarrow,10,30,40,20);
  text("Cambiar sonido", 50,45);
  image(updarrow,10,50,40,20);
  text("Cambiar expansión", 50,65);
  
  //raton
  if(ayudaC){
    image(clicki,mouseX+10,mouseY-20,20,30);
    text("Nota corta",mouseX+30,mouseY-25);
    image(clickd,mouseX+10,mouseY-45,20,30);
    text("Nota larga",mouseX+30,mouseY);
  }
  
  fill(255);
}

void warning(){
  noFill();
  translate(width/2, height/2);
  rect(-200,-100,400,200);
  image(warning,-190,-90,40,40);
  fill(0);
  textSize(15);
  text("Se recomienda bajar el volumen desde Processing",-140,-65);
  text("Al menos dejarlo por debajo del 10%,",-140,-15);
  text("subirlo si es conveniente",-140,5);
  text("Pulsar ESPACIO para continuar", -140,85);
  textSize(12);
  fill(255);
}
//int to string (tipo de wave)
String toMode(int modo){
  switch (modo){
      case 0:
      return "PHASOR";
      case 1:
      return "QUARTERPULSE";
      case 2:
      return "SAW";
      case 3:
      return "SINE";
      case 4:
      return "SQUARE";
      case 5:
      return "TRIANGLE";
    }
  return "fallo";
}

void sonar(Circle cir,float startT, float dur){
    out.playNote( startT, dur, new SineInstrument( cir.getTam(),modo ));  
}
