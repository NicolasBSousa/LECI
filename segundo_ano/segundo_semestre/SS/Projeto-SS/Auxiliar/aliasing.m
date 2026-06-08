% -------------------------------------------------------------------------
% Projeto: Sistema de Controlo de Acesso via Tons
% Autores: Daniel Zamurca (118799) e Nicolas Sousa (119744) - Turma P3
% Script: Aliasing
% -------------------------------------------------------------------------

%% Parâmetros do Sistema
fs = 20000;                  % Frequencia de amostragem
f_tons = [1500 2220 2940];     % Tons

%% Simulação do Aliasing
BW = max(f_tons)-min(f_tons);     
fprintf("A largura de banda (BW) é: %0.2f Hz\n", BW);

f_nyquist = fs/2;          % Verificar fs e nyquist

fprintf('Taxa de Nyquist necessária: %d Hz\n', 2 * max(f_tons));
fprintf('Frequência de amostragem usada: %d Hz\n', fs);

if fs > 2 * max(f_tons)
    disp('Critério de Nyquist Satisfeito.');
else
    disp('ERRO: Aliasing detetado!');
end

