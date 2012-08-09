OCAML=ocaml
OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLDEP=ocamldep
INCLUDES=
OCAMLFLAGS=$(INCLUDES) -g
OCAMLOPTFLAGS=$(INCLUDES)

LEXER_TESTCASES = 1 2
PARSER_TESTCASES = 1 2 3
EVAL_TESTCASES = 1 2 3 4 5 6 7

MAIN_OBJS= lexer.cmo parser.cmo types.cmo main.cmo

main: .depend $(MAIN_OBJS)
	$(OCAMLC) -o main $(OCAMLFLAGS) $(MAIN_OBJS)

lexer.ml: parser.cmo
	ocamllex lexer.mll
parser.ml: types.cmo
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

test_all: lexer_test parser_test 

lexer_test: .depend lexer.mll lexer.cmo
	@mkdir tmp 2> /dev/null; \
	for i in $(LEXER_TESTCASES); do \
	$(OCAML) lexer.cmo lexer_tester.ml < test_cases/lexer/lexer-"$$i".lisp > tmp/lexer_test_"$$i".out; \
	if diff test_cases/lexer/lexer-"$$i".txt tmp/lexer_test_"$$i".out; \
	then echo "[+] Lexer Test $$i Success"; \
	else echo "[-] Lexer Test $$i Failed"; \
	fi; \
	done

parser_test: .depend parser.cmo lexer.cmo
	@mkdir tmp 2> /dev/null; \
	for i in $(PARSER_TESTCASES); do \
	$(OCAML) parser.cmo lexer.cmo types.cmo parser_tester.ml \
	< test_cases/parser/parser-"$$i".lisp > tmp/parser_test_"$$i"; \
	if diff test_cases/parser/parser-"$$i".json tmp/parser_test_"$$i"; \
	then echo "[+] Parser Test $$i Success"; \
	else echo "[-] Parser Test $$i Failed"; \
	fi; \
	done

eval_test: main
	@mkdir tmp 2> /dev/null; \
	for i in $(EVAL_TESTCASES); do \
	./main < test_cases/eval/eval-"$$i".lisp > tmp/eval_test_"$$i"; \
	if diff test_cases/eval/eval-"$$i".txt tmp/eval_test_"$$i"; \
	then echo "[+] Eval Test $$i Success"; \
	else echo "[-] Eval Test $$i Failed"; \
	fi; \
	done

clean:
	rm -f main
	rm -f *~
	rm -f lexer.ml parser.ml parser.mli
	rm -f *.cm[iox]
	rm -f test*.tmp
	rm -f .depend
	rm -rf tmp

.depend:
	$(OCAMLDEP) $(INCLUDES) *.mli *.ml *.mly *.mll > .depend

parser.cmo : parser.cmi
parser.mli : parser.mly
parser.ml : parser.mly

include .depend
