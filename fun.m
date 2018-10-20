function x = fun(mb, nb, psf)
% rapporto autovalori condizioni periodiche/condizioni neumann
% prende in input la psf e le dimensioni [mb,nb] della matrice a cui
% si devono poter applicare le matrici di sfocatura generate

[m,n] = size(psf);
meta = floor(m/2);
% calcolo gli autovalori nel caso periodico
    a = [ psf zeros(m,nb-n) ; zeros(mb-m,nb)];
    traslm = [meta+1:mb 1:meta];
    trasln = [meta+1:nb 1:meta];
    a = a(traslm,trasln);
    autovaloriC = fft2(a);
% calcolo gli autovalori nel caso di neumann
    psfNW = psf(1:meta, 1:meta);
    psfNE = psf(1:meta, meta+1:end);
    psfSW = psf(meta+1:end, 1:meta);
    psfSE = psf(meta+1:end, meta+1:end);
    psfNW = rot90(psfNW,2);
    psfNE = flipud(psfNE);
    psfSW = fliplr(psfSW);
    psfNW(meta+1,meta+1) = 0;
    psfNE(meta+1,meta+1) = 0;
    psfSW(meta+1,meta+1) = 0;
    a = psfNW + psfNE + psfSW + psfSE;
    a = [a zeros(meta+1,nb-meta-1) ; zeros(mb-meta-1,nb)];
    e1 = zeros(mb,nb);
    e1(1,1)=1;
    autovaloriN = (dct2(a)./dct2(e1));

xx = autovaloriC./autovaloriN;
% prendo la norma elemento per elemento
x = sqrt(xx.*conj(xx));
end
