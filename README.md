SynchronousQuadratureEncoder
============================

An implementation of decrypting a quadrature optical encoder in System Verilog


Optical Encoders are fairly common in high precision systems where closed-loop feedback is needed. This code snippet provides the *Encoder Parser* module.  When implemented, it outputs the current number of ticks counted from the encoder.  

Note that the output is a truncated 32-bit int.  To gain the full 32 bits, simply expand the bit width of count.  (I only had 4 LEDs on which to display the count at the time.)


# License

The source code of this project is licensed under a [Creative Commons Attribution License](http://creativecommons.org/licenses/by/3.0/us/): you may use it, but you must give attribution to the original author.

