EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "PAM chain module"
Date "2020-04-29"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Sensor_Temperature:MAX31820 U1
U 1 1 5EA37B9B
P 5500 4150
F 0 "U1" H 5270 4196 50  0000 R CNN
F 1 "MAX31820" H 5270 4105 50  0000 R CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 4500 3900 50  0001 C CNN
F 3 "http://datasheets.maximintegrated.com/en/ds/MAX31820.pdf" H 5350 4400 50  0001 C CNN
	1    5500 4150
	1    0    0    -1  
$EndComp
$Comp
L Connector:RJ45 J2
U 1 1 5EA388D6
P 6800 4200
F 0 "J2" H 6470 4296 50  0000 R CNN
F 1 "RJ45" H 6470 4205 50  0000 R CNN
F 2 "Connector_RJ:RJ45_Amphenol_54602-x08_Horizontal" V 6800 4225 50  0001 C CNN
F 3 "~" V 6800 4225 50  0001 C CNN
	1    6800 4200
	-1   0    0    -1  
$EndComp
$Comp
L Connector:RJ45 J1
U 1 1 5EA398D2
P 4000 4200
F 0 "J1" H 4057 4867 50  0000 C CNN
F 1 "RJ45" H 4057 4776 50  0000 C CNN
F 2 "Connector_RJ:RJ45_Amphenol_54602-x08_Horizontal" V 4000 4225 50  0001 C CNN
F 3 "~" V 4000 4225 50  0001 C CNN
	1    4000 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5EA450C8
P 5650 3200
F 0 "#PWR06" H 5650 2950 50  0001 C CNN
F 1 "GND" H 5655 3027 50  0000 C CNN
F 2 "" H 5650 3200 50  0001 C CNN
F 3 "" H 5650 3200 50  0001 C CNN
	1    5650 3200
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR04
U 1 1 5EA45E77
P 5500 3750
F 0 "#PWR04" H 5500 3600 50  0001 C CNN
F 1 "VCC" H 5517 3923 50  0000 C CNN
F 2 "" H 5500 3750 50  0001 C CNN
F 3 "" H 5500 3750 50  0001 C CNN
	1    5500 3750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR07
U 1 1 5EA4665F
P 6300 3800
F 0 "#PWR07" H 6300 3650 50  0001 C CNN
F 1 "VCC" H 6317 3973 50  0000 C CNN
F 2 "" H 6300 3800 50  0001 C CNN
F 3 "" H 6300 3800 50  0001 C CNN
	1    6300 3800
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5EA46C71
P 4500 3800
F 0 "#PWR01" H 4500 3650 50  0001 C CNN
F 1 "VCC" V 4517 3928 50  0000 L CNN
F 2 "" H 4500 3800 50  0001 C CNN
F 3 "" H 4500 3800 50  0001 C CNN
	1    4500 3800
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR03
U 1 1 5EA477ED
P 5050 3200
F 0 "#PWR03" H 5050 3050 50  0001 C CNN
F 1 "VCC" H 5067 3373 50  0000 C CNN
F 2 "" H 5050 3200 50  0001 C CNN
F 3 "" H 5050 3200 50  0001 C CNN
	1    5050 3200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5EA4AC7D
P 5500 4550
F 0 "#PWR05" H 5500 4300 50  0001 C CNN
F 1 "GND" H 5505 4377 50  0000 C CNN
F 2 "" H 5500 4550 50  0001 C CNN
F 3 "" H 5500 4550 50  0001 C CNN
	1    5500 4550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5EA4B85F
P 4500 4200
F 0 "#PWR02" H 4500 3950 50  0001 C CNN
F 1 "GND" V 4505 4072 50  0000 R CNN
F 2 "" H 4500 4200 50  0001 C CNN
F 3 "" H 4500 4200 50  0001 C CNN
	1    4500 4200
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5EA4C5AB
P 6300 4200
F 0 "#PWR08" H 6300 3950 50  0001 C CNN
F 1 "GND" V 6305 4072 50  0000 R CNN
F 2 "" H 6300 4200 50  0001 C CNN
F 3 "" H 6300 4200 50  0001 C CNN
	1    6300 4200
	0    1    1    0   
$EndComp
Wire Wire Line
	6300 3800 6400 3800
Wire Wire Line
	5500 3750 5500 3850
Wire Wire Line
	4400 3800 4500 3800
Wire Wire Line
	6300 4200 6400 4200
Wire Wire Line
	5500 4450 5500 4550
Wire Wire Line
	4500 4200 4400 4200
Text Label 6400 4000 2    50   ~ 0
DATA
Text Label 5800 4150 0    50   ~ 0
DATA
Text Label 4400 4000 0    50   ~ 0
DATA
NoConn ~ 6400 3900
NoConn ~ 6400 4100
NoConn ~ 6400 4300
NoConn ~ 6400 4400
NoConn ~ 6400 4500
NoConn ~ 4400 4500
NoConn ~ 4400 4400
NoConn ~ 4400 4300
NoConn ~ 4400 4100
NoConn ~ 4400 3900
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5EA50F8E
P 5050 3200
F 0 "#FLG01" H 5050 3275 50  0001 C CNN
F 1 "PWR_FLAG" H 5050 3373 50  0000 C CNN
F 2 "" H 5050 3200 50  0001 C CNN
F 3 "~" H 5050 3200 50  0001 C CNN
	1    5050 3200
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5EA52CEA
P 5650 3200
F 0 "#FLG02" H 5650 3275 50  0001 C CNN
F 1 "PWR_FLAG" H 5650 3373 50  0000 C CNN
F 2 "" H 5650 3200 50  0001 C CNN
F 3 "~" H 5650 3200 50  0001 C CNN
	1    5650 3200
	-1   0    0    1   
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5EA54166
P 3800 4800
F 0 "H2" H 3900 4846 50  0000 L CNN
F 1 "MountingHole" H 3900 4755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 3800 4800 50  0001 C CNN
F 3 "~" H 3800 4800 50  0001 C CNN
	1    3800 4800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 5EA54DA8
P 3800 3500
F 0 "H1" H 3900 3546 50  0000 L CNN
F 1 "MountingHole" H 3900 3455 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 3800 3500 50  0001 C CNN
F 3 "~" H 3800 3500 50  0001 C CNN
	1    3800 3500
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5EA553C2
P 7000 3500
F 0 "H3" H 7100 3546 50  0000 L CNN
F 1 "MountingHole" H 7100 3455 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 7000 3500 50  0001 C CNN
F 3 "~" H 7000 3500 50  0001 C CNN
	1    7000 3500
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5EA55A8C
P 7000 4800
F 0 "H4" H 7100 4846 50  0000 L CNN
F 1 "MountingHole" H 7100 4755 50  0000 L CNN
F 2 "MountingHole:MountingHole_3mm" H 7000 4800 50  0001 C CNN
F 3 "~" H 7000 4800 50  0001 C CNN
	1    7000 4800
	1    0    0    -1  
$EndComp
$EndSCHEMATC
