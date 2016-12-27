function [ y_out ] = istft( Y, Fs, framelength_ms, overlap_percent )
% The inverse STFT reconstructs the time signal for the given STFT matrix Y

% Frame length in samples
framelength_samples = round(Fs * framelength_ms / 1000);
% Overlap of timeframes in samples
overlap_samples = (overlap_percent/100)*framelength_samples;
% Stepsize used in the for loop
stepsize = framelength_samples - overlap_samples;
% Read the length of the FFT
fftlength = length(Y(1,:));
% Read the number of frames
frames = length(Y(:,1));
% Initializing the output time signal
y_out = zeros(framelength_samples + (frames)*stepsize,1);
offset = 0;
% inverse STFT calculation
for i = 1:frames
    tmp = ifft(Y(i,:),fftlength);
    y_out(1 + offset: offset + framelength_samples,1) = y_out(1 + offset: offset + framelength_samples,1) + tmp(1,1:framelength_samples)';
    offset = offset + stepsize;
end
end

