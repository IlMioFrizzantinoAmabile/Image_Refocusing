function errore = rel_error(originale,rifocata)
% calcola l'errore relativo come ||originale - differenza|| / ||originale||
% nel caso di una foto a colori fa la media dei 3 errori relativi
   originale = double(originale);
   rifocata = double(rifocata);
   %originale = ritaglia2(originale,50);    %per escludere la cornice dal
   %rifocata = ritaglia2(rifocata,50);      %controllo dell'errore
   s = size(originale);
   if length(s)==3
      errore = norm(originale(:,:,1)-rifocata(:,:,1))/norm(originale(:,:,1));
      errore = errore + norm(originale(:,:,2)-rifocata(:,:,2))/norm(originale(:,:,2));
      errore = errore + norm(originale(:,:,3)-rifocata(:,:,3))/norm(originale(:,:,3));
      errore = errore/3;
   else
      errore = norm(originale-rifocata)/norm(originale);
   end
end

