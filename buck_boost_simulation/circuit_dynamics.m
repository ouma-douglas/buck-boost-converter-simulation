function dx = circuit_dynamics(x, Vin, d, L, C, R)
    % x(1) = iL (Inductor Current)
    % x(2) = vC (Capacitor Voltage)
    iL = x(1);
    vC = x(2);

    % State-space averaged differential equations
    diL_dt = (d * Vin + (1 - d) * vC) / L;
    dvC_dt = (-(1 - d) * iL - (vC / R)) / C;

    dx = [diL_dt; dvC_dt];
end
