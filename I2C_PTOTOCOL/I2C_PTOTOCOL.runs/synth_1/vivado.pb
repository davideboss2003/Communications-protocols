
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:162

00:00:182	
571.1642	
238.988Z17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/Users/mures/OneDrive/Desktop/SSC/PROIECT_SSC/I2C_PTOTOCOL/I2C_PTOTOCOL.srcs/utils_1/imports/synth_1/I2C_Master.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2w
uC:/Users/mures/OneDrive/Desktop/SSC/PROIECT_SSC/I2C_PTOTOCOL/I2C_PTOTOCOL.srcs/utils_1/imports/synth_1/I2C_Master.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
g
Command: %s
53*	vivadotcl26
4synth_design -top I2C_Master -part xc7a50ticsg324-1LZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7a50tiZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7a50tiZ17-349h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
26852Z8-7075h px� 
�
%s*synth2v
tStarting Synthesize : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1027.449 ; gain = 444.516
h px� 
�
synthesizing module '%s'638*oasys2

I2C_Master2o
kC:/Users/mures/OneDrive/Desktop/SSC/PROIECT_SSC/I2C_PTOTOCOL/I2C_PTOTOCOL.srcs/sources_1/new/I2C_Master.vhd2
248@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

I2C_Master2
02
12o
kC:/Users/mures/OneDrive/Desktop/SSC/PROIECT_SSC/I2C_PTOTOCOL/I2C_PTOTOCOL.srcs/sources_1/new/I2C_Master.vhd2
248@Z8-256h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2

data_out2

I2C_Master2o
kC:/Users/mures/OneDrive/Desktop/SSC/PROIECT_SSC/I2C_PTOTOCOL/I2C_PTOTOCOL.srcs/sources_1/new/I2C_Master.vhd2
168@Z8-3848h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[7]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[6]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[5]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[4]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[3]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[2]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[1]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[0]2

I2C_MasterZ8-7129h px� 
r
9Port %s in module %s is either unconnected or has no load4866*oasys2
SdaIn2

I2C_MasterZ8-7129h px� 
�
%s*synth2v
tFinished Synthesize : Time (s): cpu = 00:00:14 ; elapsed = 00:00:15 . Memory (MB): peak = 1137.113 ; gain = 554.180
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1137.113 ; gain = 554.180
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Loading part: xc7a50ticsg324-1L
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1137.113 ; gain = 554.180
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
F
Loading part %s157*device2
xc7a50ticsg324-1LZ21-403h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
7
%s
*synth2
Start Preparing Guide Design
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
�The reference checkpoint %s is not suitable for use with incremental synthesis for this design. Please regenerate the checkpoint for this design with -incremental_synth switch in the same Vivado session that synth_design has been run. Synthesis will continue with the default flow4740*oasys2w
uC:/Users/mures/OneDrive/Desktop/SSC/PROIECT_SSC/I2C_PTOTOCOL/I2C_PTOTOCOL.srcs/utils_1/imports/synth_1/I2C_Master.dcpZ8-6895h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Doing Graph Differ : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1137.113 ; gain = 554.180
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Preparing Guide Design : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1137.113 ; gain = 554.180
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
n
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2

I2C_MasterZ8-802h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                              000 |                             0000
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                              001 |                             0001
h p
x
� 
y
%s
*synth2a
_                 iSTATE1 |                              010 |                             0010
h p
x
� 
y
%s
*synth2a
_                 iSTATE2 |                              011 |                             0011
h p
x
� 
y
%s
*synth2a
_                 iSTATE3 |                              100 |                             0100
h p
x
� 
y
%s
*synth2a
_                 iSTATE4 |                              101 |                             0101
h p
x
� 
y
%s
*synth2a
_                 iSTATE5 |                              110 |                             0110
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2

sequential2

I2C_MasterZ8-3354h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 1137.113 ; gain = 554.180
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
C
%s
*synth2+
)

Incremental Synthesis Report Summary:

h p
x
� 
<
%s
*synth2$
"1. Incremental synthesis run: no

h p
x
� 
O
%s
*synth27
5   Reason for not running incremental synthesis : 


h p
x
� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}4868*oasysZ8-7130h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit       Adders := 1     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 3     
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   7 Input    3 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   7 Input    1 Bit        Muxes := 6     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
\
$Part: %s does not have CEAM library.966*device2
xc7a50ticsg324-1LZ21-9227h px� 
q
%s
*synth2Y
WPart Resources:
DSPs: 120 (col length:60)
BRAMs: 150 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[7]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[6]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[5]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[4]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[3]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[2]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[1]2

I2C_MasterZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2
data_out[0]2

I2C_MasterZ8-7129h px� 
r
9Port %s in module %s is either unconnected or has no load4866*oasys2
SdaIn2

I2C_MasterZ8-7129h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
1
%s*synth2
+------+------+------+
h px� 
1
%s*synth2
|      |Cell  |Count |
h px� 
1
%s*synth2
+------+------+------+
h px� 
1
%s*synth2
|1     |BUFG  |     1|
h px� 
1
%s*synth2
|2     |LUT2  |     1|
h px� 
1
%s*synth2
|3     |LUT3  |     2|
h px� 
1
%s*synth2
|4     |LUT4  |     3|
h px� 
1
%s*synth2
|5     |LUT5  |     6|
h px� 
1
%s*synth2
|6     |LUT6  |    18|
h px� 
1
%s*synth2
|7     |MUXF7 |     2|
h px� 
1
%s*synth2
|8     |FDCE  |    12|
h px� 
1
%s*synth2
|9     |FDPE  |     2|
h px� 
1
%s*synth2
|10    |FDRE  |     3|
h px� 
1
%s*synth2
|11    |IBUF  |    19|
h px� 
1
%s*synth2
|12    |OBUF  |     3|
h px� 
1
%s*synth2
|13    |OBUFT |     8|
h px� 
1
%s*synth2
+------+------+------+
h px� 
3
%s
*synth2

Report Instance Areas: 
h p
x
� 
<
%s
*synth2$
"+------+---------+-------+------+
h p
x
� 
<
%s
*synth2$
"|      |Instance |Module |Cells |
h p
x
� 
<
%s
*synth2$
"+------+---------+-------+------+
h p
x
� 
<
%s
*synth2$
"|1     |top      |       |    80|
h p
x
� 
<
%s
*synth2$
"+------+---------+-------+------+
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
a
%s
*synth2I
GSynthesis finished with 0 errors, 1 critical warnings and 20 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:41 ; elapsed = 00:00:43 . Memory (MB): peak = 1330.379 ; gain = 747.445
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1335.1332
0.000Z17-268h px� 
S
-Analyzing %s Unisim elements for replacement
17*netlist2
2Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1427.2272
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

692ea77dZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
202
202
12
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:452

00:00:472

1427.2272	
851.566Z17-268h px� 
c
%s6*runtcl2G
ESynthesis results are not added to the cache due to CRITICAL_WARNING
h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0022

1427.2272
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2g
eC:/Users/mures/OneDrive/Desktop/SSC/PROIECT_SSC/I2C_PTOTOCOL/I2C_PTOTOCOL.runs/synth_1/I2C_Master.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2_
]report_utilization -file I2C_Master_utilization_synth.rpt -pb I2C_Master_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Wed Dec 18 08:03:39 2024Z17-206h px� 


End Record