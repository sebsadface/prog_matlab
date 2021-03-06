
%%%  Problem 1
%%%  First go to the end of your m-file to create your Jacobi and
%%%  Gauss-Seidel functions.

%%% Once you have created your functions return here.
%%% Initialize your matrix A and RHS b
A = [1.1, 0.2, -0.2, 0.5; 0.2, 0.9, 0.5, 0.3;
     0.1, 0, 1, 0.4; 0.1, 0.1, 0.1, 1.2];
b = [1; 0; 1; 0];

%%% Use your Jacobi and Gauss-Seidel functions to find A1 through A4.
[Tj_2, Ej_2] = Jacobi(A, b, 1e-2);
[Tj_4, Ej_4] = Jacobi(A, b, 1e-4);
[Tj_6, Ej_6] = Jacobi(A, b, 1e-6);
[Tj_8, Ej_8] = Jacobi(A, b, 1e-8);
[Tgs_2, Egs_2] = GaussSeidel(A, b, 1e-2);
[Tgs_4, Egs_4] = GaussSeidel(A, b, 1e-4);
[Tgs_6, Egs_6] = GaussSeidel(A, b, 1e-6);
[Tgs_8, Egs_8] = GaussSeidel(A, b, 1e-8);

A1 = [Tj_2, Tj_4, Tj_6, Tj_8];
A2 = [Ej_2, Ej_4, Ej_6, Ej_8];
A3 = [Tgs_2, Tgs_4, Tgs_6, Tgs_8];
A4 = [Egs_2, Egs_4, Egs_6, Egs_8];

%%%  Problem 2
%%%  Initialize your Day 0 vector x
x = [0.9; 0.09; 0.01];
      
%%%  Part 1: without a vaccine
%%%  Make sure to have p = 0
%%%  Initialize the SIR matrix M, and save it as A5
A5 = [1 - 1 / 200, 0, 1 / 10000; 
      1 / 200, 1 - 1 / 1000, 0; 
      0, 1 / 1000, 1 - 1 / 10000];


%%%  Create a loop to find the day that the number of infected
%%%  individuals hits 50% and another loop for the steady state of the
%%%  infected population
%%%  There is a way to put everything under one loop if you make clever use
%%%  of conditionals
D0 = 0;
while x(2) < 0.5
    x = A5 * x;
    D0 = D0 + 1;
end

x_pre = x + 10;
while abs(x_pre(2) - x(2)) > (1e-8)
    x_pre = x;
    x = A5 * x;
end
F0 = x(2);

%%% Save the days and steady state in a row vector A6
A6 = [D0, F0];

%%%  Reinitialize your Day 0 vector x
x = [0.9; 0.09; 0.01];

%%%  Part 2: with a vaccine
%%%  Make sure to have p = 2/1000
%%%  Initialize the SIR matrix M, and save it as A7
A7 = [1 - (1 / 200 + 2 / 1000), 0, 1 / 10000; 
      1 / 200, 1 - 1 / 1000, 0; 
      2 / 1000, 1 / 1000, 1 - 1 / 10000];

%%%  Create a loop to find the day that the number of infected
%%%  individuals hits 50% and another loop for the steady state of the
%%%  infected population
%%%  There is a way to put everything under one loop if you make clever use
%%%  of conditionals
D1 = 0;
while x(2) < 0.5
    x = A7 * x;
    D1 = D1 + 1;
end

x_pre = x + 10;
while abs(x_pre(2) - x(2)) > (1e-8)
    x_pre = x;
    x = A7 * x;
end
F1 = x(2);

%%% Save the days and steady state in a row vector A8
A8 = [D1, F1];
 
%%%  Problem 3
  
%%%  Initialize your 114x114 tridiagonal matrix A
A = diag(diag(zeros(114)) + 2) + diag(diag(zeros(114), -1) - 1, -1) + diag(diag(zeros(114), 1) - 1, 1);
A9 = A;

%%%  Initialize your 114x1 RHS column vector rho
rho = zeros(114, 1);
for i = 1 : 114
    rho(i) = 2 * (1 - cos(53 * pi / 115)) * sin(53 * pi * i / 115);
end
A10 = rho;

%%%  Implement Jacobi's method for this system.
%%%  Don't use the function you created before because that was designed for
%%%  a specific task, and will not work here.
L = tril(A, -1);
U = triu(A, +1);
D = diag(A);
n = size(A,1);
phi_k = ones(n, 1);
M = -(L + U) ./ D;
c = rho ./ D;
T = 1;
phi_pre = phi_k + 1;
while max(abs(phi_k - phi_pre)) >= 1e-5
    phi_pre = phi_k;
    phi_k = M * phi_k + c;
    T = T + 1;
end
A11 = phi_k;
A12 = T;

%%%  Create a column vector phi that contains the exact solution given in
%%%  the assignment file
phi_true = zeros(114, 1);
for i = 1 : 114
    phi_true(i) = sin(53 * pi * i / 115);
end

%%%  Save the difference of the Jacobi solution and the exact solution as
%%%  A13.  Use the maximal entry in absolute value to calculate this error.
A13 = max(abs(phi_true - A11));

%%%  Implement Gauss-Seidel for this system.
%%%  Don't use the function you created before because that was designed for
%%%  a specific task, and will not work here.
LpD = tril(A);
U = triu(A, +1);
n = size(A,1);
phi_k = ones(n, 1);
M = -LpD \ U;
c = LpD \ rho;
T = 1;
phi_pre = phi_k + 1;
while max(abs(phi_k - phi_pre)) >= 1e-5
    phi_pre = phi_k;
    phi_k = M * phi_k + c;
    T = T + 1;
end
A14 = phi_k;
A15 = T;

%%%  Save the difference of the Gauss-Seidel solution and the exact solution as
%%%  A13.  Use the maximal entry in absolute value to calculate this error.
A16 = max(abs(phi_true - A14));

%%% Jacobi and Gauss Seidel Iteration functions
%%% Create your functions here
%%% Both functions will need two outputs and three inputs
%%% The code within the function will be very similar to
%%% Week 4 coding lecture 2
function [T, E] = Jacobi(A, b, e)
    L = tril(A, -1);
    U = triu(A, +1);
    D = diag(A);
    n = size(A,1);
    y = zeros(n, 1);
    M = -(L + U) ./ D;
    c = b ./ D;
    T = 0;
    while max(abs(A * y - b)) >= e
        T = T + 1;
        y = M * y + c;
    end
    E = max(abs(A * y - b));
end

function [T, E] = GaussSeidel(A, b, e)
    LpD = tril(A);
    U = triu(A, +1);
    n = size(A,1);
    y = zeros(n, 1);
    M = -LpD \ U;
    c = LpD \ b;
    T = 0;
    while max(abs(A * y - b)) >= e
        T = T + 1;
        y = M * y + c;
    end
    E = max(abs(A * y - b));
end
