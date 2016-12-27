function [y] = schroeder(x,delays,rt60,fs)
% function [y] = schroeder(x,delays,rt60,fs)
% x = input signal (monophonic sound or impulse)
% delays = delay line lengths (of comb filters) in samples
% rt60 = reverberation time at zero-frequency (e.g., 1.5)
% fs = sampling rate (e.g., 44100)
%
% This code was created by
% Riitta V滗n鋘en
% Helsinki UNiversity of Technology
% Laboratory of Acoustics and Audio Signal Processing
% email: riitta.vaananen@hut.fi
% 
% Copyright 10.5.2000 Riitta V滗n鋘en
%
%

% example delays:
% delays = [2191 2971 3253  3307];

% allpass filter delays:
 apdelays = [441 713];
 apgains = [0.5 0.5];
%
% fs = 44100
% lowpass filter coefficients
%
% Feedback gain:
%Kp = zeros(1,length(delays));
Kp = 10.^((-3.0.*delays)./(rt60*fs))

% Lowpass filter coefficients:
Bp = zeros(1,length(delays));   %Bp=[0 0 0 0]
alpha = 0.25; % the ratio between the reverb times at nyquist and zero frequency
Bp = ones(1,length(delays)) - 2./(1 + Kp.^(1 - 1/alpha))

beta = Kp.*(1-Bp)   % 这句与上一句可以用一句来实现：beta=Kp.*(2./(1 + Kp.^(1 - 1/alpha)))
% lowpass filter (first order allpole) delays
lp_d = zeros(1,length(delays));

%y = zeros(length(delays),length(x(1,:)));
y = zeros(1,length(x));

% initialization of delay lines
delaylines = zeros(length(delays),max(delays));

% allpass delay lines:
apdelaylines = zeros(2,max(apdelays));

% delay line pointers
dl_p = ones(1,length(delays));

ap_dlp1 = 1;
ap_dlp2 = 1
% temporary variables
temp_out = zeros(length(delays),1)


%length(x(1,:))

ap_out1 = 0;
ap_out2 = 0;

for i=1:length(x),
   %i
   
   for j = 1:length(delays),
     y(i) = y(i) + temp_out(j); % sum the delay line outputs
   
   	% input of the delay line (input x + output fed back to the delay line)
   	%delaylines(j,dl_p(j)) = x(i) + delaylines(rem(dl_p(j),delays(j)) + 1) * beta(j);
 		delaylines(j,dl_p(j)) = x(i) + temp_out(j);
  % keyboard;
		% delay line pointer update 
 		dl_p(j) = mod((dl_p(j)+1),delays(j)) + 1;
		
       % temporary output of each delay line;
       % This is a lowpass filtered and attenuated delay line output
      temp_out(j) = (delaylines(j,dl_p(j)) + Bp(j)*lp_d(j))*beta(j);
      
      % store the delay line output to the lowpass filter delay 
      % for use in the next round
      lp_d(j)=delaylines(j,dl_p(j));

   end
   
   	
      % Allpass filter 1:
   	apdelaylines(1,ap_dlp1) = y(i) + ap_out1 * apgains(1);	   
      
      % delay pointer update
      ap_dlp1 = mod(ap_dlp1+1,apdelays(1)) + 1;
      
      % output computation
      ap_out1 =  apdelaylines(1,ap_dlp1) - apgains(1) * y(i);
      
      %y(i) = ap_out1 + x(i);
      
      
      % Allpass filter 2:
      
      apdelaylines(2,ap_dlp2) = y(i) + ap_out2 * apgains(2);	   
      
      % delay pointer update
      ap_dlp2 = mod(ap_dlp2+1,apdelays(2)) + 1;
      
      % output computation
      ap_out2 =  apdelaylines(2,ap_dlp2) - apgains(2) * y(i);
      
      y(i) = ap_out2 + x(i);
   
end   
y=y*0.8/max(y);

      
   