% -------------------------------------------------------------------------
% Projeto: Sistema de Controlo de Acesso via Tons
% Autores: Daniel Zamurca (118799) e Nicolas Sousa (119744) - Turma P3
% Script: Determinação dos valores do filtro de Hamming
% -------------------------------------------------------------------------

%% Parâmetros do Sistema
fs = 20000;
N = 64;
M = N-1;
fc = 50/fs;

freqs = [1500, 2220, 2940];

filterCoeffs = zeros(3,N);

%% Determinação dos coeficientes dos filtros
for i=1:3
    h_provisorio = zeros(1, N);
    soma = 0;
    
    for n = 0:M
        n_aux = n - (M/2);

        if n_aux == 0
            valor_h = 2*fc; 
        else
            valor_h = sin(2*pi*fc*n_aux) / (pi*n_aux);
        end

        valor_window = 0.54 - 0.46*cos((2*pi*n)/M);
        h_provisorio(n+1) = valor_h * valor_window;
        soma = soma + h_provisorio(n+1);
    end
    h_normalizado = h_provisorio / soma;
    n_vetor = 0:M;

    w0 = 2 * pi * (freqs(i) / fs);
    
    filterCoeffs(i,:) = h_normalizado .* cos(w0 * n_vetor);
end

%% Impressão dos valores para C
disp("T1=[")
fprintf(" %.16f ", filterCoeffs(1,:))
disp("];");

disp("T2=[")
fprintf(" %.16f ", filterCoeffs(2,:))
disp("];");

disp("T3=[")
fprintf(" %.16f ", filterCoeffs(3,:))
disp("];");