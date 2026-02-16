% FFT
% replace
N = numel(aF);
A = abs(fft(aF));

% with
p = app.getFFTParams();
A = abs(fft(aF, p.Nfft));
f = (0:p.Nfft-1)*(fs/p.Nfft);

% Spectrogram
% replace 
window = hamming(512);
noverlap = 256;
nfft = 1024;
% with
p = app.getFFTParams();
window   = hamming(p.WindowLength);
noverlap = p.OverlapLength;
nfft     = p.Nfft;

% PSD
% replace
[P,f] = pwelch(x, hamming(2048), 1024, 2048, fs);
% with
p = app.getFFTParams();
[P,f] = pwelch(x, hamming(p.WindowLength), p.OverlapLength, p.Nfft, fs);


% Band‑Limited
% replace
dB = app.bandLimitedDisp(aF, fs, t, f1, f2);
% with
p = app.getFFTParams();
dB = app.bandLimitedDisp(aF, fs, t, f1, f2, p);

