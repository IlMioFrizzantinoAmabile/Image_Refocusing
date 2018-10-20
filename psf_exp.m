function psf = psf_exp(k, alfa)
% crea una psf di tipo esponenziale di dimensioni (2k+1)x(2k+1)
% con elementi c*exp(-alfa(i^2+j^2)) per i,j=-k:k
% c è scelta in modo che la somma sia 1
  x = [-k:k]'*ones(1,2*k+1);
  y = x';
  psf = exp(-alfa*(x.^2+y.^2));
  
  % metto a 0 le componenti fuori dal rombo centrale
  % l'utilità di questa operazione è discutibile
  NW = rot90(tril(ones(k),-1),1);
  NE = tril(ones(k));
  SE = rot90(triu(ones(k+1)),1);
  SW = triu(ones(k));
  NE(1,k+1) = 0;
  SW(k+1,1) = 0;
  psf = psf.*[NW NE;SW SE];
 
  % pongo la somma = 1
  psf = psf/(sum(sum(psf)));
end