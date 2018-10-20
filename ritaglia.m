function piccola = ritaglia(grossa, m1, m2, n1, n2)
% ritaglia un'immagine memorizzata nella variabile 'grossa'
% prende solo la porzione [m1:m2 , n1:n2]
   s = size(grossa);
   if length(s)==3
      p1 = grossa(m1:m2 , n1:n2 , 1);
      p2 = grossa(m1:m2 , n1:n2 , 2);
      p3 = grossa(m1:m2 , n1:n2 , 3);
      piccola = p1;
      piccola(:,:,2) = p2;
      piccola(:,:,3) = p3;
   else
      piccola = grossa(m1:m2 , n1:n2);
   end
end