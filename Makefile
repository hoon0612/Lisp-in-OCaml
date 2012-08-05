OCAML=ocaml
OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLDEP=ocamldep
INCLUDES=
OCAMLFLAGS=$(INCLUDES) -g
OCAMLOPTFLAGS=$(INCLUDES)

MAIN_OBJS= lexer.cmo

main: .depend $(MAIN_OBJS)
	$(OCAMLC) -o main $(OCAMLFLAGS) $(MAIN_OBJS)

lexer.ml:
	ocamllex lexer.mll

%.cmo: %.ml
	$(OCAMLC) $(OCAMLFLAGS) -c $<

lexer_test: lexer.ml
	@$(OCAML) lexer_tester.ml < test_lexer_1.lisp > test.tmp; \
	if diff test_lexer_1.out test.tmp; \
	then echo "[+] Lexer Test 1 Success"; \
	else echo "[-] Lexer Test 1 Failed"; \
	fi

clean:
	rm -f main
	rm -f *~
	rm -f lexer.ml
	rm -f test*.tmp

.depend:
	$(OCAMLDEP) $(INCLUDES) *.mli *.ml *.mly *.mll > .depend

include .depend
