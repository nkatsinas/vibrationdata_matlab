

%   nastran_modal_transient.m  ver 1.0  by Tom Irvine

function[]=clear_all_figures(sss)

handles.output=sss;

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures;
  close( Figures( nFigures ) );
end
