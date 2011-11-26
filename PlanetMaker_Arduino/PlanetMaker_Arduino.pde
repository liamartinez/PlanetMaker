void setup() {
    Serial.begin(9600);
}
void loop() {
    int analogValue = analogRead(A0) ;      // read the pot value
    Serial.write(analogValue);        // print the value in the serial monitor as a binary value
}

