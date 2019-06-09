function nlces = calc_multiple_nlces(obj, nlce_calculator, nlce_orders, ...
    outfilebase, verbose)
    % NLCES = CALC_MULTIPLE_NLCES(NLCE_CALCULATOR, NLCE_ORDERS,
    %   OUTFILEBASE, VERBOSE)
    %   Computes the NLCE for multiple orders and returns them in a matrix
    %   where each column corresponds to one order. nlce_calculator is the
    %   NlceCalculator instance used for calculation. nlce_orders is a
    %   vector of NLCE orders to compute. If outfilebase is given, the NLCE
    %   result is also written to files named by tagging the base name with
    %   the appropriate NLCE order. Verbose flag is for progress printing,
    %   and defaults to false (no progress printing).
    
    nlces = [];
    for nlce_order = nlce_orders
        if verbose
            fprintf('\n-------- Order %g --------\n', nlce_order);
        end
        nlces = [nlces, nlce_calculator.calc_nlce(nlce_order, ...
            obj.tag_filename(outfilebase, nlce_order), verbose)];
    end
end