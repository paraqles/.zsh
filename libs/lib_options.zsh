
for opt in $OPT_SET; do setopt ${(U)opt}; done

for opt in $OPT_USET; do unsetopt ${(U)opt}; done
