function a = rifoca(b, psf, type, reg)
% rimette a fuoco un'immagine memorizzata nella variabile b
% usando la PSF memorizzata nella variabile psf
% in uscita l'immagine rimessa a fuoco a
% type può essere 'periodic' o 'neumann' e indica le condizioni al contorno
% reg è il parametro di regolarizzazione
  b = double(b);
  s=size(b);
  if length(s)==3
     x1 = invert(b(:,:,1), psf, type, reg);
     x2 = invert(b(:,:,2), psf, type, reg);
     x3 = invert(b(:,:,3), psf, type, reg);
     a = x1;
     a(:,:,2) = x2;
     a(:,:,3) = x3;
  else
     a = invert(b, psf, type, reg);
  end
end

