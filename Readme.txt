Function cca, ccac and wpca are used for blind source separation based on canonical correlation analysis.
ccac is the main function and can handle the ill-conditioned matrix (e.g. matrix was reducted with ICA components thus row rank is not or closed to non-full rank).
wpca helps ccac to handle the condition mentioned.
cca only focused on canonical correlation analysis.
After source separation , user can identify the noisy components by their time series, spectrum and topography.
To abandon noisy source, set the corresponding columns in mixing matrix A to zero, and multiply it to source matrix S.
You can also use eeglab's gui to do the identifying and abandon process.

Aeolus Quinlan, wentaozeng@stu.xjtu.edu.cn