function x = invert(b, psf, type, reg)
% risolve il sistema Ax=b
% dove A è la matrice di sfocatura ottenuta tramite la psf
% type può essere 'periodic' o 'neumann' e indica le condizioni al contorno
% reg è il parametro di regolarizzazione

[m,n] = size(psf); %m è sempre uguale a n perché la psf è quadrata
meta = floor(m/2);
[mb,nb] = size(b);

%caso 1
if strcmp(type,'periodic')
    %genero la matrice a
    a = [ psf zeros(m,nb-n) ; zeros(mb-m,nb)];
    traslm = [meta+1:mb 1:meta];
    trasln = [meta+1:nb 1:meta];
    a = a(traslm,trasln);
    %calcolo la soluzione del sistema
    if reg==0
        x = ifft2( fft2(b) ./ fft2(a) );
    else
        aat = ifft2( fft2(a) .* fft2(a) );
        aat(1,1) = aat(1,1) + reg;
        x = ifft2( fft2(b) ./ fft2(aat) );
        x = ifft2( fft2(x) .* fft2(a) );
    end
end
%caso 2
if strcmp(type,'neumann')
    %isolo le componenti della psf
    psfNW = psf(1:meta, 1:meta);
    psfNE = psf(1:meta, meta+1:end);
    psfSW = psf(meta+1:end, 1:meta);
    psfSE = psf(meta+1:end, meta+1:end);
    %ruoto e rifletto in modo opportuno
    psfNW = rot90(psfNW,2);
    psfNE = flipud(psfNE);
    psfSW = fliplr(psfSW);
    %aggiusto le dimensioni
    psfNW(meta+1,meta+1) = 0;
    psfNE(meta+1,meta+1) = 0;
    psfSW(meta+1,meta+1) = 0;
    %genero la matrice a
    a = psfNW + psfNE + psfSW + psfSE;
    a = [a zeros(meta+1,nb-meta-1) ; zeros(mb-meta-1,nb)];
    %calcolo la soluzione del sistema
    e1 = zeros(mb,nb);
    e1(1,1)=1;
    dct2e1 = dct2(e1);
    if reg==0
        x = idct2( dct2(b) ./ (dct2(a)./dct2e1) );
    else
        aat = idct2( dct2(a) .* (dct2(a)./dct2e1) );
        aat(1,1) = aat(1,1) + reg;
        x = idct2( dct2(b) ./ (dct2(aat)./dct2e1) );
        x = idct2( dct2(x) .* (dct2(a)./dct2e1) );
    end
end
end