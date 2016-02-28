funcprot(0)
//pi/4-DQPSK modulation for the educational use.
function DQPSK(b, f, Fs, T)
//DQPSK(b, f, Fs, T) b - binary sequence (signal), f - carrier frequency, Fs - sampling frequency, T - symbol duration.

//Verification of input arguments.
[lhs, rhs] = argn(0)
if rhs > 4 then
    error("Too many arguments.")
elseif rhs == 1 then
    f = 100 //If there is no carrier frequency it's 100.
    Fs = 48000 //If there is no sampling frequency it's 48000.
    T = 0.01 //If there is no symbol duration it's 0.01.
end
    if f < 0
        error("Carrier frequency must be more than 0.")
    elseif Fs < 0
        error("Sampling frequency must be more than 0.")
    elseif T < 0
        error("Symbol duration must be more than 0.")
end

//Check parity.
r = length(b)/2
re = ceil(r)
val = re -r
if val ~= 0 then
    error("Input sequence with even number of bits.")
end

//Calculating arrays for plot.
fis = 0
sgn = zeros(1, (length(b)/2)*Fs*T)
t = 1/Fs:1/Fs:(length(b)/2)*T
w = 2*%pi*f
fi = zeros(1, length(b)/2)
counter = 1

for n = 1:2:length(b)
    if b(n) == 0 & b(n+1) == 0
        fis  = fis + %pi/4
    elseif b(n) == 0 & b(n+1) == 1
        fis = fis + (3*%pi)/4
    elseif b(n) == 1 & b(n+1) == 0
        fis = fis - %pi/4
    elseif b(n) == 1 & b(n+1) == 1
        fis = fis - (3*%pi)/4
    end
    if fis > %pi then fis = fis - %pi
    else fi(counter) = fis
    end
    counter = counter+1
end

for i = 1:1:(length(b)/2)
    for j = (i-1)*Fs*T+1:1:i*Fs*T
        sgn(j) = sin(w*t(j))*cos(fi(i))+cos(w*t(j))*sin(fi(i))
    end
end

//Oscillogram of a modulated signal.
scf(0)
plot(t, sgn)

endfunction

DQPSK([1 1 1 1 0 0 0 0 1 0 0 1])
