#include<Arduino.h>
// Define pins for inputs and output
const int inputA = 2;  // Button for Input A
const int inputB = 3;  // Button for Input B
const int outputLED = 13; // LED for Output

void setup() {
  // Initialize input pins
  pinMode(inputA, INPUT);
  pinMode(inputB, INPUT);
  // Initialize output pin
  pinMode(outputLED, OUTPUT);
}

void loop() {
  // Read inputs
  int a = digitalRead(inputA);
  int b = digitalRead(inputB);

  // Apply OR logic
  int output = a || b;

  // Set output LED
  digitalWrite(outputLED, output);

  // Optional delay
  delay(100);
}
