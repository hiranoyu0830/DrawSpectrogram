function DrawSpectrogram(y,winsize,ovlp,fftsize,Fs)
% DrawSpectrogram スペクトログラムを描画
wavelen = length(y);

zeropad = fftsize - winsize;
S = ones(fftsize,ceil(wavelen/ovlp));
shift = 0;
framectr = 1;
w = hamming(winsize);

while shift + winsize <= wavelen
frame = y(shift+1:shift+winsize);
frame = filter([1 -0.97], 1, frame);
frame = frame.*w;
frame_padded = [frame; zeros(zeropad, 1)];
S(:, framectr) = 20*log10(abs(fft(frame_padded)));
shift = shift + ovlp;
framectr = framectr + 1;
end
t = 0:1/Fs:wavelen/Fs;

f = 0:Fs/fftsize:Fs/2;
f = f(:);
S = 7 * S + 265;
image(t, f, S(1:fftsize /2,:));
axis xy
colormap jet

end

