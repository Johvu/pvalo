# pvalo
Pysäytysvalo skripti

Lataus
1. Lataa tiedosto
2. Laita se palvelimen resources kansioon
3. configuroi tiedosto
4. starttaa tiedosto

Yleisiä ongelmia

1. Extra configissa on väärä jolloin valo ei toimi
2. Autosi modelissa ei ole valoa joten valo ei toimi
3. Sulla on enableESX truella servulla jossa sinulla ei ole esx:ää

jos tulee ongelmia nii yhteyttä Johvu#0761

Default Config

    local interval = 100 -- Valon vilkkumis nopeus
    local extra = 9 -- extran numero
    local button = 157 -- https://docs.fivem.net/docs/game-references/controls/
    local enableESX = true -- enables job check
