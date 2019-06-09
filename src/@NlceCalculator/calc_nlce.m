function nlce = calc_nlce(obj, nlce_order, outfilename, verbose)
    % NLCE = CALC_NLCE(NLCE_ORDER, OUTFILENAME, VERBOSE)
    %   Computes the NLCE of a specified order and returns it. If
    %   outfilename is given, the NLCE result is also written to that file.
    %   Verbose flag is for progress printing, and defaults to false (no
    %   progress printing).
    
    if nargin < 3
        outfilename = '';
    end
    if nargin < 4
        verbose = false;
    end
    
    coeffs = obj.enumerator.get_nlce_coeffs(nlce_order);
    nlce = 0;
    for i = 1:size(coeffs, 1)
        if verbose
            fprintf('(%i/%i) Calculating %ix%i.\n', ...
                i, size(coeffs, 1), coeffs(i, 1), coeffs(i, 2));
        end
        nlce = nlce + ...
            coeffs(i, 3)*obj.property_calculator.calculate(coeffs(i, 1:2));
    end
    
    if ~isempty(outfilename)
        obj.writer.write(nlce, outfilename);
    end
end