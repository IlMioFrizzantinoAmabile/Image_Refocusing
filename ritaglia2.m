function piccola = ritaglia2(grossa, pixel)
% ritaglia un'immagine memorizzata nella variabile 'grossa'
% prende solo la porzione [pixel+1 : end-pixel , pixel+1 : end-pixel]
   s = size(grossa);
   if length(s)==3
      [m,n,~] = size(grossa);
      p1 = grossa(pixel+1:m-pixel , pixel+1:n-pixel , 1);
      p2 = grossa(pixel+1:m-pixel , pixel+1:n-pixel , 2);
      p3 = grossa(pixel+1:m-pixel , pixel+1:n-pixel , 3);
      piccola = p1;
      piccola(:,:,2) = p2;
      piccola(:,:,3) = p3;
   else
       [m,n] = size(grossa);
      piccola = grossa(pixel+1:m-pixel , pixel+1:n-pixel);
   end
end