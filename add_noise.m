% Eliminate some numbers, chosen at random, from a distribution, 
% and replace them with numbers drawn from a uniform distribution
% of mean 0 and a given standard deviation.
function distribution = add_noise(distribution, number_replacements, ... 
    noise_std_dev)

    % default parameters:
    if ~exist('number_replacements','var')
        number_replacements = 10;
    end

    if ~exist('noise_std_dev','var')
        noise_std_dev = 3;
    end
 
    
    % Method to obtain standard deviation, sd, for a uniform distribution: 
    % with mean 0 with range [a:b], where a = -b, using formula:
    % sd = ( b - a ) / sqrt(12)
    % Simplifying, gives us:
    % sd = b / sqrt(3) =>
    % b = sd * sqrt(3) 
 
    b = noise_std_dev * sqrt(3);
    
    % MATLAB gives us random numbers between 0 and 1, so adjusting to 
    % satisfy centre on mean 0 and with std 3 :
    noise_vector = rand(number_replacements, 1) * (2 * b) - b;
   
    % get unique integers (without replacement)
    random_indices = randperm(length(distribution), number_replacements);
    
    % replace a set of the original distribution's values with noise:
    for i = 1:number_replacements
        distribution(random_indices(i)) = noise_vector(i);
    end
    
    
  
end
  


