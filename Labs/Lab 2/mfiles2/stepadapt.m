function [nndata] = stepadapt(nndata)

if nndata.train.epoch > 1 & (nndata.train.cost(end) > nndata.train.costmin * nndata.train.costtolerance)  &  nndata.train.costcontrol

    %   The cost has increased nore than the allowed tolerance. Backtrack

    for i = 1:length(nndata.layer) %for each layer
        layer=nndata.layer{i};

        layer.weight = layer.weightmin;
        layer.gradient = layer.gradientmin;
        layer.etamin = layer.etamin * nndata.train.etareduce;
        layer.eta = layer.etamin;
        layer.z = zeros(size(layer.z));

        nndata.layer{i}=layer; %save layer back to structure
    end
    nndata.train.falseepochs = nndata.train.falseepochs + 1;

else      % The cost has decreased, or has not increased to much. Adapt step sizes

    if nndata.train.adaptivesteps

        %   Adapt step sizes

        for i = 1:length(nndata.layer)
            layer=nndata.layer{i};

            upflag = (layer.gradient .* layer.gradientold) >= 0;
            layer.eta = layer.eta .* (nndata.train.etaup * upflag + nndata.train.etadown * (1 - upflag));

            nndata.layer{i}=layer; %save layer back to structure
        end

    end

end




