function Rnn = cov_estimate(tw,ov)
%% Frequency-domain covariance matrices estimation
% This script estimates the covariance matrices of a reference noise signal
% in the frequency domain. These matrices can then be used to perform
% multichannel wiener filtering on a noisy signal.
%
% Requires:
%       sft.m -   Short-time Fourier transform 
%
% Input: 
%   - soundfile (string) : Path to an M-channel reference noise sound file
%   - fs (int) : Desired frequency of sampling
%   - tw (double) : Spectrogram time window's length in milisecond
%   - ov (double) : Percentage of overlap between consecutive time windows
%
% Output:
%   - Rnn (MxMxF) : Rnn(:,:,f) is the estimated covariance at frequency f
%
% Author: Antoine Deleforge
% Contact: deleforge@LNT.de
% Lehrstuhl für Multimediakommunikation und Signalverarbeitung
% University of Erlangen-Nuremberg, 2014

%% Extract signals from file
wavchunksizefix1( 'noise1.wav' );
wavchunksizefix1( 'noise2.wav');
wavchunksizefix1( 'noise3.wav' );
wavchunksizefix1('noise4.wav');
wavchunksizefix1('noise5.wav');
wavchunksizefix1('noise6.wav');

[nn1, fs] = wavread('noise1.wav'); % Load signal
[nn2, fs] = wavread('noise2.wav'); % Load signal
[nn3, fs] = wavread('noise3.wav'); % Load signal
[nn4, fs] = wavread('noise4.wav'); % Load signal
[nn5, fs] = wavread('noise5.wav'); % Load signal
[nn6, fs] = wavread('noise6.wav'); % Load signal
   nn1=nn1(1.35*8000:3.35*8000,1);
   nn2=nn2(1.35*8000:3.35*8000,1);
   nn3=nn3(1.35*8000:3.35*8000,1);
   nn4=nn4(1.35*8000:3.35*8000,1);
   nn5=nn5(1.35*8000:3.35*8000,1);
   nn6=nn6(1.35*8000:3.35*8000,1);
nn=[nn1 nn2 nn3 nn4 nn5 nn6];
M = size(nn,2);
% resample signal to desired frequency fs:
n1=resample(nn(:,1), fs, fs);
Q=size(n1,1);
n=zeros(Q,M);
n(:,1)=n1;
for m=2:M
    n(:,m) = resample(nn(:,m), fs, fs);
end

%% Short time fourier transform
N1 = stft(n(:,1), fs, tw, ov)';
[F,T] = size(N1);
N=zeros(M,F,T);
N(1,:,:)=N1;
for m=2:M
    N(m,:,:)= stft(n(:,m), fs, tw, ov)';
end


%% Compute noise covariance matrices
Rnn = zeros(M,M,F);
for t=1:T
    for f=1:F  
            Rnn(:,:,f) = Rnn(:,:,f)+N(:,f,t)*N(:,f,t)';
    end	
end
Rnn = Rnn./T + 1e-10; % (regularization)
end