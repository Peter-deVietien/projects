cca
fname = '/Users/peter/Downloads/companyfacts/CIK0000087347.json'; 
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
val = jsondecode(str);