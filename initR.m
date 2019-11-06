function inipob = initR(P, AT)
s1 = size(AT, 1);
%poblacion inicial aleatoria.
inipob = [];
vec = 1:s1;
for i = 1:P
    vec = vec(randperm(length(vec)));
    inipob = [inipob, vec'];
end
end