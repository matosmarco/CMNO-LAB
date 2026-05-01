# Linear State Feedback Control of an Inverted Pendulum

[![MATLAB](https://img.shields.io/badge/MATLAB-e16737?style=flat-square&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Simulink](https://img.shields.io/badge/Simulink-0076A8?style=flat-square&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/simulink.html)
[![Control Systems](https://img.shields.io/badge/Control_Systems-LQR%20%7C%20LQG-4CAF50?style=flat-square)](#)
[![Instituto Superior Técnico](https://img.shields.io/badge/IST-Universidade_de_Lisboa-blue?style=flat-square)](https://tecnico.ulisboa.pt/)

This repository contains the MATLAB scripts and SIMULINK models developed for the **Multivariable, Nonlinear, and Optimal Control (CMN-O)** course at Instituto Superior Técnico. 

The project focuses on the fast prototyping and real-time implementation of a cyber-physical system to balance a Quanser rotary inverted pendulum in its upright position.

## Project Overview

The main objective of this lab is to design, simulate, and implement an optimal state feedback controller (Linear Quadratic Gaussian - LQG) for an unstable, nonlinear mechanical system. The workflow bridges theoretical control design with real-time hardware execution.

Key phases of the project include:
1.  **System Analysis:** Analyzing the linearized state-space model of the pendulum (controllability, observability, and open-loop poles).
2.  **Controller Design (LQR):** Computing the optimal feedback gain matrix ($K$) by minimizing a quadratic cost function (tuning $Q$ and $R$ weight matrices).
3.  **State Observer Design (Kalman Filter):** Designing an estimator ($L$) to reconstruct unmeasured state variables based on the available sensor outputs.
4.  **Simulation & Real-Time Implementation:** Testing the LQG controller in SIMULINK and deploying it to the physical hardware using data acquisition boards.

##  Hardware Setup

The physical plant is a **QUANSER Rotary Inverted Pendulum**.
*   **Actuator:** A servo motor connected to a horizontal bar.
*   **Sensors:** 
    *   A potentiometer to measure the angle of the motor shaft ($\alpha$).
    *   An optical encoder to measure the angle of the pendulum with respect to the vertical ($\beta$).
*   **Interface:** National Instruments Data Acquisition Boards (NI-PCI6221 or NI-MIO16E4) for A/D and D/A conversion.

## Control Architecture

The system dynamics are described by a 5-dimensional state vector: the horizontal bar angle, pendulum angle, their respective angular velocities, and the motor current.

*   **Plant Model:** The non-linear dynamics were linearized around the unstable equilibrium point (upright position) to yield the standard $\dot{x} = Ax + Bu$ and $y = Cx + Du$ state-space representation.
*   **LQG Controller:** The final closed-loop system utilizes the estimated state $\hat{x}$ for feedback:

$$u(t) = -K \hat{x}(t)$$

The observer dynamics are governed by:

$$\dot{\hat{x}} = A \hat{x} + B u + L (y - C \hat{x})$$

##  Usage & Deployment

*Note: Real-time execution requires MATLAB/Simulink 2015a and the physical Quanser setup.*

1.  **Simulation:** 
    *   Run the provided MATLAB macro to load `IP_MODEL.mat` and compute the $K$ and $L$ gains.
    *   Open the simulation SIMULINK block diagram to evaluate the step responses and system stability using the computed gains.
2.  **Real-Time Execution:**
    *   Open the hardware-specific SIMULINK model (e.g., `IP_LQG_PCI6221_2015a.slx`).
    *   Hold the pendulum perfectly still in the vertical upright position.
    *   Start the SIMULINK execution. Once the sensors are calibrated (indicated by the yellow box switching from 1 to 2, and then 3), release the pendulum to allow the controller to take over and balance it.

---
