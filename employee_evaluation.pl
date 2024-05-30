% Facts defining employee performance criteria
% performance(Employee, Criteria, Rating)

performance(john, attendance, excellent).
performance(john, teamwork, good).
performance(john, productivity, excellent).
performance(john, communication, good).
performance(mary, attendance, good).
performance(mary, teamwork, excellent).
performance(mary, productivity, good).
performance(mary, communication, excellent).
performance(mary, leadership, good).
performance(mary, initiative, excellent).
performance(steve, attendance, satisfactory).
performance(steve, teamwork, satisfactory).
performance(steve, productivity, satisfactory).
performance(steve, communication, satisfactory).
performance(steve, leadership, satisfactory).
performance(steve, initiative, satisfactory).

% Rules for evaluating overall performance

% Employee has excellent overall performance if all criteria are excellent
overall_performance(Employee, excellent) :-
    performance(Employee, attendance, excellent),
    performance(Employee, teamwork, excellent),
    performance(Employee, productivity, excellent),
    performance(Employee, communication, excellent),
    \+ (performance(Employee, Criteria, Rating), Criteria \= attendance, Criteria \= teamwork, Criteria \= productivity, Criteria \= communication, Rating \= excellent),
    performance(Employee, leadership, excellent),
    performance(Employee, initiative, excellent).

% Employee has good overall performance if most criteria are good/excellent
overall_performance(Employee, good) :-
    good_count(Employee, Count),
    Count >= 3. % At least 3 criteria are good or excellent

good_count(Employee, Count) :-
    findall(Criteria, performance(Employee, Criteria, good), GoodCriteria),
    findall(Criteria, performance(Employee, Criteria, excellent), ExcellentCriteria),
    append(GoodCriteria, ExcellentCriteria, AllGoodCriteria),
    length(AllGoodCriteria, Count).

% Employee has satisfactory overall performance if any criteria are satisfactory
overall_performance(Employee, satisfactory) :-
    performance(Employee, _, satisfactory).

% Rules for providing feedback

evaluate_performance(Employee, Feedback) :-
    overall_performance(Employee, excellent),
    Feedback = 'Excellent performance in all areas. Keep up the great work!'.

evaluate_performance(Employee, Feedback) :-
    overall_performance(Employee, good),
    Feedback = 'Good performance overall. Focus on improving in specific areas for even better results.'.

evaluate_performance(Employee, Feedback) :-
    overall_performance(Employee, satisfactory),
    Feedback = 'Satisfactory performance. Consider areas for improvement to enhance overall performance.'.

evaluate_performance(_, 'Performance evaluation not available for this employee.').

