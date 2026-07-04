# 3x3 Memory Matrix & Verification Testbench

A foundational SystemVerilog design implementing a 2D unpacked array ($3 \times 3$ matrix) that demonstrates the co-existence and functional differences between sequential logic (`always @(posedge clk)`) and combinational logic (`always @(*)`).

---

## Design Overview

The design manages a 3-row by 3-column matrix of 8-bit registers. It supports simultaneous synchronous writing to a specific matrix coordinate and asynchronous reading/summation of data.

### Features
* **Synchronous Storage:** Writes data to the matrix on the rising edge of the clock using non-blocking assignments (`<=`).
* **Asynchronous Reads (`comb_out`):** Fetches the stored data instantly using combinatorial paths based on the read pointer inputs.
* **Synchronous Reads (`seq_out`):** Latches the read data into a registered output on the clock edge.
* **Combinatorial Row Sum (`row_sum`):** Instantly calculates the mathematical sum of all 3 elements in the specified target row.

---

## Module Interface

### Inputs
| Port Name | Bit Width | Type | Description |
| :--- | :--- | :--- | :--- |
| `clk` | 1 | `logic` | System Clock Signal |
| `rst_n` | 1 | `logic` | Active-Low Asynchronous Reset |
| `data_in` | 8 | `logic` | 8-bit input byte to be stored |
| `w_row` | 2 | `logic` | Write Row pointer index (**Range: 0 to 2**) |
| `w_col` | 2 | `logic` | Write Column pointer index (**Range: 0 to 2**) |
| `r_row` | 2 | `logic` | Read Row pointer index (**Range: 0 to 2**) |
| `r_col` | 2 | `logic` | Read Column pointer index (**Range: 0 to 2**) |

### Outputs
| Port Name | Bit Width | Type | Description |
| :--- | :--- | :--- | :--- |
| `comb_out` | 8 | `logic` | Immediate combinational readout of `matrix[r_row][r_col]` |
| `seq_out` | 8 | `logic` | Clocked/Registered readout of `matrix[r_row][r_col]` |
| `row_sum` | 16 | `logic` | Instant summation of the selected row (`col_0 + col_1 + col_2`) |

---

## Critical Design Constraints: The 0-Index Boundary Rule

Because the matrix is declared as `matrix[3][3]`, it allocates exactly **3** rows and **3** columns. In hardware, array boundaries are **0-indexed**. 

| Decimal Index | Binary Value | Status |
| :--- | :--- | :--- |
| **0** | `2'b00` | **Valid** (1st element) |
| **1** | `2'b01` | **Valid** (2nd element) |
| **2** | `2'b10` | **Valid** (3rd element) |
| **3** | `2'b11` | **INVALID (Out of Bounds)** |

* **Do not use index `3` (`2'b11`)**. Driving a value of `3` to any pointer port exceeds the matrix bounds, resulting in unknown hardware simulator outputs (`xx`).

---

## Simulation Execution Logs

When compiled and executed using any standard standard IEEE simulator (e.g., ModelSim, QuestaSim, Vivado, or EDA Playground), the automated active `$monitor` dumps the following exact functional runtime states:

```text
Time=0  | RST=0 | WRITE: [0][0]=00 | READ Ptr: [0][0] | comb_out=00 | seq_out=00 | row_sum=0
Time=15 | RST=1 | WRITE: [2][2]=fe | READ Ptr: [0][0] | comb_out=00 | seq_out=00 | row_sum=0
Time=25 | RST=1 | WRITE: [0][1]=fe | READ Ptr: [0][0] | comb_out=00 | seq_out=00 | row_sum=254
Time=35 | RST=1 | WRITE: [0][1]=fe | READ Ptr: [0][1] | comb_out=fe | seq_out=fe | row_sum=254
