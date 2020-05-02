inc = include_directories('include')

flex = find_program('flex', required: true)
bison = find_program('bison', required: true)

lgen = generator(flex,
output : '@PLAINNAME@.yy.c',
arguments : ['-o', '@OUTPUT@', '@INPUT@'])

lfiles = lgen.process('grammar/h8_lexer.l')

pgen = generator(bison,
output : ['@BASENAME@.tab.c', '@BASENAME@.tab.h'],
arguments : ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@'])

pfiles = pgen.process('grammar/h8_parser.y')

executable('h8c', 
           'src/h8_main.c', 
           'src/h8_ast.c', 
           lfiles,
           pfiles,
           include_directories : inc)