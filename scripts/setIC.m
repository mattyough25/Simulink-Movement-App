function [nIC_sim] = setIC(nIC_search,nIC)

%% Setting the initial conditions of the model
nIC_sim = nIC;
if ~isempty(nIC_search.el_e_f)
    nIC_sim(29) = nIC_search.el_e_f;
end

if ~isempty(nIC_search.wr_s_p)
    nIC_sim(8) = nIC_search.wr_s_p;
end

if ~isempty(nIC_search.wr_ab_ad)
    nIC_sim(30) = nIC_search.wr_ab_ad;
end

if ~isempty(nIC_search.wr_e_f)
    nIC_sim(9) = nIC_search.wr_e_f;
end

if ~isempty(nIC_search.cmc1_ad_ab)
    nIC_sim(10) = nIC_search.cmc1_ad_ab;
end

if ~isempty(nIC_search.cmc1_f_e)
    nIC_sim(11) = nIC_search.cmc1_f_e;
end

if ~isempty(nIC_search.mcp1_f_e)
    nIC_sim(12) = nIC_search.mcp1_f_e;
end

if ~isempty(nIC_search.ip1_f_e)
    nIC_sim(13) = nIC_search.ip1_f_e;
end

if ~isempty(nIC_search.mcp2_e_f)
    nIC_sim(14) = nIC_search.mcp2_e_f;
end

if ~isempty(nIC_search.pip2_e_f)
    nIC_sim(15) = nIC_search.pip2_e_f;
end

if ~isempty(nIC_search.dip2_e_f)
    nIC_sim(16) = nIC_search.dip2_e_f;
end

if ~isempty(nIC_search.mcp3_e_f)
    nIC_sim(17) = nIC_search.mcp3_e_f;
end

if ~isempty(nIC_search.pip3_e_f)
    nIC_sim(18) = nIC_search.pip3_e_f;
end

if ~isempty(nIC_search.dip3_e_f)
    nIC_sim(19) = nIC_search.dip3_e_f;
end

if ~isempty(nIC_search.mcp4_e_f)
    nIC_sim(20) = nIC_search.mcp4_e_f;
end

if ~isempty(nIC_search.pip4_e_f)
    nIC_sim(21) = nIC_search.pip4_e_f;
end

if ~isempty(nIC_search.dip4_e_f)
    nIC_sim(22) = nIC_search.dip4_e_f;
end

if ~isempty(nIC_search.mcp5_e_f)
    nIC_sim(23) = nIC_search.mcp5_e_f;
end

if ~isempty(nIC_search.pip5_e_f)
    nIC_sim(24) = nIC_search.pip5_e_f;
end

if ~isempty(nIC_search.dip5_e_f)
    nIC_sim(25) = nIC_search.dip5_e_f;
end
