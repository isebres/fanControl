fanControl
-------
Simple OS X console utility for temperatures and fan speed monitoring writen on Swift. Additionally maximal and minimal fan speed can be adjusted. 
For monitoring run `fanControl` and you can see something like this:
```
Fan speeds (RPM):
   ID        Name      Min       Cur       Max
   0         Exhaust   1200      2041      7200
Temperatures (°C):
   CPU       69.7
   MEM       51.0
   ENC       36.0
   HSK       51.5
```

For control fan speed run utility with "sudo" `sudo fanControl -id=<ID> -rpm=<MIN>-<MAX>`
In case of success you will be notified with something like this:
```
Exhaust fan (ID:0):
    RPM successfully changed from XXX-XXX to MIN-MAX
```
Inspired by https://github.com/beltex/SMCKit

Warning
-------
This tool will allow you to write values to the SMC which could irreversably damage your
computer.  Manipulating the fans could cause overheating and permanent damange.  USE THIS
PROGRAM AT YOUR OWN RISK! 
