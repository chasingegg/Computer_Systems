<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<project xmlns="http://www.xilinx.com/XMLSchema" xmlns:xil_pn="http://www.xilinx.com/XMLSchema">

  <header>
    <!-- ISE source project file created by Project Navigator.             -->
    <!--                                                                   -->
    <!-- This file contains project source information including a list of -->
    <!-- project source files, project and process properties.  This file, -->
    <!-- along with the project source files, is sufficient to open and    -->
    <!-- implement in ISE Project Navigator.                               -->
    <!--                                                                   -->
    <!-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved. -->
  </header>

  <version xil_pn:ise_version="14.7" xil_pn:schema_version="2"/>

  <files>
    <file xil_pn:name="alu.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="6"/>
      <association xil_pn:name="Implementation" xil_pn:seqID="6"/>
    </file>
    <file xil_pn:name="aluCtr.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="5"/>
      <association xil_pn:name="Implementation" xil_pn:seqID="5"/>
    </file>
    <file xil_pn:name="Ctr.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="4"/>
      <association xil_pn:name="Implementation" xil_pn:seqID="4"/>
    </file>
    <file xil_pn:name="data_memory.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="3"/>
      <association xil_pn:name="Implementation" xil_pn:seqID="3"/>
    </file>
    <file xil_pn:name="register.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="2"/>
      <association xil_pn:name="Implementation" xil_pn:seqID="2"/>
    </file>
    <file xil_pn:name="signext.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="1"/>
      <association xil_pn:name="Implementation" xil_pn:seqID="1"/>
    </file>
    <file xil_pn:name="Top.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="7"/>
      <association xil_pn:name="Implementation" xil_pn:seqID="7"/>
    </file>
    <file xil_pn:name="test_for_top.v" xil_pn:type="FILE_VERILOG">
      <association xil_pn:name="BehavioralSimulation" xil_pn:seqID="8"/>
      <association xil_pn:name="PostMapSimulation" xil_pn:seqID="14"/>
      <association xil_pn:name="PostRouteSimulation" xil_pn:seqID="14"/>
      <association xil_pn:name="PostTranslateSimulation" xil_pn:seqID="14"/>
    </file>
    <file xil_pn:name="Top.ucf" xil_pn:type="FILE_UCF">
      <association xil_pn:name="Implementation" xil_pn:seqID="0"/>
    </file>
  </files>

  <properties>
    <property xil_pn:name="Add I/O Buffers" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Allow Logic Optimization Across Hierarchy" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Allow SelectMAP Pins to Persist" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Allow Unexpanded Blocks" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Allow Unmatched LOC Constraints" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Allow Unmatched Timing Group Constraints" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Analysis Effort Level" xil_pn:value="Standard" xil_pn:valueState="default"/>
    <property xil_pn:name="Asynchronous To Synchronous" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Auto Implementation Compile Order" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Auto Implementation Top" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Automatic BRAM Packing" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Automatically Insert glbl Module in the Netlist" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Automatically Run Generate Target PROM/ACE File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="BRAM Utilization Ratio" xil_pn:value="100" xil_pn:valueState="default"/>
    <property xil_pn:name="Bring Out Global Set/Reset Net as a Port" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Bring Out Global Tristate Net as a Port" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Bus Delimiter" xil_pn:value="&lt;>" xil_pn:valueState="default"/>
    <property xil_pn:name="CLB Pack Factor Percentage" xil_pn:value="100" xil_pn:valueState="default"/>
    <property xil_pn:name="Case" xil_pn:value="Maintain" xil_pn:valueState="default"/>
    <property xil_pn:name="Case Implementation Style" xil_pn:value="None" xil_pn:valueState="default"/>
    <property xil_pn:name="Change Device Speed To" xil_pn:value="-5" xil_pn:valueState="default"/>
    <property xil_pn:name="Change Device Speed To Post Trace" xil_pn:value="-5" xil_pn:valueState="default"/>
    <property xil_pn:name="Combinatorial Logic Optimization" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Compile EDK Simulation Library" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Compile SIMPRIM (Timing) Simulation Library" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Compile UNISIM (Functional) Simulation Library" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Compile XilinxCoreLib (CORE Generator) Simulation Library" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Compile for HDL Debugging" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Configuration Clk (Configuration Pins)" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="Configuration Pin Done" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="Configuration Pin M0" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="Configuration Pin M1" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="Configuration Pin M2" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="Configuration Pin Program" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="Configuration Rate" xil_pn:value="Default (1)" xil_pn:valueState="default"/>
    <property xil_pn:name="Correlate Output to Input Design" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Create ASCII Configuration File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Create Binary Configuration File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Create Bit File" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Create I/O Pads from Ports" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Create IEEE 1532 Configuration File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Create Logic Allocation File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Create Mask File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Create ReadBack Data Files" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Cross Clock Analysis" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="DCI Update Mode" xil_pn:value="As Required" xil_pn:valueState="default"/>
    <property xil_pn:name="DSP Utilization Ratio" xil_pn:value="100" xil_pn:valueState="default"/>
    <property xil_pn:name="Decoder Extraction" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Delay Values To Be Read from SDF" xil_pn:value="Setup Time" xil_pn:valueState="default"/>
    <property xil_pn:name="Device" xil_pn:value="xc3s100e" xil_pn:valueState="default"/>
    <property xil_pn:name="Device Family" xil_pn:value="Spartan3E" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Device Speed Grade/Select ABS Minimum" xil_pn:value="-5" xil_pn:valueState="default"/>
    <property xil_pn:name="Disable Detailed Package Model Insertion" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Do Not Escape Signal and Instance Names in Netlist" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Done (Output Events)" xil_pn:value="Default (4)" xil_pn:valueState="default"/>
    <property xil_pn:name="Drive Done Pin High" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Enable BitStream Compression" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Enable Cyclic Redundancy Checking (CRC)" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Enable Debugging of Serial Mode BitStream" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Enable Hardware Co-Simulation" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Enable Internal Done Pipe" xil_pn:value="true" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Enable Message Filtering" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Enable Multi-Threading" xil_pn:value="Off" xil_pn:valueState="default"/>
    <property xil_pn:name="Enable Outputs (Output Events)" xil_pn:value="Default (5)" xil_pn:valueState="default"/>
    <property xil_pn:name="Equivalent Register Removal XST" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Evaluation Development Board" xil_pn:value="None Specified" xil_pn:valueState="default"/>
    <property xil_pn:name="Exclude Compilation of Deprecated EDK Cores" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Exclude Compilation of EDK Sub-Libraries" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Extra Effort" xil_pn:value="None" xil_pn:valueState="default"/>
    <property xil_pn:name="Extra Effort (Highest PAR level only)" xil_pn:value="None" xil_pn:valueState="default"/>
    <property xil_pn:name="FPGA Start-Up Clock" xil_pn:value="CCLK" xil_pn:valueState="default"/>
    <property xil_pn:name="FSM Encoding Algorithm" xil_pn:value="Auto" xil_pn:valueState="default"/>
    <property xil_pn:name="FSM Style" xil_pn:value="LUT" xil_pn:valueState="default"/>
    <property xil_pn:name="Filter Files From Compile Order" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Flatten Output Netlist" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Functional Model Target Language ArchWiz" xil_pn:value="Verilog" xil_pn:valueState="default"/>
    <property xil_pn:name="Functional Model Target Language Coregen" xil_pn:value="Verilog" xil_pn:valueState="default"/>
    <property xil_pn:name="Functional Model Target Language Schematic" xil_pn:value="Verilog" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Architecture Only (No Entity Declaration)" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Asynchronous Delay Report" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Clock Region Report" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Constraints Interaction Report" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Constraints Interaction Report Post Trace" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Datasheet Section" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Datasheet Section Post Trace" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Detailed MAP Report" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Multiple Hierarchical Netlist Files" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Post-Place &amp; Route Power Report" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Post-Place &amp; Route Simulation Model" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate RTL Schematic" xil_pn:value="Yes" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate SAIF File for Power Optimization/Estimation Par" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Testbench File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Timegroups Section" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generate Timegroups Section Post Trace" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Generics, Parameters" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Global Optimization Goal" xil_pn:value="AllClockNets" xil_pn:valueState="default"/>
    <property xil_pn:name="Global Set/Reset Port Name" xil_pn:value="GSR_PORT" xil_pn:valueState="default"/>
    <property xil_pn:name="Global Tristate Port Name" xil_pn:value="GTS_PORT" xil_pn:valueState="default"/>
    <property xil_pn:name="Hierarchy Separator" xil_pn:value="/" xil_pn:valueState="default"/>
    <property xil_pn:name="ISim UUT Instance Name" xil_pn:value="UUT" xil_pn:valueState="default"/>
    <property xil_pn:name="Ignore User Timing Constraints Map" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Ignore User Timing Constraints Par" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Implementation Top" xil_pn:value="Module|Top" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Implementation Top File" xil_pn:value="Top.v" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Implementation Top Instance Path" xil_pn:value="/Top" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Include 'uselib Directive in Verilog File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Include SIMPRIM Models in Verilog File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Include UNISIM Models in Verilog File" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Include sdf_annotate task in Verilog File" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Incremental Compilation" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Insert Buffers to Prevent Pulse Swallowing" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Instantiation Template Target Language Xps" xil_pn:value="Verilog" xil_pn:valueState="default"/>
    <property xil_pn:name="JTAG Pin TCK" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="JTAG Pin TDI" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="JTAG Pin TDO" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="JTAG Pin TMS" xil_pn:value="Pull Up" xil_pn:valueState="default"/>
    <property xil_pn:name="Keep Hierarchy" xil_pn:value="No" xil_pn:valueState="default"/>
    <property xil_pn:name="Language" xil_pn:value="VHDL" xil_pn:valueState="default"/>
    <property xil_pn:name="Last Applied Goal" xil_pn:value="Balanced" xil_pn:valueState="default"/>
    <property xil_pn:name="Last Applied Strategy" xil_pn:value="Xilinx Default (unlocked)" xil_pn:valueState="default"/>
    <property xil_pn:name="Last Unlock Status" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Launch SDK after Export" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Library for Verilog Sources" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Load glbl" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Logical Shifter Extraction" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Manual Implementation Compile Order" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Map Effort Level" xil_pn:value="High" xil_pn:valueState="default"/>
    <property xil_pn:name="Map Slice Logic into Unused Block RAMs" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Max Fanout" xil_pn:value="100000" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Maximum Number of Lines in Report" xil_pn:value="1000" xil_pn:valueState="default"/>
    <property xil_pn:name="Maximum Signal Name Length" xil_pn:value="20" xil_pn:valueState="default"/>
    <property xil_pn:name="Move First Flip-Flop Stage" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Move Last Flip-Flop Stage" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Multiplier Style" xil_pn:value="Auto" xil_pn:valueState="default"/>
    <property xil_pn:name="Mux Extraction" xil_pn:value="Yes" xil_pn:valueState="default"/>
    <property xil_pn:name="Mux Style" xil_pn:value="Auto" xil_pn:valueState="default"/>
    <property xil_pn:name="Netlist Hierarchy" xil_pn:value="As Optimized" xil_pn:valueState="default"/>
    <property xil_pn:name="Netlist Translation Type" xil_pn:value="Timestamp" xil_pn:valueState="default"/>
    <property xil_pn:name="Number of Clock Buffers" xil_pn:value="24" xil_pn:valueState="default"/>
    <property xil_pn:name="Number of Paths in Error/Verbose Report" xil_pn:value="3" xil_pn:valueState="default"/>
    <property xil_pn:name="Number of Paths in Error/Verbose Report Post Trace" xil_pn:value="3" xil_pn:valueState="default"/>
    <property xil_pn:name="Optimization Effort" xil_pn:value="Normal" xil_pn:valueState="default"/>
    <property xil_pn:name="Optimization Goal" xil_pn:value="Speed" xil_pn:valueState="default"/>
    <property xil_pn:name="Optimization Strategy (Cover Mode)" xil_pn:value="Area" xil_pn:valueState="default"/>
    <property xil_pn:name="Optimize Instantiated Primitives" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Bitgen Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Compiler Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Compiler Options Map" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Compiler Options Par" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Compiler Options Translate" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Compxlib Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Map Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other NETGEN Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Ngdbuild Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Place &amp; Route Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Simulator Commands Behavioral" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Simulator Commands Post-Map" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Simulator Commands Post-Route" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other Simulator Commands Post-Translate" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other XPWR Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Other XST Command Line Options" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Output Extended Identifiers" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Output File Name" xil_pn:value="Top" xil_pn:valueState="default"/>
    <property xil_pn:name="Overwrite Compiled Libraries" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Pack I/O Registers into IOBs" xil_pn:value="Auto" xil_pn:valueState="default"/>
    <property xil_pn:name="Pack I/O Registers/Latches into IOBs" xil_pn:value="Off" xil_pn:valueState="default"/>
    <property xil_pn:name="Package" xil_pn:value="cp132" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Perform Advanced Analysis" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Perform Advanced Analysis Post Trace" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Perform Timing-Driven Packing and Placement" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Place &amp; Route Effort Level (Overall)" xil_pn:value="High" xil_pn:valueState="default"/>
    <property xil_pn:name="Place And Route Mode" xil_pn:value="Normal Place and Route" xil_pn:valueState="default"/>
    <property xil_pn:name="Placer Effort Level (Overrides Overall Level)" xil_pn:value="None" xil_pn:valueState="default"/>
    <property xil_pn:name="Port to be used" xil_pn:value="Auto - default" xil_pn:valueState="default"/>
    <property xil_pn:name="Post Map Simulation Model Name" xil_pn:value="Top_map.v" xil_pn:valueState="default"/>
    <property xil_pn:name="Post Place &amp; Route Simulation Model Name" xil_pn:value="Top_timesim.v" xil_pn:valueState="default"/>
    <property xil_pn:name="Post Synthesis Simulation Model Name" xil_pn:value="Top_synthesis.v" xil_pn:valueState="default"/>
    <property xil_pn:name="Post Translate Simulation Model Name" xil_pn:value="Top_translate.v" xil_pn:valueState="default"/>
    <property xil_pn:name="Power Reduction Map" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Power Reduction Par" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Preferred Language" xil_pn:value="Verilog" xil_pn:valueState="default"/>
    <property xil_pn:name="Priority Encoder Extraction" xil_pn:value="Yes" xil_pn:valueState="default"/>
    <property xil_pn:name="Produce Verbose Report" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Project Description" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Property Specification in Project File" xil_pn:value="Store all values" xil_pn:valueState="default"/>
    <property xil_pn:name="RAM Extraction" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="RAM Style" xil_pn:value="Auto" xil_pn:valueState="default"/>
    <property xil_pn:name="ROM Extraction" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="ROM Style" xil_pn:value="Auto" xil_pn:valueState="default"/>
    <property xil_pn:name="Read Cores" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Regenerate Core" xil_pn:value="Under Current Project Setting" xil_pn:valueState="default"/>
    <property xil_pn:name="Register Balancing" xil_pn:value="No" xil_pn:valueState="default"/>
    <property xil_pn:name="Register Duplication" xil_pn:value="Off" xil_pn:valueState="default"/>
    <property xil_pn:name="Register Duplication Xst" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Release Write Enable (Output Events)" xil_pn:value="Default (6)" xil_pn:valueState="default"/>
    <property xil_pn:name="Rename Design Instance in Testbench File to" xil_pn:value="UUT" xil_pn:valueState="default"/>
    <property xil_pn:name="Rename Top Level Architecture To" xil_pn:value="Structure" xil_pn:valueState="default"/>
    <property xil_pn:name="Rename Top Level Entity to" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Rename Top Level Module To" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Fastest Path(s) in Each Constraint" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Fastest Path(s) in Each Constraint Post Trace" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Paths by Endpoint" xil_pn:value="3" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Paths by Endpoint Post Trace" xil_pn:value="3" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Type" xil_pn:value="Verbose Report" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Type Post Trace" xil_pn:value="Verbose Report" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Unconstrained Paths" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Report Unconstrained Paths Post Trace" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Reset DCM if SHUTDOWN &amp; AGHIGH performed" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Reset On Configuration Pulse Width" xil_pn:value="100" xil_pn:valueState="default"/>
    <property xil_pn:name="Resource Sharing" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Retain Hierarchy" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Revision Select" xil_pn:value="00" xil_pn:valueState="default"/>
    <property xil_pn:name="Revision Select Tristate" xil_pn:value="Disable" xil_pn:valueState="default"/>
    <property xil_pn:name="Router Effort Level (Overrides Overall Level)" xil_pn:value="None" xil_pn:valueState="default"/>
    <property xil_pn:name="Run Design Rules Checker (DRC)" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Run for Specified Time" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Run for Specified Time Map" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Run for Specified Time Par" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Run for Specified Time Translate" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Safe Implementation" xil_pn:value="No" xil_pn:valueState="default"/>
    <property xil_pn:name="Security" xil_pn:value="Enable Readback and Reconfiguration" xil_pn:valueState="default"/>
    <property xil_pn:name="Selected Module Instance Name" xil_pn:value="/test_for_top" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Selected Simulation Root Source Node Behavioral" xil_pn:value="work.test_for_top" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Selected Simulation Root Source Node Post-Map" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Selected Simulation Root Source Node Post-Route" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Selected Simulation Root Source Node Post-Translate" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Selected Simulation Source Node" xil_pn:value="UUT" xil_pn:valueState="default"/>
    <property xil_pn:name="Shift Register Extraction" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Show All Models" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Simulation Model Target" xil_pn:value="Verilog" xil_pn:valueState="default"/>
    <property xil_pn:name="Simulation Run Time ISim" xil_pn:value="1000 ns" xil_pn:valueState="default"/>
    <property xil_pn:name="Simulation Run Time Map" xil_pn:value="1000 ns" xil_pn:valueState="default"/>
    <property xil_pn:name="Simulation Run Time Par" xil_pn:value="1000 ns" xil_pn:valueState="default"/>
    <property xil_pn:name="Simulation Run Time Translate" xil_pn:value="1000 ns" xil_pn:valueState="default"/>
    <property xil_pn:name="Simulator" xil_pn:value="ISim (VHDL/Verilog)" xil_pn:valueState="default"/>
    <property xil_pn:name="Slice Packing" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Slice Utilization Ratio" xil_pn:value="100" xil_pn:valueState="default"/>
    <property xil_pn:name="Specify 'define Macro Name and Value" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Specify Top Level Instance Names Behavioral" xil_pn:value="work.test_for_top" xil_pn:valueState="default"/>
    <property xil_pn:name="Specify Top Level Instance Names Post-Map" xil_pn:value="Default" xil_pn:valueState="default"/>
    <property xil_pn:name="Specify Top Level Instance Names Post-Route" xil_pn:value="Default" xil_pn:valueState="default"/>
    <property xil_pn:name="Specify Top Level Instance Names Post-Translate" xil_pn:value="Default" xil_pn:valueState="default"/>
    <property xil_pn:name="Speed Grade" xil_pn:value="-5" xil_pn:valueState="default"/>
    <property xil_pn:name="Starting Placer Cost Table (1-100) Map" xil_pn:value="1" xil_pn:valueState="default"/>
    <property xil_pn:name="Starting Placer Cost Table (1-100) Par" xil_pn:value="1" xil_pn:valueState="default"/>
    <property xil_pn:name="Synthesis Tool" xil_pn:value="XST (VHDL/Verilog)" xil_pn:valueState="default"/>
    <property xil_pn:name="Target Simulator" xil_pn:value="Please Specify" xil_pn:valueState="default"/>
    <property xil_pn:name="Target UCF File Name" xil_pn:value="Top.ucf" xil_pn:valueState="non-default"/>
    <property xil_pn:name="Timing Mode Map" xil_pn:value="Non Timing Driven" xil_pn:valueState="default"/>
    <property xil_pn:name="Timing Mode Par" xil_pn:value="Performance Evaluation" xil_pn:valueState="default"/>
    <property xil_pn:name="Top-Level Module Name in Output Netlist" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Top-Level Source Type" xil_pn:value="HDL" xil_pn:valueState="default"/>
    <property xil_pn:name="Trim Unconnected Signals" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Tristate On Configuration Pulse Width" xil_pn:value="0" xil_pn:valueState="default"/>
    <property xil_pn:name="Unused IOB Pins" xil_pn:value="Pull Down" xil_pn:valueState="default"/>
    <property xil_pn:name="Use 64-bit PlanAhead on 64-bit Systems" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Clock Enable" xil_pn:value="Yes" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Project File Behavioral" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Project File Post-Map" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Project File Post-Route" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Project File Post-Translate" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Simulation Command File Behavioral" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Simulation Command File Map" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Simulation Command File Par" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Simulation Command File Translate" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Waveform Configuration File Behav" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Waveform Configuration File Map" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Waveform Configuration File Par" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Custom Waveform Configuration File Translate" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use LOC Constraints" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Use RLOC Constraints" xil_pn:value="Yes" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Smart Guide" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Synchronous Reset" xil_pn:value="Yes" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Synchronous Set" xil_pn:value="Yes" xil_pn:valueState="default"/>
    <property xil_pn:name="Use Synthesis Constraints File" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="User Browsed Strategy Files" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="UserID Code (8 Digit Hexadecimal)" xil_pn:value="0xFFFFFFFF" xil_pn:valueState="default"/>
    <property xil_pn:name="VHDL Source Analysis Standard" xil_pn:value="VHDL-93" xil_pn:valueState="default"/>
    <property xil_pn:name="Value Range Check" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="Verilog 2001 Xst" xil_pn:value="true" xil_pn:valueState="default"/>
    <property xil_pn:name="Verilog Macros" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="Wait for DLL Lock (Output Events)" xil_pn:value="Default (NoWait)" xil_pn:valueState="default"/>
    <property xil_pn:name="Working Directory" xil_pn:value="." xil_pn:valueState="non-default"/>
    <property xil_pn:name="Write Timing Constraints" xil_pn:value="false" xil_pn:valueState="default"/>
    <property xil_pn:name="XOR Collapsing" xil_pn:value="true" xil_pn:valueState="default"/>
    <!--                                                                                  -->
    <!-- The following properties are for internal use only. These should not be modified.-->
    <!--                                                                                  -->
    <property xil_pn:name="PROP_BehavioralSimTop" xil_pn:value="Module|test_for_top" xil_pn:valueState="non-default"/>
    <property xil_pn:name="PROP_DesignName" xil_pn:value="lab6.0" xil_pn:valueState="non-default"/>
    <property xil_pn:name="PROP_DevFamilyPMName" xil_pn:value="spartan3e" xil_pn:valueState="default"/>
    <property xil_pn:name="PROP_FPGAConfiguration" xil_pn:value="FPGAConfiguration" xil_pn:valueState="default"/>
    <property xil_pn:name="PROP_PostMapSimTop" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="PROP_PostParSimTop" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="PROP_PostSynthSimTop" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="PROP_PostXlateSimTop" xil_pn:value="" xil_pn:valueState="default"/>
    <property xil_pn:name="PROP_PreSynthesis" xil_pn:value="PreSynthesis" xil_pn:valueState="default"/>
    <property xil_pn:name="PROP_intProjectCreationTimestamp" xil_pn:value="2016-03-30T20:48:21" xil_pn:valueState="non-default"/>
    <property xil_pn:name="PROP_intWbtProjectID" xil_pn:value="61B18988EC4E434198AD7B7F364EE21E" xil_pn:valueState="non-default"/>
    <property xil_pn:name="PROP_intWorkingDirLocWRTProjDir" xil_pn:value="Same" xil_pn:valueState="non-default"/>
    <property xil_pn:name="PROP_intWorkingDirUsed" xil_pn:value="No" xil_pn:valueState="non-default"/>
  </properties>

  <bindings/>

  <libraries/>

  <autoManagedFiles>
    <!-- The following files are identified by `include statements in verilog -->
    <!-- source files and are automatically managed by Project Navigator.     -->
    <!--                                                                      -->
    <!-- Do not hand-edit this section, as it will be overwritten when the    -->
    <!-- project is analyzed based on files automatically identified as       -->
    <!-- include files.                                                       -->
  </autoManagedFiles>

</project>
