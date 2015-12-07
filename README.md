# SleepBusters

README
---------------------
SECTIONS:
- Introduction
- Requirements
- Configuration


INTRODUCTION
---------------------
This README file is intended to assist the developer in 
the proper use of the Mindwave EEG and PillowSoft 
SleepBusters Respiratory Belt.


REQUIREMENTS
---------------------
Hardware Requirements:
- iPhone 6s or later
- Mindwave Mobile EEG Sensor
- SleepBusters Respiratory Belt

Software Requirements:
- iOS 9.0 or later compatible device
- Windows 7 or Mac OSX or later operating system


CONFIGURATION
---------------------
Configuring Simulation: To enable a simulated hardware
device, navigate to line 48/49 in LiveTrackingViewController
and change isEEGSimulate and isRespiratorySimulate to true.

Configuring Real Hardware: To enable real hardware navigate 
to line 48/49 in LiveTrackingViewController and change 
isEEGSimulate and isRespiratorySimulate to false.

Steps to Connect Bluetooth hardware to SleepBusters:

1) Push the pair button on the Mindwave EEG Device

2) Connect to "Mindwave Mobile" on your iOS device

3) Plug the battery into the USB port on the front of the belt

Now open the SleepBusters application, proceed to "Start Tracking" 
and ensure that you can see live data.
