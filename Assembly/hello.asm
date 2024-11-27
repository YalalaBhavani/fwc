#include <avr/io.h>


#define LED_PIN PB5  // Pin 13 for the LED
#define P_PIN PD2    // Pin 2 for input P
#define Q_PIN PD3    // Pin 3 for input Q
#define R_PIN PD4    // Pin 4 for input R
#define S_PIN PD5    // Pin 5 for input S

// Function to evaluate the logic function f based on inputs P, Q, R, S
uint8_t evaluateLogic(uint8_t P, uint8_t Q, uint8_t R, uint8_t S) {
    // Implementing the logic expression:
    // f = P'R'S + PQ'R + P'RS + PQR'
    return ((!P && !R && S) || (P && !Q && R) || (!P && R && S) || (P && Q && !R));
}

int main(void) {
    // Set LED_PIN as output
    DDRB |= (1 << LED_PIN);
    // Set input pins (P, Q, R, S) as inputs
    DDRD &= ~((1 << P_PIN) | (1 << Q_PIN) | (1 << R_PIN) | (1 << S_PIN));
    
    // Enable pull-up resistors for inputs (optional, if not using external pull-downs)
    PORTD |= ((1 << P_PIN) | (1 << Q_PIN) | (1 << R_PIN) | (1 << S_PIN));

    while (1) {
        // Read inputs
        uint8_t P = (PIND & (1 << P_PIN)) >> P_PIN;
        uint8_t Q = (PIND & (1 << Q_PIN)) >> Q_PIN;
        uint8_t R = (PIND & (1 << R_PIN)) >> R_PIN;
        uint8_t S = (PIND & (1 << S_PIN)) >> S_PIN;

        // Evaluate the logic function
        uint8_t f = evaluateLogic(P, Q, R, S);

        // Control the LED based on the logic output
        if (f) {
            PORTB |= (1 << LED_PIN);  // Turn LED on
        } else {
            PORTB &= ~(1 << LED_PIN); // Turn LED off
        }

        _delay_ms(100);  // Small delay for stability
    }
}
