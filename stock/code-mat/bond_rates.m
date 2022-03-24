cca
n_yrs=30;

b_int=0.16;

b_iv=1000;

b_fv=b_iv+n_yrs*b_int*b_iv;

c_int=exp(1/n_yrs*log(b_fv/b_iv))-1