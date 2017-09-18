% Question 4
% Genetic Algorithm

[best_fitness, elite, generation] = my_ga(4, 'fitness_function', 100, 6, 0.1, 10000, 3.78);
disp(best_fitness(1, :));
disp(elite(1, :));
disp(generation(1, :));
