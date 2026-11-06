function [y] = FskGen(bits, fs, fa, f0, f1, modu)
    
    %% Default Parameter
    y = 0;

    %% Check Required Parameter
    if (~isnumeric(bits) || (min(bits) < 0) || (max(bits) > 1))
        disp("bits must be array of bit (0 or 1)");
        return
    end

    if (~isnumeric(fs) || fs < 0)
        disp("fs must be positiv numeric");
        return
    end

    if (~isnumeric(fa) || fa < 0)
        disp("fa must be positiv numeric");
        return
    end
    if (~isnumeric(f0))
        disp("f0 must be numeric");
        return
    end
    if (~isnumeric(f1))
        disp("f1 must be numeric");
        return
    end
    
    if (~ismember(modu,{'real', 'comp'}))
        disp("mod must be one of: 'real', 'comp'");
        return
    end

    Ta = 1 / fa;
    Ts = 1 / fs;
    Nbits = length(bits);

    ts = 0 : Ta : Ts - Ta;
    if (modu == 'real')
        sym_0 = cos(2 * pi * f0 * ts);
        sym_1 = cos(2 * pi * f1 * ts);
    else
        sym_0 = exp(2j * pi * f0 * ts);
        sym_1 = exp(2j * pi * f1 * ts);
    end
   

    %% Anlegen des Zeitsignals
    y = [];
    for i = 1 : Nbits
        if bits(i) == 0
            y = [y, sym_0];
        else
            y = [y, sym_1];
        end
    end
end

