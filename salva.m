function salva(immagine, tipo_sfocatura, condizioni_bordo, reg, errore)
% salva l'immagine come .jpg
  immagine = uint8(immagine);
  nome = strcat('cactus/err=',num2str(errore),' - reg=', num2str(reg),' - sfoc=',tipo_sfocatura,' - type=',condizioni_bordo);
  imwrite(immagine, strcat(nome,'.jpg'));
end

