function out = mwf(Rnn,tw,ov)
%% Multichannel Wiener filtering
% This script applies multi-channel Wiener filtering to an M-channel
% recording, using the reference noise covariance matrices in Rnn. It
% outputs a clean M-channel signal.
%
% Requires:
%       sft.m -   Short-time Fourier transform 
%       istft.m - Inverse short-time Fourier transform
%
% Input: 
%   - soundfile (string) : Path to an M-channel sound file
%   - Rnn (MxMxF) : Rnn(:,:,f) is the noise covariance at frequency f
%   - fs (int) : Desired frequency of sampling
%   - tw (double) : Spectrogram time window's length in milisecond
%   - ov (double) : Percentage of overlap between consecutive time windows
%
% Output:
%   - out (Q x M) : Clean M-channel signal
%
% Reference:
%   I. Cohen, J. Benesty, and S. Gannot, Speech Processing in Modern
%   Communication, Springer, Berlin, Heidelberg, 2010, Chapter 9.

%
% Authors: Antoine Deleforge - Stefan Meier - Alexander Valyalkin
% Contact: deleforge@LNT.de
% Lehrstuhl für Multimediakommunikation und Signalverarbeitung
% University of Erlangen-Nuremberg, 2014

%% Internal Parameters
cfg.lambda = 0.999;  % Forgetting factor
cfg.MWF_Reg = 1e-10; % Regularization
cfg.SDW = 1; % Speech Distortion Weigthed MWF parameter

%% Extract signals from file
wavchunksizefix1( 'spa1.wav' );
wavchunksizefix1( 'spa2.wav');
wavchunksizefix1( 'spa3.wav' );
wavchunksizefix1('spa4.wav');
wavchunksizefix1('spa5.wav');
wavchunksizefix1('spa6.wav');
[xx1, fs] = wavread('spa1.wav'); % Load signal
[xx2, fs] = wavread('spa2.wav'); % Load signal
[xx3, fs] = wavread('spa3.wav'); % Load signal
[xx4, fs] = wavread('spa4.wav'); % Load signal
[xx5, fs] = wavread('spa5.wav'); % Load signal
[xx6, fs] = wavread('spa6.wav'); % Load signal
  xx1=xx1(1.35*8000:3.35*8000,1);
  xx2=xx2(1.35*8000:3.35*8000,1);
   xx3=xx3(1.35*8000:3.35*8000,1);
   xx4=xx4(1.35*8000:3.35*8000,1);
   xx5=xx5(1.35*8000:3.35*8000,1);
   xx6=xx6(1.35*8000:3.35*8000,1);
xx=[xx1 xx2 xx3 xx4 xx5 xx6];
M = size(xx,2);
% resample signal to desired frequency fs:
x1=resample(xx(:,1), fs, fs);
Q=size(x1,1);
n=zeros(Q,M);
x(:,1)=x1;
for m=2:M
    x(:,m) = resample(xx(:,m), fs, fs);
end

%% Short time fourier transform
X1 = stft(x(:,1), fs, tw, ov)';
[F,T] = size(X1);
X=zeros(M,F,T);
X(1,:,:)=X1;
for m=2:M
    X(m,:,:)= stft(x(:,m), fs, tw, ov)';
end

%% Multichannel Wiener Filtering
Rxx = repmat(eye(M),[1,1,F]);

Out=zeros(M,F,T);

for t=1:T
	for f=1:F
        % Recursive averaging:
		Rxx(:,:,f) = cfg.lambda*Rxx(:,:,f) + (1-cfg.lambda) * X(:,f,t)*X(:,f,t)';
        
		tmp_inv = Rnn(:,:,f)\Rxx(:, :, f);
		G = (tmp_inv - eye(M))./(1/cfg.SDW + trace(tmp_inv) - M);
		
		Out(:,f,t) = G' * X(:,f,t);
	end	
end

%% Obtaining time-domain signals
out1 = istft( squeeze(Out(1,:,:))', fs, tw, ov);
Q = numel(out1);
out = zeros(Q,M);
out(:,1)=out1;
for m=1:M
    out(:,m)=istft(squeeze(Out(m,:,:))', fs, tw, ov);
end

end