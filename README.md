# fifo_project
# Parameterized Synchronous FIFO (Verilog)

## 📌 Overview
This project implements a parameterized synchronous FIFO using Verilog.  
The design supports configurable data width and depth and includes a self-checking testbench for functional verification.

This project was developed and simulated using Xilinx Vivado.

---

## 🎯 Objective
To design, verify, and validate a synchronous FIFO with:

- Parameterized DATA_WIDTH
- Parameterized DEPTH (power of 2)
- Proper full and empty detection
- Overflow and underflow protection
- Clean synchronous RTL implementation

---

## 🏗️ Architecture

The FIFO consists of:

- Memory array for data storage
- Write pointer (wr_ptr)
- Read pointer (rd_ptr)
- Full detection logic
- Empty detection logic

### Empty Condition:
FIFO is empty when:
wr_ptr == rd_ptr

### Full Condition:
FIFO is full when:
- MSB of wr_ptr != MSB of rd_ptr
AND
- Lower bits of wr_ptr == lower bits of rd_ptr

An extra pointer bit is used to distinguish full from empty condition.

---

## ⚙️ Parameters

| Parameter     | Description                  |
|--------------|-----------------------------|
| DATA_WIDTH   | Width of each data word     |
| DEPTH        | Number of FIFO entries      |

Example configuration:
- DATA_WIDTH = 8
- DEPTH = 16

---

## 🧪 Simulation

### Verification Performed:
- Reset behavior verification
- Sequential write operations
- Sequential read operations
- Full condition detection
- Empty condition detection
- Boundary testing (write when full, read when empty)

The testbench is self-checking and reports PASS/ERROR messages.

Waveform screenshot is available in the Simulation folder.

---

## 🛠️ Project Structure

FIFO_Project/
│
├── RTL/
│ └── fifo.v
│
├── TB/
│ └── fifo_tb.v
│
├── Simulation/
│ └── waveform.png
│
└── README.md


---

## 🧠 Key Learnings

- Pointer-based full/empty detection
- Importance of extra MSB in circular buffer logic
- Synchronous reset handling
- Writing synthesizable RTL
- Creating self-checking testbenches

---

## 🚀 Future Improvements

- Add almost_full and almost_empty signals
- Convert to asynchronous FIFO (dual clock)
- Add synthesis and timing analysis documentation
- Implement Block RAM inference for larger depths

---

## 📎 Tools Used

- Xilinx Vivado (Simulation)

---

## 📌 Conclusion

The FIFO was successfully verified using simulation.  
The design is scalable, parameterized, and written in clean synthesizable RTL style.

This project demonstrates strong fundamentals in RTL design and verification.
