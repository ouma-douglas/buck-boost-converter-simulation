function [d, e_sum, e_prev] = pid_controller(v_ref, v_meas, e_sum, e_prev, dt, Kp, Ki, Kd)
    % Calculate Error (Note: Buck-Boost inverts output voltage polarity)
    error = v_ref - abs(v_meas);

    % Discrete Integration & Differentiation
    e_sum = e_sum + error * dt;
    e_diff = (error - e_prev) / dt;

    % PID Control Formula
    u = Kp*error + Ki*e_sum + Kd*e_diff;

    % Saturation Constraints (Keep duty cycle within physical bounds)
    d = u;
    if d > 0.85, d = 0.85; end
    if d < 0.05, d = 0.05; end

    e_prev = error;
end
