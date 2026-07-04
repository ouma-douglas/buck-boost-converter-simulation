clear; clk = tic;

% --- Technical Specifications ---
Vin = 12;         % Input Voltage (V)
Vref = 18;        % Target Output Voltage magnitude (V)
L = 150e-6;       % Inductor (H)
C = 220e-6;       % Capacitor (F)
R_nominal = 10;   % Nominal Load Resistance (Ohms)
R_step = 4;       % Heavier Load Resistance (Draws more current)

% --- Simulation Parameters ---
T_final = 0.05;   % Total simulation time (seconds)
dt = 1e-6;        % Time step size (1 microsecond)
t = 0:dt:T_final;
N = length(t);

% --- Tuned PID Gains for Stability ---
Kp = 0.005;  Ki = 0.35;  Kd = 0.00001;
e_sum = 0;  e_prev = 0;

% --- Memory Allocation for Results ---
x = [0; 0];       % Initial states: [iL; vC]
history_vC = zeros(1, N);
history_iL = zeros(1, N);
history_d = zeros(1, N);

% --- Simulation Loop ---
for k = 1:N
    % Apply Step-Load Change halfway through simulation (at 0.025 seconds)
    if t(k) > 0.025
        R = R_step;
    else
        R = R_nominal;
    end

    % Read current capacitor voltage
    vC = x(2);

    % Execute Controller to find next Duty Cycle (d)
    [d, e_sum, e_prev] = pid_controller(Vref, vC, e_sum, e_prev, dt, Kp, Ki, Kd);

    % Compute slopes via State-Space function
    dx = circuit_dynamics(x, Vin, d, L, C, R);

    % Discrete integration (Euler Method)
    x = x + dx * dt;

    % Save data for visualization
    history_vC(k) = vC;
    history_iL(k) = x(1);
    history_d(k) = d;
end

% --- Plotting Results ---
figure(1);
subplot(3,1,1);
plot(t*1000, abs(history_vC), 'b', 'LineWidth', 1.5); hold on;
plot(t*1000, ones(1, N)*Vref, 'r--', 'LineWidth', 1);
title('Output Voltage Regulation'); ylabel('Voltage |Vc| (V)'); grid on;

subplot(3,1,2);
plot(t*1000, history_iL, 'g', 'LineWidth', 1.5);
title('Inductor Current Response'); ylabel('Current iL (A)'); grid on;

subplot(3,1,3);
plot(t*1000, history_d * 100, 'm', 'LineWidth', 1.5);
title('PID Controlled Duty Cycle'); ylabel('Duty Cycle (%)'); xlabel('Time (ms)'); grid on;

fprintf('Simulation finished in %.2f seconds.\n', toc(clk));
