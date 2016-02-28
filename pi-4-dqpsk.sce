funcprot(0)
// pi/4-DQPSK
function DQPSK(b, f, Fs, T)
//b - двоичная последовательность, f - частота несущей, Fs - частота дискретизации, T - длительость символа.

//Проверяем правильность ввода аргументов.
[lhs, rhs] = argn(0)
if rhs > 4 then
    error("Слишком много аргументов")
elseif rhs == 1 then
    f = 100 //Если частота несущей не указана, она равна 100.
    Fs = 48000 //Если частота дискретизации не указана, она равна 48000.
    T = 0.01 //Если длительность символа не указана, она равна 0.01.
end
    if f < 0
        error("Частота несущей должна быть больше 0")
    elseif Fs < 0
        error("Частота дискретизации должна быть больше 0")
    elseif T < 0
        error("Длительность символа должна быть больше 0")
end

//Проверка четности
r = length(b)/2
re = ceil(r)
val = re -r
if val ~= 0 then
    error("Введите последовательность с четным количеством элементов")
end

//Заполнение массивов для графиков
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

scf(0)
plot(t, sgn)
//scf(1)
//x = 0:%pi/4:2*%pi
//y = ones(1,9)
//polarplot(x, y) //угол, радиус

endfunction

DQPSK([1 1 1 1 1 1])
