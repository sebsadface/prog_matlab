%%% Problem 1
%%% Implement the Bisection method as we did in the Week 5 Coding Lecture
t = (-1 : 0.001 : 10);
c = 1.3 * (exp(- t / 11) - exp(- 4 * t / 3));
dc = 1.3 * ((- t / 11) .* exp(- t / 11) - (- 4 * t / 3) .* exp(- 4 * t / 3));
plot(t, c, t, dc, 'LineWidth', 4);

a = 10;
b = -1;
df_a = 1.3 * ((- a / 11) .* exp(- a / 11) - (- 4 * a / 3) .* exp(- 4 * a / 3));
df_b = 1.3 * ((- b / 11) .* exp(- b / 11) - (- 4 * b / 3) .* exp(- 4 * b / 3));
tmid = (a + b) / 2;
df_mid = 1.3 * ((- tmid / 11) .* exp(- tmid / 11) - (- 4 * tmid / 3) .* exp(- 4 * tmid / 3));
while abs(df_mid) >= 1e-8
    if sign(df_mid) == sign(df_a)
        a = tmid;
    else 
        b = tmid;
    end
    tmid = (a + b) / 2;
    df_mid = 1.3 * ((- tmid / 11) .* exp(- tmid / 11) - (- 4 * tmid / 3) .* exp(- 4 * tmid / 3));
    df_a = 1.3 * ((- a / 11) .* exp(- a / 11) - (- 4 * a / 3) .* exp(- 4 * a / 3));
    df_b = 1.3 * ((- b / 11) .* exp(- b / 11) - (- 4 * b / 3) .* exp(- 4 * b / 3));
end

format long;
A1 = tmid;
A2 = 1.3 * (exp(- tmid / 11) - exp(- 4 * tmid / 3));
A3 = abs(df_mid);

%%% Problem 2
%%% Implement Newton's method as we did in the Week 5 Coding Lecture

x = 2;
A4 = 1;
while abs(2 * x) >= 1e-8
    x = x - x;
    A4 = A4 + 1;
end
A5 = x;


x = 2;
A6 = 1;
while abs(500 * x ^ 499) >= 1e-8
    x = x - (500 * x ^ 499) / (499 * 500 * x ^ 498);
    A6 = A6 + 1;
end
A7 = x;


x = 2;
A8 = 1;
while abs(1000 * x ^ 999) >= 1e-8
    x = x - (1000 * x ^ 999) / (1000 * 999 * x ^ 998);
    A8 = A8 + 1;
end
A9 = x;
