function [ fmax ] = scale_muscle_fmax( fmax, muscles, scalingfactor )
    for i=muscles
        fmax(i) = fmax(i)*scalingfactor
    end
end

