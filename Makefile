OCAML=ocaml
OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLDEP=ocamldep
INCLUDES=
OCAMLFLAGS=$(INCLUDES) -g
OCAMLOPTFLAGS=$(INCLUDES)

MAIN_OBJS= lexer.cmo parser.cmo types.cmo main.cmo

main: .depend $(MAIN_OBJS)
	$(OCAMLC) -o main $(OCAMLFLAGS) $(MAIN_OBJS)

lexer.ml: parser.cmo
	ocamllex lexer.mll
parser.ml:
	ocamlyacc parser.mly

.SUFFIXES: .ml .mli .cmo .cmi

.mll.ml:
	ocamllex $<
.mly.ml:
	ocamlyacc $<

.ml.cmo:
	$(OCAMLC) $(OCAMLFLAGS) -c $<

.mli.cmi:
	$(OCAMLC) $(OCAMLFLAGS) -c $<

.ml.cmx:
	$(OCAMLOPT) $(OCAMLOPTFLAGS) -c $<

lexer_test: .depend lexer.mll lexer.cmo
	@$(OCAML) lexer.cmo lexer_tester.ml < test_lexer_1.lisp > test1.tmp; \
	if diff test_lexer_1.out test1.tmp; \
	then echo "[+] Lexer Test 1 Success"; \
	else echo "[-] Lexer Test 1 Failed"; \
	fi

test_all: lexer_test parser_test 

parser_test: .depend parser.cmo lexer.cmo
	@$(OCAML) parser.cmo lexer.cmo types.cmo parser_tester.ml < test_parser_1.lisp > test2.tmp; \
	if diff test_parser_1.out test2.tmp; \
	then echo "[+] Parser Test 1 Success"; \
	else echo "[-] Parser Test 1 Failed"; \
	fi

parser_test2: .depend parser.cmo lexer.cmo
	$(OCAML) parser.cmo lexer.cmo types.cmo parser_tester.ml < test_parser_2.lisp > test3.tmp;\
	if diff test_parser_2.out test3.tmp; \
	then echo "[+] Parser Test 2 Success"; \
	else echo "[-] Parser Test 2 Failed"; \
	fi

clean:
	rm -f main
	rm -f *~
	rm -f lexer.ml parser.ml parser.mli
	rm -f test*.tmp
	rm -f .depend

.depend:
	$(OCAMLDEP) $(INCLUDES) *.mli *.ml *.mly *.mll > .depend

parser.cmo : parser.cmi
parser.mli : parser.mly
parser.ml : parser.mly

include .depend
