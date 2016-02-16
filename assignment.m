% AC50002 PROGRAMMING LANGUAGES FOR DATA ENGINEERING
%
% MATLAB ASSIGNMENT
% 
% Lecturer:	Emanuele (Manuel) Trucco
% Lab tutors:	Roberto Annunziata, Andrew McNeil
% 
% Group: Jean Vall�e, Graeme Brown, John Luke Barker.
%
% NB *requires the function library add_noise.m to be in the current path*
%
% tidy up workspace figures
clear vars, close all
sep = {' '}; % use in figure strings. 
hist_axes = [-6 6 0 60]; % be consistent in histogram display

% Problem description
% 1.	
% Generate our original distribution: 200 real numbers from a Gaussian
% distribution, with mean 0 and standard deviation 1. 
sample_size = 200;
original_dist = randn(sample_size, 1);

% Generate a histogram of the sample, choosing the number of bins with the
% Freedman-Diaconis rule.
figure('Menubar', 'none')
histogram(original_dist, 'BinMethod', 'fd') 

% plot original dist:
title('Histogram of original distribution, with Freedman Diaconis applied');
xlabel('Value');
ylabel('Frequency');
axis(hist_axes);

figure('position',[100, 100, 1024, 700], ...
    'Name', 'Trials of Adding Noise to a Gaussian', ...
    'Menubar', 'none')

subplot(3, 4, 1);
histogram(original_dist, 'BinMethod', 'fd') 
axis(hist_axes);

title( 'Original Distribution') 
std_dev = std(original_dist); % show sigma. 
xlabel(strcat('\sigma =', sep, num2str(std_dev)));
ylabel('Frequency');

% 2.
% Run a Chi-square test for Gaussianity to test the hypothesis that the
% numbers are a sample from a Gaussian distribution. 
% Report the result in terms of answer (yes or no) and significance level.
fprintf('\nORIGINAL Distribution:\n')
check_gaussianity(original_dist);

% 
% Run our experiment 10 times:
% i.e.: 5. Repeat steps 3 and 4 for 10 times, each time removing 10 
% numbers in random positions from the original Gaussian sample, 
% and replacing them with a new set of uniform deviates.
%
number_experiments = 10;
number_replacements = 10;
responses = [];
significance_levels = [0.01 0.05 0.1];

for i = 1:number_experiments
    
    % 3. replace some values with uniform originated noise:
    modified_dist = add_noise(original_dist, number_replacements);
    
    % 4. Repeat step 2. ~(run chisquare test for gaussianity)
    fprintf('\nTRIAL#%d Distribution: \n', i)
    
    to_append = check_gaussianity(modified_dist, significance_levels);
    
    % append each run of significance level tests to our 
    % table of responses
    responses = [responses to_append];
    
    % plot this trial's histogram:
    subplot(3, 4, i+1)
    histogram(modified_dist, 'BinMethod', 'fd') 
    
    title(strcat('Trial #', num2str(i)))
    std_dev = std(modified_dist);
    xlabel(strcat('\sigma =', sep, num2str(std_dev)))
    axis(hist_axes)
   

end;


% adjust text sizes in all plots
set(gca,'FontSize',11,'fontWeight','bold')
set(findall(gcf,'type','text'),'FontSize',11,'fontWeight','bold')

% provide some extra text for clarity:
ax = subplot(3, 4, 12);
text(0.0,0.0,'\sigma = standard deviation');
set (ax, 'visible', 'off')


%
% Show how often the different significance levels in all the trials 
% fail to reject the null hypothesis:
%

% build up counts for each significance level; initialise a value first 
counts = zeros(size(significance_levels));

for r = 1:length(responses)
    
    for index = 1:length(significance_levels)
        if responses(r) == significance_levels(index)
            counts(index) = counts(index) + 1;
        end
    end
end
 
% plot our counts by significance level on a bar graph:
figure;

% bar charts won't work with real numbered vector so, convert to integer
x = 1:length(significance_levels);
b = bar(x, counts);

% present data more clearly:
title('Number Of Times The Trials Failed To Reject H_{0}');
ylim([0 10]);
ylabel('No. Of Times')
xlabel('Significance Level');

% set the x-label to the signif levels with nice decimal places
labels = num2str(significance_levels.','%.2f');
set(gca, 'Xtick', 1:3, 'XTickLabel', labels, 'box','off');