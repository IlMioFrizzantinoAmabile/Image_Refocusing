type = 'neumann';
reg = 0.0001;

psf_e = psf_exp(8,0.1);
figure; surf(psf_e); title('PSF esponenziale: alpha=0.1, supporto=17x17');
psf_o = psf_oof(8,4);
figure; surf(psf_o); title('PSF out of focus: raggio=4, supporto=17x17');

tic
coord1 = 1650;
coord2 = 3150;
dim = 256;
foto = imread('cactus/cactus.jpg');
foto_exp = sfoca(foto,psf_e);
foto_oof = sfoca(foto,psf_o);
foto = ritaglia2(foto,8); %così foto ha le stesse dimensioni delle sfocate
toc

porzione = ritaglia(foto,coord1,coord1+dim-1,coord2,coord2+dim-1);
imwrite(uint8(porzione),'cactus/porzione.jpg');
porzione_exp = ritaglia(foto_exp,coord1,coord1+dim-1,coord2,coord2+dim-1);
imwrite(uint8(porzione_exp),'cactus/porzione_exp.jpg');
porzione_oof = ritaglia(foto_oof,coord1,coord1+dim-1,coord2,coord2+dim-1);
imwrite(uint8(porzione_oof),'cactus/porzione_oof.jpg');


tic
rifocata = rifoca(porzione_exp,psf_e,type,reg);
salva(rifocata, 'exp', type, reg, rel_error(porzione,rifocata));
rifocata = rifoca(porzione_oof,psf_o,type,reg);
salva(rifocata, 'oof', type, reg, rel_error(porzione,rifocata));
toc

tic
[m,n] = size(porzione(:,:,1));
rapporto_autovalori_exp = fun(m,n,psf_e);
figure; mesh(rapporto_autovalori_exp);
set(gca, 'ZScale', 'log'); title('AutovaloriC/AutovaloriN - PSF esponenziale');
rapporto_autovalori_oof = fun(m,n,psf_o);
figure; mesh(rapporto_autovalori_oof);
set(gca, 'ZScale', 'log'); title('AutovaloriC/AutovaloriN - PSF out of focus');
toc