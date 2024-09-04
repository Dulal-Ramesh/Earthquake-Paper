tabulate pubcashid, generate(pubcashid_)
foreach val of varlist pubcashid_* {
    gen `val' = (pubcashid == real(substr("`val'", 10, .))) 
}
