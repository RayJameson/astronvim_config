---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      ruff_lsp = {
        init_options = {
          settings = {
            --"--ignore=D,PT009,ANN002,ANN003,ANN101,ANN102,ANN401,A003,RUF001,RUF002,RUF003,RET504,PD008,TD001,TD002,TD003,S101",
            args = {
              "--select=B,E,F,I,ANN,ASYNC,S,COM,C,ISC,PIE,PT,Q,TID,ARG,PLE,PLR,PLW,RUF",
              "--ignore=ANN101,RUF100,PLR0913,ANN102,ANN401,PLR2004,S101",
              "--line-length=120",
              "fixable=A,B,C,D,E,F,G,I,N,Q,S,T,W,ANN,ARG,BLE,COM,DJ,DTZ,EM,ERA,EXE,FBT,ICN,INP,ISC,NPY,PD,PGH,PIE,PL,PT,PTH,PYI,RET,RSE,RUF,SIM,SLF,TCH,TID,TRY,UP,YTT",
            },
          },
        },
      },
    },
  },
}
