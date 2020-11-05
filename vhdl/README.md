# DDFS

Digital design class project, University of Pisa: 
Direct digital frequency synthesizer, written in VHDL.

Both the straightforward architecture and the optimized architecture which exploits the quadrantal symmetry of the *sine* function have been pursued. 

---



### Make waveforms using ghdl and gtkwave:

```bash
mkdir build && cd build

ghdl -i ../src/*
ghdl -i ../tests/*

ghdl -m tb_rca

ghdl -r tb_rca --vcd=../waveforms/tb_rca.vcd # generates a .vcd file inside ../waveforms to be opened with gtkwave
```
