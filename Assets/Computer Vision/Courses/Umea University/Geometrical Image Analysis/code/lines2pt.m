function x=lines2pt(l1,l2)
%LINES2PT Find homogenous intersection of two homogenous lines.
%
%x=lines2pt(l1,l2)
%l1,l2 - lines in homogenous coordinates.
%x     - intersection in homogenous coordinates.

% v1.0  2002-03-19. Niclas Borlin, niclas@cs.umu.se.

x=null([l1,l2]');
