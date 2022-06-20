% Function calculates velocity
% & acceleration from position by ftting a cubic spline
% Inputs: position (m), sampling frequency(Hz)

function splkin = splineKin(kin, posFs)

[nrow,ncol] = size(kin);
for icol = 1:ncol
   postime  = (1/posFs:1/posFs:nrow/posFs)'; % time
   pp1      = spline(postime,kin(:,icol));   % fit cubic spline to trajectory
   % differentiate polynomial coefficients
   coefs    = [pp1.coefs(:,1)*3,pp1.coefs(:,2)*2,pp1.coefs(:,3)]; % coefficient power decreases
   pp2      = mkpp(pp1.breaks,coefs); % create differentiated polinomial for vel
   coefs    = [pp2.coefs(:,1)*2,pp2.coefs(:,2)]; % differentate again
   pp3      = mkpp(pp2.breaks,coefs); % create differentiated polinomial for acc
   
   splkin(:,1,icol) = ppval(pp1,postime); % position
   splkin(:,2,icol) = ppval(pp2,postime); % velocity
   nData = ppval(pp3,postime);
   splkin(:,3,icol) = nData - nData(1); % acceleration starts from 0
end
