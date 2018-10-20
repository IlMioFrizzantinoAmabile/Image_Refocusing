function b = sfoca(a, psf)
% sfoca un'immagine memorizzata nella variabile a
% usando la PSF memorizzata nella variabile psf
% in uscita l'immagine sfocata b
   a = double(a);
   s = size(a);
   if length(s)==3
      b1 = conv2(a(:,:,1),psf,'valid');
      b2 = conv2(a(:,:,2),psf,'valid');
      b3 = conv2(a(:,:,3),psf,'valid');
      b = b1;
      b(:,:,2) = b2;
      b(:,:,3) = b3;
   else
      b = conv2(a,psf,'valid');
   end
end

