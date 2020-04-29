EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "PAM Main Module"
Date "2020-04-25"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:RJ45 J1
U 1 1 5E9FE6FF
P 3450 2500
F 0 "J1" H 3507 3167 50  0000 C CNN
F 1 "RJ45" H 3507 3076 50  0000 C CNN
F 2 "Connector_RJ:RJ45_Amphenol_54602-x08_Horizontal" V 3450 2525 50  0001 C CNN
F 3 "~" V 3450 2525 50  0001 C CNN
	1    3450 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5EA00AB7
P 4700 2150
F 0 "R1" H 4770 2196 50  0000 L CNN
F 1 "4.7k" H 4770 2105 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P2.54mm_Vertical" V 4630 2150 50  0001 C CNN
F 3 "~" H 4700 2150 50  0001 C CNN
	1    4700 2150
	1    0    0    -1  
$EndComp
$Comp
L 1wire:1WCONN J2
U 1 1 5EA1A2A7
P 5600 2550
F 0 "J2" H 5567 1985 50  0000 C CNN
F 1 "1WCONN" H 5567 2076 50  0000 C CNN
F 2 "Connector_JST:JST_EH_S3B-EH_1x03_P2.50mm_Horizontal" H 5850 2300 50  0001 C CNN
F 3 "" H 5850 2300 50  0001 C CNN
	1    5600 2550
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5EA1AF59
P 5250 2600
F 0 "#PWR0101" H 5250 2350 50  0001 C CNN
F 1 "GND" H 5255 2427 50  0000 C CNN
F 2 "" H 5250 2600 50  0001 C CNN
F 3 "" H 5250 2600 50  0001 C CNN
	1    5250 2600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0102
U 1 1 5EA1BA40
P 5250 1950
F 0 "#PWR0102" H 5250 1800 50  0001 C CNN
F 1 "VCC" H 5267 2123 50  0000 C CNN
F 2 "" H 5250 1950 50  0001 C CNN
F 3 "" H 5250 1950 50  0001 C CNN
	1    5250 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 1950 5250 2200
Wire Wire Line
	5250 2200 5350 2200
Wire Wire Line
	5350 2400 5250 2400
Wire Wire Line
	5250 2400 5250 2600
$Comp
L power:VCC #PWR0103
U 1 1 5EA1C387
P 4700 1950
F 0 "#PWR0103" H 4700 1800 50  0001 C CNN
F 1 "VCC" H 4717 2123 50  0000 C CNN
F 2 "" H 4700 1950 50  0001 C CNN
F 3 "" H 4700 1950 50  0001 C CNN
	1    4700 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 1950 4700 2000
Wire Wire Line
	5350 2300 4700 2300
NoConn ~ 3850 2200
NoConn ~ 3850 2400
NoConn ~ 3850 2600
NoConn ~ 3850 2700
NoConn ~ 3850 2800
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5EA21B32
P 4450 2650
F 0 "#FLG0101" H 4450 2725 50  0001 C CNN
F 1 "PWR_FLAG" H 4450 2823 50  0000 C CNN
F 2 "" H 4450 2650 50  0001 C CNN
F 3 "~" H 4450 2650 50  0001 C CNN
	1    4450 2650
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5EA22558
P 4850 2650
F 0 "#FLG0102" H 4850 2725 50  0001 C CNN
F 1 "PWR_FLAG" H 4850 2823 50  0000 C CNN
F 2 "" H 4850 2650 50  0001 C CNN
F 3 "~" H 4850 2650 50  0001 C CNN
	1    4850 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5EA25245
P 4850 2700
F 0 "#PWR0106" H 4850 2450 50  0001 C CNN
F 1 "GND" H 4855 2527 50  0000 C CNN
F 2 "" H 4850 2700 50  0001 C CNN
F 3 "" H 4850 2700 50  0001 C CNN
	1    4850 2700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0107
U 1 1 5EA25FAA
P 4450 2700
F 0 "#PWR0107" H 4450 2550 50  0001 C CNN
F 1 "VCC" H 4468 2873 50  0000 C CNN
F 2 "" H 4450 2700 50  0001 C CNN
F 3 "" H 4450 2700 50  0001 C CNN
	1    4450 2700
	-1   0    0    1   
$EndComp
Wire Wire Line
	4850 2700 4850 2650
Wire Wire Line
	4450 2700 4450 2650
$Comp
L Connector:RJ45 J3
U 1 1 5EA4F68A
P 3450 3650
F 0 "J3" H 3507 4317 50  0000 C CNN
F 1 "RJ45" H 3507 4226 50  0000 C CNN
F 2 "Connector_RJ:RJ45_Amphenol_54602-x08_Horizontal" V 3450 3675 50  0001 C CNN
F 3 "~" V 3450 3675 50  0001 C CNN
	1    3450 3650
	1    0    0    -1  
$EndComp
$Comp
L Connector:RJ45 J4
U 1 1 5EA4FFA4
P 3450 4800
F 0 "J4" H 3507 5467 50  0000 C CNN
F 1 "RJ45" H 3507 5376 50  0000 C CNN
F 2 "Connector_RJ:RJ45_Amphenol_54602-x08_Horizontal" V 3450 4825 50  0001 C CNN
F 3 "~" V 3450 4825 50  0001 C CNN
	1    3450 4800
	1    0    0    -1  
$EndComp
NoConn ~ 3850 3350
NoConn ~ 3850 3550
NoConn ~ 3850 3750
NoConn ~ 3850 3850
NoConn ~ 3850 3950
NoConn ~ 3850 4500
NoConn ~ 3850 4700
NoConn ~ 3850 4900
NoConn ~ 3850 5100
NoConn ~ 3850 5000
Text Label 3850 3250 0    50   ~ 0
VCC
Text Label 3850 4400 0    50   ~ 0
VCC
Text Label 3850 3450 0    50   ~ 0
DATA
Text Label 3850 4600 0    50   ~ 0
DATA
Text Label 3850 3650 0    50   ~ 0
GND
Text Label 3850 4800 0    50   ~ 0
GND
Text Label 3850 2100 0    50   ~ 0
VCC
Text Label 3850 2300 0    50   ~ 0
DATA
Text Label 3850 2500 0    50   ~ 0
GND
Text Label 4700 2300 2    50   ~ 0
DATA
$Comp
L Mechanical:MountingHole H2
U 1 1 5EA60ED7
P 4550 3400
F 0 "H2" H 4650 3446 50  0000 L CNN
F 1 "MountingHole" H 4650 3355 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 4550 3400 50  0001 C CNN
F 3 "~" H 4550 3400 50  0001 C CNN
	1    4550 3400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 5EA616F1
P 4550 3200
F 0 "H1" H 4650 3246 50  0000 L CNN
F 1 "MountingHole" H 4650 3155 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 4550 3200 50  0001 C CNN
F 3 "~" H 4550 3200 50  0001 C CNN
	1    4550 3200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5EA61B3C
P 4550 3600
F 0 "H3" H 4650 3646 50  0000 L CNN
F 1 "MountingHole" H 4650 3555 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 4550 3600 50  0001 C CNN
F 3 "~" H 4550 3600 50  0001 C CNN
	1    4550 3600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5EA61DBB
P 4550 3800
F 0 "H4" H 4650 3846 50  0000 L CNN
F 1 "MountingHole" H 4650 3755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 4550 3800 50  0001 C CNN
F 3 "~" H 4550 3800 50  0001 C CNN
	1    4550 3800
	1    0    0    -1  
$EndComp
$EndSCHEMATC
