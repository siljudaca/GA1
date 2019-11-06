function vecsol = genVecSol(F, minF, minCr, msp)
vecsol = [];
for i = 1:F
    if nnz(minF(i).orden) > 0
        vecsol = [vecsol, 0, minF(i).orden(1, :)];
    end
end
vecsol = [vecsol, 0, minCr, 0, msp];
end