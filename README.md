# verilog-multiplier-ate-patterns

# 🚀 3-Stage Pipelined Multiplier in Verilog

This is an experimental RTL design of a **signed 3-stage pipelined multiplier** in Verilog. It's built for digital design practice and ATE test engineering workflows.

---

## 📖 Project Timeline: Step-by-Step Journey

### 1. ✅ Goal Setup
- Objective: Build a pipelined multiplier that can generate ATE-ready test patterns.
- Motivation: Integrate pipelined blocks into MIPS and simulate ATE-level pattern export.

### 2. 🔁 Initial MIPS-Based Pipeline Exploration
Before starting the multiplier, a simple MIPS pipeline subset was built to:
- Get familiar with EDA Playground + waveform debug
- Simulate instruction fetch and decode stages

Modules designed (in `legacy_mips/` folder):
- `testbench.sv`
- `mips_top.v`
- `if_stage.v`
- `id_stage.v`

This validated basic RTL structure and waveform simulation.

---

### 3. 🧱 RTL Design in Verilog
- Developed a 3-stage pipelined multiplier:
  - Stage 1: Input latch
  - Stage 2: Signed multiplication
  - Stage 3: Output latch
- Saved in `src/design.sv`

---

### 4. 🧪 Pipelined Multiplier Testbench and Simulation
- A fresh testbench was written in `src/testbench.sv`
- Simulated on EDA Playground (Icarus Verilog backend)
- GTKWave (via EPWave) used to visualize waveform
- Signals dumped with `$dumpfile("dump.vcd")` and `$dumpvars(0, testbench)`

---

### 5. 📈 Observed Results
- Values of `a`, `b`, `result`, and `valid_out` were tracked from waveform

---

### 6. 📤 Exported to CSV
- Results manually or automatically logged into a CSV file:
  - `mult_vectors.csv`
  - Format: `Time_ns, A, B, Result, Valid`

---

### 7. 💡 Created ATE-Ready STIL File
- A Python script converted CSV to STIL:
  - Defined waveform table
  - Declared pattern vectors
  - Exported to: `pipelined_multiplier_patterns_ate.stil`

---

### 8. 📦 Packaged All Files
- All sources organized into folders:
  - `src/`: RTL design + testbench
  - `legacy_mips/`: Initial exploration modules
  - `patterns/`: CSV + STIL vector output

---

## 📁 Project Structure

```
├── README.md
├── src/
│   ├── design.sv
│   └── testbench.sv
├── legacy_mips/
│   ├── mips_top.v
│   ├── if_stage.v
│   └── id_stage.v
├── patterns/
│   ├── mult_vectors.csv
│   └── pipelined_multiplier_patterns_ate.stil
```

---

## 🧠 Skills Demonstrated

- ✅ Verilog RTL design
- ✅ Pipelining architecture
- ✅ Signed multiplication
- ✅ Waveform simulation & analysis
- ✅ ATE test vector formatting (STIL)
- ✅ CSV/test vector analysis

---

## 📈 How to Simulate

You can run this on:
- ✅ Icarus Verilog + GTKWave (locally or via EDA Playground)
- ✅ EDA Playground ([https://edaplayground.com](https://edaplayground.com))

`testbench.sv` includes:
```verilog
$dumpfile("dump.vcd");
$dumpvars(0, testbench);
```

Use GTKWave to view `a`, `b`, `result`, and `valid_out` waveform.

---

## 🛠 ATE Test Vector Export

We export results to STIL format using a Python script, producing:
- `pipelined_multiplier_patterns_ate.stil`
  - Includes:
    - WaveformTable
    - Period (`100ns`)
    - Logic level mapping (`0`: L, `1`: H)

You can use **TestInsight**, **V93000**, or **Teradyne** tools to convert this to `.PAT`.

---

## 📌 Future Enhancements
- Add random/corner test generation
- Fault modeling & stuck-at analysis
- Integrate into EX stage of MIPS processor
- BIST pattern generation
- STIL to `.pat` direct flow

---

## 🤝 Credits
This project is part of a **personal experiment** by an aspiring **IC Test Engineer** who wanted to:
- Practice pipelined design
- Simulate and observe dataflow
- Export and understand ATE test patterns

---
