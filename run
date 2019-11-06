clc
clear
dbstop if error
instVec = [];
for inst = 3:29
    itervec = [150];                  %parámetro calibrado en la investigación
    probMvec = [0.1];                 %parámetro calibrado en la investigación
    siter = size(itervec, 2);
    d = 'D:/RUTA_DE_LAS_INSTANCIAS';  % directorio de instancias,modificar según convenga 
    f = dir(fullfile(d));
    
    %Primer for - Instancias
    inpath = f(inst).name;
    sinpat = size(inpath, 2);
    direc = strcat('RESULTADOS', inpath(1:sinpat-4));            %crea la carpeta de resultados
    mkdir(direc);
    
    %Segundo for - varia primer parametro: Poblacion Inicial
    for Pob = 300:300                                               % en este caso se modifica según el valor de tamaño de población definido
        %tercer for - varia segundo parametro: Probabilidad de Cruce
        for probC = 0.8:0.8                                         % en este caso se modifica según el valor de probabilidad de cruce definido
            %cuarto for - varia probabilidad de mutacion
            for probM = 1:siter                                     %Este valor puede ser puesto como un parametro 
                %quinto for  - varia tercer parametro: Numero de Iteraciones
                for it = 1:siter
                    %Carga de parametros iniciales
                    iter = itervec(it);
                   
                   % Cargar Instancia:
                    load(inpath);
                    tic;
                    
                    %Generar poblacion inicial aleatoriamente
                    inipob = initR(Pob, AT);
                    sp = size(inipob, 2);
                    vecGen = [];
                    vecFab = [];
                    for i = 1:iter
                        disp(i)
                        vecmsp = [];
                        matF = [];
                        for j = 1:sp
                            [vecF, OG, vecS] = evalPro(inipob(:, j), ASIG, ST, PT);
                            vecE = evalEn(inipob(:, j), AST, AT);
                            mkspn = objfunc(OG, vecF, vecE, inipob(:, j), vecS);
                            vecmsp = [vecmsp, mkspn];
                            matF = [matF; vecF];
                        end
                        inipob = [inipob; vecmsp];
                        sc = size(inipob, 1);
                        [minv, idx] = sortrows(inipob', sc, 'ascend');
                        minCr = minv(1, :)';
                        minF = matF(idx(1), :);
                        vecGen = [vecGen, minCr];
                        vecFab = [vecFab; minF];
                        selected = selection(inipob);               %llamado función selección
                        crossed = crossover(selected, probC);       %llamado función cruce
                        mutated = mutation(crossed, probMvec(probM));      %llamado función mutación
                        inipob = mutated;
                        sp = size(inipob, 2);
                    end
                    
                    %Función fitness
                    vecmsp = [];
                    vecPenalty = [];
                    for j = 1:sp
                        [vecF, OG, vecS] = evalPro(inipob(:, j), ASIG, ST, PT);
                        vecE = evalEn(inipob(:, j), AST, AT);
                        mkspn = objfunc(OG, vecF, vecE, inipob(:, j), vecS);
                        vecmsp = [vecmsp, mkspn];
                        mspMean = mean(vecmsp);
                        if mkspn > mspMean
                            vecPenalty = [vecPenalty, mkspn + abs(mkspn-mspMean)];
                        else
                            vecPenalty = [vecPenalty, mkspn];
                        end
                    end
                    
                    % impresión de los resultados 
                    inipob = [inipob; vecPenalty];
                    sc = size(inipob, 1);
                    [minv, idx] = sortrows(inipob', sc, 'ascend');
                    minCr = minv(1, :)';
                    minF = matF(idx(1), :);
                    vecGen = [vecGen, minCr];
                    vecFab = [vecFab; minF];
                    vecsol = genVecSol(F, minF, minCr(1:end-1)', min(vecmsp));
                    xr = 1:sp;
                    xr2 = 1:iter+1;
                    cpuTime = toc;
                    figure
                    subplot(1, 2, 1)
                    scatter(xr, vecmsp)
                    title('Resultados')
                    xlabel('cromosomas')
                    ylabel('makespan')
                    subplot(1, 2, 2)
                    scatter(xr2, vecGen(end, :))
                    title('Mejor Resultado por Generacion')
                    xlabel('Generaciones')
                    ylabel('Mejor MakeSpan')
                    direcint = strcat(direc, "/", num2str(Pob), "_", num2str(probC), "_", num2str(probMvec(probM)), "_", num2str(iter));
                    mkdir(direcint)
                    filename = strcat(direcint, '/workspace.mat');
                    figname  = strcat(direcint, '/figure.fig');
                    save(filename)
                    savefig(figname)
                    close all
                end
            end
        end
    end
end
