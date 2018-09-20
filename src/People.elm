module People exposing (Person, people, personToStringFormatted)

import Common
import Table


personToString : Person -> String
personToString p =
    [ p.name
    , p.phone
    , p.company
    , p.address
    , p.city
    ]
        |> List.foldr (\t y -> t ++ "||" ++ y) ""


personToStringFormatted : Person -> String
personToStringFormatted person =
    person
        |> personToString
        |> Common.formatString


type alias Person =
    { name : String
    , phone : String
    , company : String
    , address : String
    , city : String
    , zip : String
    , country : String
    }


people : List Person
people =
    [ Person "Tyler" "1-325-350-7643" "Nec Incorporated" "345-1249 Leo Av." "Montone" "11819" "Oman"
    , Person "Addison" "1-919-396-3444" "Ac Inc." "141-6364 Amet Road" "Coinco" "564821" "Heard Mcdonald Islands"
    , Person "Colin" "1-179-478-8436" "Augue Sed Incorporated" "4450 Consequat Rd." "Piła" "17397" "Kenya"
    , Person "Marsden" "1-121-280-7045" "Nascetur Ridiculus Consulting" "Ap #409-3018 Sed Road" "Merzig" "2707" "Iraq"
    , Person "Aubrey" "1-811-581-0929" "Blandit Industries" "4827 Pellentesque Avenue" "Randazzo" "35463" "Equatorial Guinea"
    , Person "Kylee" "1-652-256-8057" "Lacus Corp." "9009 Laoreet Rd." "Sainte-Marie-Chevigny" "P5G 9K5" "Wallis Futuna"
    , Person "Avye" "1-613-847-4640" "Sed Eu LLP" "Ap #565-6166 Vel Ave" "Juiz de Fora" "71003" "Yemen"
    , Person "Wang" "1-716-808-1478" "Curabitur Massa Vestibulum Ltd" "Ap #608-3841 Per St." "Castello dell Acqua" "21200" "Guinea"
    , Person "Karina" "1-334-358-2328" "Libero Est Institute" "P.O. Box 210 1669 Malesuada Road" "Auburn" "5556" "Mexico"
    , Person "Debra" "1-674-602-3053" "Donec Egestas Industries" "P.O. Box 489 6506 Vel Rd." "Inuvik" "475230" "Turkmenistan"
    , Person "Josiah" "1-256-498-3739" "Aliquam Corp." "4182 Egestas Rd." "Longvilly" "396735" "Isle of Man"
    , Person "Jasper" "1-827-845-5903" "Semper Rutrum Fusce Ltd" "620-8800 Enim Ave" "Campina Grande" "58981" "Macedonia"
    , Person "Ferdinand" "1-867-979-4649" "Enim PC" "P.O. Box 790 9699 Erat. Av." "Frankfurt am Main" "51269" "Suriname"
    , Person "Arsenio" "1-409-812-0418" "Mauris Morbi Non PC" "P.O. Box 931 4528 Pellentesque Street" "Buggenhout" "10608" "Niue"
    , Person "Colt" "1-608-592-3898" "Elit Elit Fermentum Company" "5159 Bibendum. Av." "Rachecourt" "11891" "Saint Kitts"
    , Person "Lars" "1-658-502-1947" "Neque Morbi Inc." "Ap #314-4836 Et Avenue" "Saumur" "482202" "Honduras"
    , Person "Ignacia" "1-847-573-3631" "Eros Corp." "Ap #984-3029 Dolor St." "Bossut-Gottechain" "K8L8G5" "French Polynesia"
    , Person "Cassidy" "1-726-787-7788" "Magna Praesent Interdum Ltd" "970-1817 Elit Rd." "Sibret" "JJ24TH" "Cape Verde"
    , Person "Cally" "1-908-107-5453" "Non Luctus Sit Incorporated" "890 Dui. St." "Jasper" "60416" "Comoros"
    , Person "Hop" "1-167-169-1932" "Sit Institute" "P.O. Box 352 7837 Mus. Rd." "Treguaco" "25036" "Kenya"
    , Person "Jack" "1-121-183-8448" "Mollis Ltd" "Ap #713-7052 Nec Street" "Zierikzee" "2987" "Finland"
    , Person "Germane" "1-562-663-7530" "Per Associates" "P.O. Box 929 4035 Dolor Rd." "Tula" "2415" "Djibouti"
    , Person "Thor" "1-657-155-7481" "Enim Etiam Gravida Inc." "Ap #706-752 Dictum. Road" "Ostrowiec Świętokrzyski" "258868" "Nigeria"
    , Person "Kane" "1-820-440-0811" "Semper Rutrum Associates" "6435 Praesent Street" "Sibret" "63983" "Iran"
    , Person "Kim" "1-244-115-8884" "Lorem Fringilla Ornare Corp." "P.O. Box 150 9911 Maecenas Road" "Raymond" "21609" "Turkish Islands"
    , Person "Colt" "1-420-614-0847" "Nisl Nulla Eu Industries" "Ap #966-1415 Magna Av." "Esneux" "09756" "Togo"
    , Person "Haley" "1-506-668-5036" "Tempus Non Foundation" "P.O. Box 119 5155 Quis St." "Melsele" "04706" "Equatorial Guinea"
    , Person "Ralph" "1-254-537-6541" "Erat LLP" "305-8188 Quam. St." "Chiguayante" "5289" "Mauritius"
    , Person "Hoyt" "1-811-651-9830" "Nam Incorporated" "P.O. Box 834 6620 Amet St." "Quillón" "61814" "Mauritania"
    , Person "Larissa" "1-115-796-4600" "Odio Tristique Pharetra Industries" "P.O. Box 391 9405 Auctor Avenue" "Swan" "41351" "South Africa"
    , Person "Warren" "1-394-440-0903" "Nec Tempus Scelerisque Company" "8384 Ridiculus Street" "Liverpool" "799203" "Tokelau"
    , Person "Flynn" "1-437-904-7442" "Nunc Id Ltd" "814-3994 Neque Ave" "Amsterdam" "79610" "El Salvador"
    , Person "Merrill" "1-991-142-9657" "Quisque Inc." "155-7795 Lacinia Ave" "Greater Sudbury" "K2Y3X9" "Sudan"

    -- , Person "April" "1-694-311-8548" "Facilisis Limited" "Ap #319-9403 Ante Road" "Meerhout "35172" "South "Africa"
    -- , Person "Lucius" "1-368-606-8564" "Et Institute" "Ap #141-9332 Sit Road" "Saint "Andr�" "03405" "Tunisia"
    -- , Person "Marvin" "1-392-397-5931" "Aliquet Nec Limited" "Ap #384-585 Amet Ave" "Notre-Dame-du "Nord" "6068" "Senegal"
    -- , Person "Ezra" "1-569-850-9463" "Nec Diam Ltd" "Ap #376-113 Cum Road "Bamberg" "7750" "Anguilla"
    -- , Person "Christopher" "1-473-850-2953" "Senectus Limited" "Ap #845-1463 Sem Street "Panketal" "06750" "Tunisia"
    -- , Person "Plato" "1-259-741-4987" "Et Libero Corp." "Ap #371-1519 Faucibus St. "Pievepelago" "550777" "Kiribati"
    -- , Person "Rina" "1-988-740-2483" "Nullam Feugiat LLP" "P.O. Box 184 594 Ut Ave "Cuglieri" "6495" "Niger"
    -- , Person "Chaim" "1-341-496-0910" "Ac Inc." "3257 Ut Street" "Cirencester "73094" "Norfolk "Island"
    -- , Person "Kane" "1-139-889-1564" "Mauris Incorporated" "Ap #231-6430 Blandit Road" "Lowell "77297" "Saint "Lucia"
    -- , Person "Madonna" "1-897-813-6665" "Interdum Libero Dui PC" "P.O. Box 285 6311 Massa. Rd. "Morvi" "4685" "Niue"
    -- , Person "Imelda" "1-272-752-5334" "Ac Fermentum LLC" "P.O. Box 971 2796 Hendrerit Ave" "Dover "I95  "1OI" "Slovenia"
    -- , Person "Nicholas" "1-262-328-5589" "Sit Amet Ante Associates" "P.O. Box 816 9285 Egestas Road" "Santa María "QF6  "0UV" "Barbados"
    -- , Person "Cailin" "1-336-278-3146" "Elit Company" "613-1919 Sed Rd. "Grantham" "56569" "Eritrea"
    -- , Person "Edward" "1-621-571-3072" "Mauris Molestie Pharetra Company" "P.O. Box 611 8181 Tortor Rd. "Dieppe" "07979" "Curaçao"
    -- , Person "Jerome" "1-611-521-4396" "Nibh Sit Amet Incorporated" "271-9490 Nonummy Rd." "Buren" "L9A "9C8" "Guinea"-"Bissau"
    -- , Person "Griffith" "1-762-255-1121" "Nam Consequat Dolor Associates" "P.O. Box 752 5920 Lorem Street" "Sommariva "Perno" "4240" "Vanuatu"
    -- , Person "Mari" "1-210-918-3632" "Id Risus Quis Inc." "911-4898 Neque Rd. "Vucht" "50360" "Zimbabwe"
    -- , Person "Rae" "1-491-161-4799" "Eu Augue Consulting" "Ap #701-753 Ut St." "Ponti "23515" "American "Samoa"
    -- , Person "Britanney" "1-463-465-3723" "Et Eros Proin Foundation" "6659 Leo. Road" "Izmir "4444" "South "Africa"
    -- , Person "Levi" "1-908-728-5753" "Tincidunt Tempus Risus Inc." "148-8774 Posuere St." "Rionero in Vulture "40861" "New "Zealand"
    -- , Person "Colin" "1-743-727-2904" "Cum Sociis Natoque Consulting" "7098 Sit Road" "Gerpinnes "8267" "Faroe "Islands"
    -- , Person "Benjamin" "1-552-955-1425" "Interdum Corp." "Ap #473-1683 Praesent Avenue" "Priero "24267" "282" "Barbados"
    -- , Person "Theodore" "1-444-963-4712" "Convallis Company" "963-5823 Luctus Road" "Oudegem "Y8T  "3W6" "Australia"
    -- , Person "Donna" "1-220-889-7062" "Nibh Limited" "Ap #866-5818 Ut Ave" "Buckley" "22-006 "Trinidad  "and "Tobago"
    -- , Person "Burke" "1-856-505-5592" "Magna A Industries" "Ap #866-1621 Ligula Ave "Narbonne" "1028" "Malaysia"
    -- , Person "Idola" "1-403-991-5423" "Mi Duis Inc." "P.O. Box 728 9708 Fringilla Avenue" "King's Lynn "91970" "Korea "North"
    -- , Person "Hanna" "1-392-836-7179" "Lectus Pede Company" "449-3515 Magna Rd." "Cuglieri "98951" "Falkland "Islands"
    -- , Person "Arsenio" "1-437-375-9061" "Maecenas Libero Est Company" "P.O. Box 370 6747 Et Rd." "Stony Plain "86457" "024" "Mauritius"
    -- , Person "Sigourney" "1-597-129-1630" "Velit Justo Industries" "5758 Pellentesque. St. "Ortacesus" "13413" "Guernsey"
    -- , Person "Nayda" "1-101-124-3374" "Integer LLC" "Ap #595-344 Et Road "Khanewal" "87610" "Iceland"
    -- , Person "Madeson" "1-705-306-4853" "Dolor Tempus LLP" "357-9280 Eu Rd." "Montoggio" "537743 "Northern  "Mariana "Islands"
    -- , Person "Ian" "1-988-905-0861" "Proin Inc." "Ap #684-8307 Ultricies Rd." "Fontecchio "19394" "Bouvet "Island"
    -- , Person "Rooney" "1-205-474-1049" "Morbi Associates" "333-2839 Nunc. Street "Heusweiler" "058374" "Kuwait"
    -- , Person "Molly" "1-363-857-0060" "Venenatis Institute" "P.O. Box 115 1973 Lacinia. Rd. "Comox" "5047" "Haiti"
    -- , Person "Penelope" "1-913-947-4018" "Enim Commodo Hendrerit Ltd" "P.O. Box 997 1459 Luctus Rd." "Montigny-le-Tilleul "A7Z  "5N9" "Guernsey"
    -- , Person "Nita" "1-306-720-8419" "Sem Ut Ltd" "P.O. Box 939 7842 Gravida Av." "Subiaco" "0073 "VK" "Guinea"-"Bissau"
    -- , Person "Hayden" "1-416-302-8399" "Ipsum Cursus Consulting" "Ap #672-1153 Purus Av." "Santa "Cruz" "46921" "Palau"
    -- , Person "Deirdre" "1-958-776-6141" "Sem Elit PC" "1718 Interdum Road" "Perchtoldsdorf "07" "784" "Guernsey"
    -- , Person "Benedict" "1-220-712-3743" "Aliquam Enim PC" "2604 Sed Ave" "Fort Smith "730355" "Viet "Nam"
    -- , Person "Kuame" "1-136-811-2828" "Malesuada Augue Ut Limited" "754-2140 Eget Rd." "Forchies-la "Marche" "4113" "Niger"
    -- , Person "Garrison" "1-287-704-3421" "Sed Eu Nibh Corp." "5665 Orci St." "Dokkum" "6640 "IV" "Equatorial "Guinea"
    -- , Person "Blaine" "1-372-256-4245" "Praesent Eu LLP" "6045 Aliquam Rd." "Esneux "KO65  "0ZA" "Tuvalu"
    -- , Person "Lane" "1-724-270-5206" "In At Industries" "3388 Nunc Avenue" "Duns "86015" "Saint "Lucia"
    -- , Person "Gisela" "1-288-250-9990" "Dolor Consulting" "2623 Risus. Street "Bahraich" "7685" "Philippines"
    -- , Person "Nina" "1-640-909-2365" "Nonummy Ut Molestie Foundation" "Ap #225-6238 Elit. St. "Bloomington" "37573" "Antarctica"
    -- , Person "Blaine" "1-937-865-2804" "Vel Corporation" "518-3921 Elit Avenue "Bungay" "6346" "Uzbekistan"
    -- , Person "Paula" "1-655-294-9329" "Pede Nunc Inc." "P.O. Box 114 3531 Ipsum Rd." "St. "Pölten" "97384" "Singapore"
    -- , Person "Isabelle" "1-519-948-7191" "Nisi Magna Foundation" "257-4274 Sed Rd. "Siquirres" "07075" "Cameroon"
    -- , Person "Raphael" "1-338-706-2394" "Enim Mauris Inc." "P.O. Box 928 5444 Suspendisse Rd." "Serik" "702260 "Bosnia  "and "Herzegovina"
    -- , Person "Haley" "1-930-427-4613" "Ultricies Adipiscing LLP" "Ap #671-2951 Orci Rd. "Rengo" "25673" "Jamaica"
    -- , Person "Edan" "1-227-883-6232" "At Foundation" "Ap #875-7923 Non Rd." "Saint "L�onard" "33583" "Zimbabwe"
    -- , Person "Debra" "1-427-397-0604" "A Company" "2512 Tristique Ave" "Huntsville "70755" "Saint "Barthélemy"
    -- , Person "Amelia" "1-669-155-7599" "Nec Ante LLC" "P.O. Box 716 339 Nulla Ave "Aalbeke" "30155" "Iraq"
    -- , Person "Tatum" "1-302-413-0118" "Ac Mattis Velit Limited" "2277 Lacus Road "Latisana" "36084" "Paraguay"
    -- , Person "Whitney" "1-295-797-6797" "Magnis Foundation" "Ap #822-3720 Ipsum Av." "Musson "01" "138" "Serbia"
    -- , Person "Vaughan" "1-302-537-4260" "Vitae Purus Inc." "Ap #632-6243 In St." "Ballarat "08734" "New "Caledonia"
    -- , Person "Tasha" "1-162-241-4505" "Libero Consulting" "626-5613 Mauris St. "Flint" "1836" "Laos"
    -- , Person "Mohammad" "1-438-954-3979" "Ac Orci Institute" "Ap #186-4203 Auctor Rd. "Schellebelle" "769040" "Algeria"
    -- , Person "Holmes" "1-490-386-7135" "Nullam Feugiat Limited" "298-9221 Sociosqu St. "Malbaie" "2334" "Guinea"
    -- , Person "Abel" "1-877-394-0030" "Gravida Sagittis Corp." "Ap #865-5623 Nisl. Avenue "Reading" "41873" "Mongolia"
    -- , Person "Igor" "1-527-706-5135" "Lorem Ltd" "P.O. Box 976 2288 A St." "Wimmertingen" "E0T 9M7" "Heard Island "and  "Mcdonald "Islands"
    -- , Person "Farrah" "1-956-547-3701" "Mollis Vitae Associates" "P.O. Box 465 9139 Porttitor St. "Beausejour" "56232" "Gibraltar"
    -- , Person "Wilma" "1-312-310-6964" "Morbi Non Sapien Foundation" "P.O. Box 132 2542 Malesuada Av. "Swan" "9989" "Slovakia"
    ]
