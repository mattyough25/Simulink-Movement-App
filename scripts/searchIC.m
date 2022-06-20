function [nIC_search] = searchIC(metaTrial)

%% Search for the DOF of the Model
sDOF_el = strfind(metaTrial.sDOF,'ra_el_e_f');
nRow_el = find(~cellfun(@isempty, sDOF_el));

sDOF_wr_s_p = strfind(metaTrial.sDOF,'ra_wr_s_p');
nRow_wr_s_p = find(~cellfun(@isempty, sDOF_wr_s_p));

sDOF_wr_ad_ab = strfind(metaTrial.sDOF,'ra_wr_ad_ab');
nRow_wr_ad_ab = find(~cellfun(@isempty, sDOF_wr_ad_ab));

sDOF_wr_e_f = strfind(metaTrial.sDOF,'ra_wr_e_f');
nRow_wr_e_f = find(~cellfun(@isempty, sDOF_wr_e_f));

sDOF_cmc1_ad_ab = strfind(metaTrial.sDOF,'ra_cmc1_ad_ab');
nRow_cmc1_ad_ab = find(~cellfun(@isempty, sDOF_cmc1_ad_ab));

sDOF_cmc1_f_e = strfind(metaTrial.sDOF,'ra_cmc1_f_e');
nRow_cmc1_f_e = find(~cellfun(@isempty, sDOF_cmc1_f_e));

sDOF_mcp1_f_e = strfind(metaTrial.sDOF,'ra_mcp1_f_e');
nRow_mcp1_f_e = find(~cellfun(@isempty, sDOF_mcp1_f_e));

sDOF_ip1_f_e = strfind(metaTrial.sDOF,'ra_ip1_f_e');
nRow_ip1_f_e = find(~cellfun(@isempty, sDOF_ip1_f_e));

sDOF_mcp2_e_f = strfind(metaTrial.sDOF,'ra_mcp2_e_f');
nRow_mcp2_e_f = find(~cellfun(@isempty, sDOF_mcp2_e_f));

sDOF_pip2_e_f = strfind(metaTrial.sDOF,'ra_pip2_e_f');
nRow_pip2_e_f = find(~cellfun(@isempty, sDOF_pip2_e_f));

sDOF_dip2_e_f = strfind(metaTrial.sDOF,'ra_dip2_e_f');
nRow_dip2_e_f = find(~cellfun(@isempty, sDOF_dip2_e_f));

sDOF_mcp3_e_f = strfind(metaTrial.sDOF,'ra_mcp3_e_f');
nRow_mcp3_e_f = find(~cellfun(@isempty, sDOF_mcp3_e_f));

sDOF_pip3_e_f = strfind(metaTrial.sDOF,'ra_pip3_e_f');
nRow_pip3_e_f = find(~cellfun(@isempty, sDOF_pip3_e_f));

sDOF_dip3_e_f = strfind(metaTrial.sDOF,'ra_dip3_e_f');
nRow_dip3_e_f = find(~cellfun(@isempty, sDOF_dip3_e_f));

sDOF_mcp4_e_f = strfind(metaTrial.sDOF,'ra_mcp4_e_f');
nRow_mcp4_e_f = find(~cellfun(@isempty, sDOF_mcp4_e_f));

sDOF_pip4_e_f = strfind(metaTrial.sDOF,'ra_pip4_e_f');
nRow_pip4_e_f = find(~cellfun(@isempty, sDOF_pip4_e_f));

sDOF_dip4_e_f = strfind(metaTrial.sDOF,'ra_dip4_e_f');
nRow_dip4_e_f = find(~cellfun(@isempty, sDOF_dip4_e_f));

sDOF_mcp5_e_f = strfind(metaTrial.sDOF,'ra_mcp5_e_f');
nRow_mcp5_e_f = find(~cellfun(@isempty, sDOF_mcp5_e_f));

sDOF_pip5_e_f = strfind(metaTrial.sDOF,'ra_pip5_e_f');
nRow_pip5_e_f = find(~cellfun(@isempty, sDOF_pip5_e_f));

sDOF_dip5_e_f = strfind(metaTrial.sDOF,'ra_dip5_e_f');
nRow_dip5_e_f = find(~cellfun(@isempty, sDOF_dip5_e_f));

%% Define initial conditions
nIC_search.el_e_f            = metaTrial.nIC(nRow_el); 
nIC_search.wr_ab_ad          = metaTrial.nIC(nRow_wr_ad_ab); 
nIC_search.wr_s_p            = metaTrial.nIC(nRow_wr_s_p); 
nIC_search.wr_e_f            = metaTrial.nIC(nRow_wr_e_f);
nIC_search.cmc1_ad_ab        = metaTrial.nIC(nRow_cmc1_ad_ab); 
nIC_search.cmc1_f_e          = metaTrial.nIC(nRow_cmc1_f_e); 
nIC_search.mcp1_f_e          = metaTrial.nIC(nRow_mcp1_f_e);
nIC_search.ip1_f_e           = metaTrial.nIC(nRow_ip1_f_e);
nIC_search.mcp2_e_f          = metaTrial.nIC(nRow_mcp2_e_f);
nIC_search.pip2_e_f          = metaTrial.nIC(nRow_pip2_e_f);
nIC_search.dip2_e_f          = metaTrial.nIC(nRow_dip2_e_f);
nIC_search.mcp3_e_f          = metaTrial.nIC(nRow_mcp3_e_f);
nIC_search.pip3_e_f          = metaTrial.nIC(nRow_pip3_e_f);
nIC_search.dip3_e_f          = metaTrial.nIC(nRow_dip3_e_f);
nIC_search.mcp4_e_f          = metaTrial.nIC(nRow_mcp4_e_f);
nIC_search.pip4_e_f          = metaTrial.nIC(nRow_pip4_e_f);
nIC_search.dip4_e_f          = metaTrial.nIC(nRow_dip4_e_f);
nIC_search.mcp5_e_f          = metaTrial.nIC(nRow_mcp5_e_f);
nIC_search.pip5_e_f          = metaTrial.nIC(nRow_pip5_e_f);
nIC_search.dip5_e_f          = metaTrial.nIC(nRow_dip5_e_f);
   