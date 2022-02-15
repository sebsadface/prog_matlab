
%%% Problem 1
data = readmatrix('lynx.csv');
t = data(1, :);
pop = data(2, :);
%%% Don't delete the lines above when submitting to gradescope

%%% Replace the value of the population for the years given in the assignment file and save it as A1
pop(1956-1946+1) = 34;
pop(1974-1946+1) = 27;
A1 = pop;

%%% Calculate the value of the cubic spline interpolation of the data at t = 24.5 using the interp1 function.  Save this as A2.
tplot = linspace(min(t), max(t), 10000);
A2 = interp1(t, pop, 24.5, 'spline', 'extrap');

%%% Use polyfit to calculate the coefficients for A3, A5, and A7
%%% Use norm to calculate the error for A4, A6, and A8
A3 = polyfit(t, pop, 1);
A4 = norm(polyval(A3, t) - pop);
A5 = polyfit(t, pop, 2);
A6 = norm(polyval(A5, t) - pop);
A7 = polyfit(t, pop, 10);
A8 = norm(polyval(A7, t) - pop);

%%% Problem 2
data = readmatrix('CO2_data.csv');
t = data(1, :);
co2 = data(2, :);
%%% Don't delete the lines above when submitting to gradescope

%%% Use polyfit to calculate the coefficients for A9
%%% Use norm to calculate the error for A10
A9 = polyfit(t, co2, 1);
A10 = norm(polyval(A9, t) - co2);

%%% Fit the exponential
coeffs = polyfit(t, log(co2 -260),1);
A11 = [exp(coeffs(2)), coeffs(1), 260];
A12 = norm(exp(coeffs(1) * t + coeffs(2)) + 260 - co2);

%%% Fit the sinusoidal
%%% There are a few different ways to do this, and we will refrain from giving away the answer to this part.  The class has been doing loops for a while now, so this part should be doable, albeit a little tricky.  We can however check to see if there are any bugs that we can spot.
amp = 0;
amp_max = -1;
amp_min = 1;
for i = 1:62
    for j = 1:12
        amp_max = max(amp_max, co2(12 * (i - 1) + j)- (exp(coeffs(2)) * exp(coeffs(1) * t(12 * (i - 1) + j)) + 260));
        amp_min = min(amp_min, co2(12 * (i - 1) + j)- (exp(coeffs(2)) * exp(coeffs(1) * t(12 * (i - 1) + j)) + 260));
    end
    amp = amp + (amp_max - amp_min) / 2;
end
A13 = [amp / 62, 12];
A14 = norm(exp(coeffs(1) * t + coeffs(2)) + 260 - co2)