int count = 0;                                                              //define your count integer
const byte interruptPin = 2;                                                //define the pin you'll count from
unsigned long previousMicros;                                               //specify your variables are unsigned long
unsigned long interruptMicros;
unsigned long currentMicros;
void setup() {
  pinMode(interruptPin, INPUT);                                             //define your count pin is an input
  attachInterrupt(digitalPinToInterrupt(interruptPin), flag, RISING);       //attach the interrupt service routine to this pin
  Serial.begin(250000);                                                     //begin serial data transfer at 250k baud
}
void loop() {
}
void flag() {
  count++;                                                                  //increase count for each interrupt flag called
  currentMicros = micros();                                                 //record the time count was increased
  interruptMicros = currentMicros - previousMicros;                         //subtract previous count time from current
  Serial.println(interruptMicros);                                          //print the time difference
  previousMicros = currentMicros;                                           //set current time as previous
}
