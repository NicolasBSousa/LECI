% -------------------------------------------------------------------------
% Projeto: Sistema de Controlo de Acesso via Tons
% Autores: Daniel Zamurca (118799) e Nicolas Sousa (119744) - Turma P3
% Script: Determinação dos K's do filtro de Hamming
% -------------------------------------------------------------------------

%% Parâmetros do Sistema
fs = 20000;
ts = 1/fs;
N = 64;
M = N-1;
fc = 50/fs;
BW = 4/M;

% Confirmar soma
h_provisorio = zeros(1, N);

%% Determinação do filtro base de Hamming
soma = 0;
for n = 0:M

    n_aux = n - (M/2);
    
    valor_h = sin(2*pi*fc*n_aux) / (pi*n_aux);
    valor_window = 0.54 - 0.46*cos((2*pi*n)/M);
    
    h_provisorio(n+1) = valor_h * valor_window;
    soma = soma + h_provisorio(n+1);
end

K = 1 / soma;
h_final = h_provisorio * K;

disp(K);

