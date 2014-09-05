
for opt in $OPT_SET; do
  if [[ ${(U)opt} =~ "UNICODE" ]]; then
    ZSH_ENCODING="utf-8"
  else
    setopt ${(U)opt}
  fi
done

for opt in $OPT_USET; do unsetopt ${(U)opt}; done

