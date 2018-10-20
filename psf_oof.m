function psf = psf_oof(k, radius)
% crea una psf di tipo ou-of-focus di dimensioni (2k+1)x(2k+1) con elementi:
% c se i^2+j^2 <= radius^2, 0 altrimenti
% c è scelta in modo tale che la somma sia 1
  x = [-k:k]'*ones(1,2*k+1);
  check = x.^2 + x'.^2;
  psf = zeros(2*k+1,2*k+1);
  for i=1:2*k+1
      for j=1:2*k+1
          if check(i,j) <= radius^2
              psf(i,j) = 1;
          end
      end
  end
  
  %pongo la somma = 1
  psf = psf/(sum(sum(psf)));
end

