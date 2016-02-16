function trial = check_gaussianity(distribution, significance_level)
   
    % default parameters:
    if ~exist('significance_levels','var')
        significance_level = [0.01 0.05 0.1];   
    end
        
    % output results in columns to console:
    fprintf('Significance Level \t| ')
    fprintf('test rejects H0 that data follows Gaussian distribution \n')
    
    % store results
    trial = [];
    
    % run test on this distrbution for each required significance level: 
    for alpha = significance_level
        
        response = chi2gof(distribution, 'Alpha', alpha);
        if response(1) == 0
            response_txt='No. Failed to reject H0';
             trial = [trial alpha];
            
        else
            response_txt='Yes. Rejects H0';
        end
        fprintf ('\t\t%.2f \t\t\t%s \n', alpha, response_txt)
       
       
    end
    
end