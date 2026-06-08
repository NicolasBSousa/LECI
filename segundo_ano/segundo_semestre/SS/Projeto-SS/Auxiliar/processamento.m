% -------------------------------------------------------------------------
% Projeto: Sistema de Controlo de Acesso via Tons
% Autores: Daniel Zamurca (118799) e Nicolas Sousa (119744) - Turma P3
% Script: Etapas e teste do processamento
% -------------------------------------------------------------------------

%% Parâmetros do Sistema
fs = 20000;          % Frequência de amostragem
N = 64;              % Tamanho do bloco (16-1024) => Maior/menor eixo X
f_tom = 1870;        % Frequência do buzzer (0-10k) => Maior/menor "velocidade" do sinal
Amp = 1000;           % Amplitude do sinal do microfone (0-2048) => Maior/menor amplitude do sinal

% Gerar sinais
n = 0:N-1;           % Vetor de amostras discreto

% Sinal analógico puro
sinal_ac = Amp * sin(2*pi*f_tom*n/fs);

%% Processamento do sinal

% ETAPA 1: Sinal Bruto da ADC
sinal_bruto = sinal_ac + 2048;

% ETAPA 2: Remoção do Offset CC (Subtrair o centro fixo de 2048)
% Nota: Usamos 2048 fixo em vez de mean() para o gráfico não ficar descaído 
% quando o bloco N não contiver um número inteiro de ciclos
sinal_centrado = sinal_bruto - 2048; 

% ETAPA 3: Normalização de Amplitude 
sinal_normalizado = sinal_centrado / 2048;

%% Visualização das etapas do processamento

% Gráfico 1: Sinal Bruto (Quantização da ADC)
figure;
subplot(3,1,1);
plot(n, sinal_bruto); % Gráfico discreto (pontos)
title('Etapa 1: Sinal Bruto da ADC (Quantização)');
xlabel('Amostra (n)');
ylabel('Níveis Digitais (0-4095)');
ylim([0 4095]); % Mostra a gama total da ADC
xlim([0 N]);
grid on;

% Gráfico 2: Remoção do Offset CC
subplot(3,1,2);
plot(n, sinal_centrado);
title('Etapa 2: Remoção do Offset CC (Componente DC)');
xlabel('Amostra (n)');
ylabel('Amplitude Discreta');
ylim([-2048 2047]); % Mostra a gama após o offset
xlim([0 N]);
grid on;

% Gráfico 3: Normalização de Amplitude
subplot(3,1,3);
plot(n, sinal_normalizado);
title('Etapa 3: Normalização de Amplitude (Formato float32)');
xlabel('Amostra (n)');
ylabel('Amplitude Normalizada');
ylim([-1.1 1.1]); % Mostra o teto analítico de -1 a 1
xlim([0 N]);
grid on;