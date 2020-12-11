#include <avr/io.h>
#include <util/delay.h>

int main(void) 
{
   DDRB |= 1 << PB5;          /* set LED pin PB5 to output */
   while(1) 
   {
      PORTB &= ~(1 << PB5); /* LED off */
      _delay_ms(900);         /* delay 900 ms */
      PORTB |= 1 << PB5;      /* LED on */
      _delay_ms(100);         /* delay 100 ms */
   }
   return 0;
}
