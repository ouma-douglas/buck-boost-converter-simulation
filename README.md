# Closed-Loop Buck-Boost Converter Simulation in GNU Octave

This repository hosts a dynamic mathematical simulation of a non-isolated **DC-DC Buck-Boost Converter** regulated by a discrete **PID Controller**. The plant is modeled entirely from foundational state-space averaged differential equations.

## Design Parameters
- **Input Voltage ($V_{in}$):** 12 V
- **Target Output Voltage ($V_{out}$):** -18 V (Boost Mode)
- **Inductor ($L$):** 150 µH
- **Capacitor ($C$):** 220 µH

## Performance Analysis & Transient Stress-Test
To evaluate the controller's robustness, the system undergoes a sudden **Step-Load Change** at $t = 25\text{ms}$ where the load resistance drops from $10\Omega$ to $4\Omega$ to draw more current. 

Here is the simulation output showing smooth startup tracking and clean transient disturbance rejection:

![Simulation Results](simulation_results.png)

### Key Results:
1. **Startup Performance:** The system reaches the target steady-state voltage within approximately $15\text{ms}$ with zero critical overshoot.
2. **Disturbance Rejection:** When the heavy load step occurs at $25\text{ms}$, the output voltage experiences a temporary dip, but the tuned PID loop smoothly adjusts the duty cycle to restore stable regulation without harsh oscillations.

## How to Run
1. Install [GNU Octave](https://gnu.org/software/octave/).
2. Download the `.m` files in this repository to a single folder.
3. Open Octave, open `main_simulation.m` in the Editor, and press **F5** to run.
