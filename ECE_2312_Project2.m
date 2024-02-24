clear;
clc;

%Frequently used parameters
fs = 44100; %Hz
l = 5; %s
N = l*fs; %Total # of samples
t = (0:N-1)/fs; %s

%Part 2: Sine Tone Generation------------------------------------------------------------------------------------------------------------------------------------------------
f = 5000; %Hz

%Sine wave
sine = sin(2*pi*f*t);
%sound(sine, fs);

%Write to file
filename = 'teamRLE-sinetone.wav';
audiowrite(filename, sine, 44100);

%Spectrogram
figure(1)
hold on;
spectrogram(sine,kaiser(256,5),220,512,fs,'yaxis');
ylim([0 10]);
title('5kHz Sine Tone Spectrogram');
hold off;

%Part 3: Chirp Signal Generation------------------------------------------------------------------------------------------------------------------------------------------------
f_start = 0; %Hz
f_end = 8000; %Hz
f = linspace(f_start, f_end, N); %Find frequency at any point in 5s duration

%Sine wave
phase = (2*pi*cumsum(f))/fs; %Integral of instantaneous freq is the 
sine1 = sin(phase);
%sound(sine1, fs);

%Write to file
filename = 'teamRLE-chirp.wav';
audiowrite(filename, sine1,44100);

%Spectrogram
figure(2)
hold on;
spectrogram(sine1,kaiser(256,5),220,512,fs,'yaxis');
ylim([0 10]);
title('0-8kHz Chirp Sine Tone Spectrogram');
hold off;

%Part 4: Some Fun with Sine Tone------------------------------------------------------------------------------------------------------------------------------------------------
%tone frequencies
f1 = 900;
f2 = 1000;
f3 = 800;
f4 = 400;
f5 = 600;

%durations (seconds)
d1 = 0.35;
d2 = 0.65;
d3 = 1;
d4 = 0.35;
d5 = 2;

%number of samples
n1 = fs*d1;
n2 = fs*d2;
n3 = fs*d3;
n4 = fs*d4;
n5 = fs*d5;

%total number of data points
t1 = (1:n1)/fs;
t2 = (n1 : n1+n2)/fs;
t3 = (n1+n2 : n1+n2+n3)/fs;
t4 = (n1+n2+n3 : n1+n2+n3+n4)/fs;
t5 = (n1+n2+n3+n4 : n1+n2+n3+n4+n5)/fs;

%soundwave
sound1 = sin(2*pi*f1*t1);
sound2 = sin(2*pi*f2*t2);
sound3 = sin(2*pi*f3*t3);
sound4 = sin(2*pi*f4*t4);
sound5 = sin(2*pi*f5*t5);
y = [sound1 sound2 sound3 sound4 sound5];
%sound(y, fs);

%Write to file
filename = 'teamRLE-cetk.wav';
audiowrite(filename,y,fs)

%Spectrogram
figure(3)
hold on;
spectrogram(y,kaiser(1024,10),880,4096,fs,'yaxis');
ylim([0 1.5]);
title('CETK Rendition Spectrogram');
hold off;

%Part 5: Combining Sound Files------------------------------------------------------------------------------------------------------------------------------------------------
[myRecording1, fs] = audioread('FirstPhrase.wav');
newRec = transpose(myRecording1); %Make column vector since sine tones save as column vector
sine2 = newRec + sine; %Add 5kHz sine tone and first phrase
%sound(sine2, fs);

%Write to file
filename = 'teamRLE-speechchirp.wav';
audiowrite(filename, sine2, 44100);

%Spectrogram
figure(4)
hold on;
spectrogram(sine2,kaiser(256,5),220,512,fs,'yaxis');
ylim([0 10]);
title('5kHz Sine Tone + First Phrase Spectrogram');
hold off;

%Part 6: Speech and Audio Filtering------------------------------------------------------------------------------------------------------------------------------------------------
sound3 = lowpass(sine2, 4000,fs,ImpulseResponse="fir",Steepness=0.99);
%sound(sound3, fs);

%Write to file
filename = 'teamRLE-filteredspeechsine.wav';
audiowrite(filename, sound3, 44100);

%Spectrogram
figure(5)
hold on;
spectrogram(sound3,kaiser(256,5),220,512,fs,'yaxis');
ylim([0 10]);
title('5kHz Sine Tone Filtered from First Phrase Spectrogram');
hold off;

%Part 7: Stereo Fun------------------------------------------------------------------------------------------------------------------------------------------------
sine_phrase = transpose(sine2); %Make 5Hz sine wave + First phrase a two row matrix instead of two column
stereo = [myRecording1 sine_phrase];
%sound(sound_array, fs);

%Write to file
filename = 'teamRLE-stereospeechsine.wav';
audiowrite(filename, stereo, 44100);

%Spectrogram
figure(6)
hold on;
spectrogram(myRecording1,kaiser(256,5),220,512,fs,'yaxis');
ylim([0 10]);
title('First Phrase Spectrogram');
hold off;

%Spectrogram of right stereo audio is Figure 4