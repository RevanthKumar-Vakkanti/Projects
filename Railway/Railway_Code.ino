#include <Servo.h>
const int IRsensor1 = A2;
const int IRsensor2 = A1;
const int BUZZER = 10;
const int Rled = 11;
const int Gled = 12;
 
Servo myservo1;
Servo myservo2;
 
void setup()
{
  pinMode(IRsensor1, INPUT);
  pinMode(IRsensor2, INPUT);
  pinMode(BUZZER, OUTPUT);
  pinMode(Rled, OUTPUT);
  pinMode(Gled, OUTPUT);
  
  myservo1.attach(5); // Servo motor 1 pin connected to D5
  myservo2.attach(6); // Servo motor 2 pin connected to D5
 
  }
void loop() 
 {
   int Sensordata1 = digitalRead(IRsensor1); // read degital data from IR sensor1
   int Sensordata2 = digitalRead(IRsensor2); // read degital data from IR sensor2
   myservo1.write(0); // sets the servo at 0 degree position
   myservo2.write(0); // sets the servo at 0 degree position
 
  if (Sensordata1 == LOW && Sensordata2 == HIGH)
   {
    myservo2.write(90);     // sets the servo at 90 degree position
    myservo1.write(90);     // sets the servo at 90 degree position
    digitalWrite(BUZZER, HIGH); // turn on buzzer
    digitalWrite(Rled, HIGH); // turn on Red LED
    delay(3000);
   }
  else if (Sensordata1 == HIGH && Sensordata2 == LOW)
   {
    myservo1.write(0);     // sets the servo at 0 degree position
    myservo2.write(0);     // sets the servo at 0 degree position
    digitalWrite(Gled, HIGH); // turn on Green LED
    digitalWrite(BUZZER, LOW); // turn off buzzer
    delay(3000); 
   }
  else
   {
    myservo1.write(0);     // sets the servo at 0 degree position
    myservo2.write(0);     // sets the servo at 0 degree position
    digitalWrite(Gled, HIGH); // turn on Green LED
    digitalWrite(BUZZER, LOW); // turn off buzzer
   }
  
}
