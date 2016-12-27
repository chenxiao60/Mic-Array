%% Example code for multichannel Wiener filtering
% Author: Antoine Deleforge
% Contact: deleforge@LNT.de
% Lehrstuhl für Multimediakommunikation und Signalverarbeitung
% University of Erlangen-Nuremberg, 2014
%%
% Parameters:
fs = 16000; % Desired frequency of sampling (Hz)
tw = 20; % Spectrogram window length (ms)
ov = 50; % Percentage of overlap

soundfile='static_female.wav';
noisefile='static_nosource.wav';

% Estimate the noise covariance matrices:
Rnn = cov_estimate(noisefile,fs,tw,ov);

% Multichannel Wiener filtering:
out = mwf(soundfile,Rnn,fs,tw,ov);

% Write output file:
% wavwrite(['result_',soundfile],out,fs);