import serial
import os
from datetime import datetime					   #import libraries
from threading import Timer

ser = serial.Serial("COM10", 250000, timeout=0, writeTimeout=0)	   #define the serial port with its variables
ser.flushInput()						   #clear the input & output of port
ser.flushOutput()
def exitfunc():							   #specify the exit function
    print("Exit Time", datetime.now())
    os._exit(0)

Timer(2700, exitfunc).start() 					   #exit in X seconds, 2700 in this case
while True:							   #while not in exitfunc
    def monitor():						   #define your main function
       while (1):						   #while this function runs
           line = ser.readline()                         	   #tell the code to read the serial port
           if (line != ""):                              	   #"if line is not equal to 0"
            line = line.decode()                                   #convert bytes to string
            text_file = open("45 min test-3.txt", "a")             #open the file with specified name, append
            text_file.write(line)                         	   #write serial port data to file
            text_file.close()                                      #close the file for this loop
    monitor()							   #loop end